//
//  LXTopicViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/15.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXTopicViewController.h"
#import "LXTopic.h"
#import "LXTopicCell.h"
#import "LXCommentViewController.h"
#import "UIView+LXExtension.h"
#import "LXNewViewController.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

@interface LXTopicViewController ()

//帖子
@property (nonatomic, strong) NSMutableArray *topics;

//页码
@property (nonatomic, assign) NSInteger page;

//当加载下一页数据时需要这个参数
@property (nonatomic, copy) NSString *maxtime;

//上一次请求参数
@property (nonatomic, strong) NSDictionary *parmas;

//上一次选中 tabBar 的索引
@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation LXTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setupRefresh];
}

static NSString *const LXTopicCellID = @"topic";

#pragma mark - tableView
- (void)setUpTableView
{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LXTitlesViewY + LXTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXTopicCell class]) bundle:nil] forCellReuseIdentifier:LXTopicCellID];
    
    // 监听 tabBar 点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:LXTabBarDidSelectedNotification object:nil];
}

-(void)tabBarSelected {
    //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
    if (self.lastSelectedIndex != self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    };
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
    
}

#pragma mark 添加刷新控件
-(void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark 数据处理
-(void)loadNewTopics {
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.parmas = params;
    // 发送请求给服务器
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parmas != params) return;
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [LXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //回复页码
        self.page--;
    }];
}

#pragma mark 加载更多数据
-(void)loadMoreTopics {
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    
    self.page ++;
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.parmas = params;
    // 发送请求给服务器
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parmas != params) return;
        
        NSArray *newTopics = [LXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - a 参数
-(NSString *)aParam {
    return [self.presentationController isKindOfClass:[LXNewViewController class]] ? @"newList" : @"list";
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //取出帖子模型
    LXTopic *topic = self.topics[indexPath.row];
    //返回这个cell对应的高度
    return topic.cellHeight;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:LXTopicCellID];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LXCommentViewController *commetnVC = [[LXCommentViewController alloc] init];
    //commetnVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commetnVC animated:YES];
}

-(NSMutableArray *)topics{
    if (_topics == nil) {
        _topics = [[NSMutableArray alloc] init];
    }
    return _topics;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
