//
//  LXCommentViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXCommentViewController.h"

#import "LXTopicCell.h"
#import "LXTopic.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "LXComment.h"
#import "MJExtension.h"
#import "LXCommentHeaderView.h"
#import "LXCommentCell.h"
#import "SVProgressHUD.h"

#import "LXConst.h"
#import "PrefixHeader.pch"
#import "UIBarButtonItem+LXExtension.h"

static NSString *const commentID = @"comment";

@interface LXCommentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//最热评论
@property (nonatomic, strong) NSArray *hotComments;

//最新评论
@property (nonatomic, strong) NSMutableArray *lastestComments;

//保存top_cmt
@property (nonatomic, strong) LXComment *saved_top_cmt;

//保存当前页码
@property (nonatomic, assign) NSInteger page;

//请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation LXCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    //    self.tableView.mj_footer.hidden = YES;
}

-(void)loadNewComments {
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"hot"] = @"1";
    params[@"data_id"] = self.topic.ID;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //页码
        self.page = 1;
        //说明没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        //最热评论
        self.hotComments = [LXComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新
        self.lastestComments = [LXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastestComments.count > total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
    }];
}

-(void)loadMoreComments {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    LXComment *comment = [self.lastestComments lastObject];
    params[@"lastid"] = comment.ID;
    params[@"page"] = @(page);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //说明没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return ;
        }
        
        //最新评论
        NSArray *newComments = [LXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.lastestComments addObjectsFromArray:newComments];
        
        [self.tableView reloadData];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastestComments.count > total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else { //数据满了，结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
    }];
}

-(void)setupHeader {
    UIView *header = [[UIView alloc] init];
    
    //清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    LXTopicCell *cell = [LXTopicCell cell];
    cell.topic = self.topic;;
    cell.height = self.topic.cellHeight;
    cell.width = SCREENW;
    [header addSubview:cell];
    header.height = self.topic.cellHeight + LXTopicCellMargin;
    self.tableView.tableHeaderView = header;
    self.tableView.backgroundColor = LXGlobalBg;
}

-(void)setupBasic {
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXCommentCell class]) bundle:nil] forCellReuseIdentifier:commentID];
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

-(void)keyboardWillChangeFrame:(NSNotification *)notification {
    //键盘显示/隐藏完毕的frame
//    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.bottomSpace.constant = SCREENH - frame.origin.y;
//    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    //动画
//    [UIView animateWithDuration:duration animations:^{
//        [self.view layoutIfNeeded];
//    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    if (hotCount) return 2; //有最热评论+最新评论  2组
    if (lastestCount) return 1; //最新评论  1组
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    
    tableView.mj_footer.hidden = (lastestCount == 0);
    if (section == 0) {
        return hotCount ? hotCount : self.lastestComments.count;
    }
    return self.lastestComments.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //先从缓存池中找
    LXCommentHeaderView *header = [LXCommentHeaderView headerViewTableView:tableView];
    
    if (section == 0) {
        header.title = self.hotComments.count ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"评论";
    }
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

/**
 *  返回第section组的所有评论
 */
-(NSArray *)commentInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.lastestComments;
    }
    return self.lastestComments;
}

-(LXComment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentInSection:indexPath.section][indexPath.row];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //回复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    //取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

-(AFHTTPSessionManager *)manager{
    if (!_manager ) {
        _manager = [[AFHTTPSessionManager alloc] init];
    }
    return _manager;
}

-(NSMutableArray *)lastestComments{
    if (_lastestComments == nil) {
        _lastestComments = [[NSMutableArray alloc] init];
    }
    return _lastestComments;
}

@end
