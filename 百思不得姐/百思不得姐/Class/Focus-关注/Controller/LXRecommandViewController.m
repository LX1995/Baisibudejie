//
//  LXRecommandViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/26.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXRecommandViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "LXRecommandCategoryCell.h"
#import "LXRecommandCategory.h"
#import "MJExtension.h"
#import "LXRecommandUserCell.h"
#import "LXRecommandUser.h"
#import "MJRefresh.h"
#import "PrefixHeader.pch"

//左边被选中的类别模型
#define LXSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface LXRecommandViewController ()<UITableViewDelegate, UITableViewDataSource>
//左侧
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
//右侧
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

//左边类别数据
 @property (nonatomic, strong) NSArray *categories;

//请求参数
@property (nonatomic, strong) NSMutableDictionary *params;

//AFN的请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end




@implementation LXRecommandViewController

static NSString * const categoryID = @"category";
static NSString * const userID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件的初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求数据
    [self loadCategoryData];
    
}

#pragma mark 加载左侧类别数据
-(void)loadCategoryData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.categories = [LXRecommandCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.categoryTableView reloadData];
        //隐藏指示器
        [SVProgressHUD dismiss];
        //默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //让用户表格进入刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

#pragma mark 表格控件的初始化
-(void)setupTableView {
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = LXGlobalBg;
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXRecommandCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXRecommandUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    
    self.categoryTableView.tableFooterView = [UIView new];
    self.userTableView.tableFooterView = [UIView new];
    self.userTableView.rowHeight = 70;
    
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
}

#pragma mark 添加刷新控件
-(void)setupRefresh {
    //顶部
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //底部
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark 加载用户数据
-(void)loadNewUsers {
    LXRecommandCategory *category = LXSelectedCategory;
    //设置当前页码为1
    category.currentPage = 1;
    //设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = [LXSelectedCategory ID];
    params[@"page"] = @(category.currentPage);
    self.params = params;
    // 发送请求给服务器,加载右侧数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *users = [LXRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //清除以前所有旧的数据
        [category.users removeAllObjects];
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        //总数
        category.total = responseObject[@"total"];
        //不是最后一次请求
        if (self.params != params) return;
        //刷新表格
        [self.userTableView reloadData];
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        //让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

#pragma mark 加载更多用户数据
-(void)loadMoreUsers {
    LXRecommandCategory *category = LXSelectedCategory;
    //设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.ID;
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    // 发送请求给服务器,加载右侧数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *users = [LXRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        //不是最后一次请求
        if (self.params != params) return;
        //刷新表格
        [self.userTableView reloadData];
        //让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //左边类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    //右边用户表格
    //让底部控件结束刷新
    [self checkFooterState];
    
    return [LXSelectedCategory users].count;
}

#pragma mark 检查底部是否全部加载完毕
-(void)checkFooterState {
    LXRecommandCategory *category = LXSelectedCategory;
    NSInteger count = category.users.count;
    //每次刷新右边数据时，都控制footer显示或隐藏
    self.userTableView.mj_footer.hidden = (count == 0);
    if (count == [category.total integerValue]) { //全部加载完成
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { //还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) {//左边类别表格
        LXRecommandCategoryCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        categoryCell.category = self.categories[indexPath.row];
        return categoryCell;
    } else { //右边用户表格
        LXRecommandUserCell *userCell = [tableView dequeueReusableCellWithIdentifier:userID];
        //左边被选中的类别模型
        userCell.user = [LXSelectedCategory users][indexPath.row];
        return userCell;
    }
}

#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    LXRecommandCategory *category = self.categories[indexPath.row];
    if (category.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    } else {
        //刷新表格，马上显示当前category的用户数据，不要让用户看到上一个数据
        [self.userTableView reloadData];
        //发送请求给服务器
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark 控制器销毁
-(void)dealloc {
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc] init];
    }
    return _manager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
