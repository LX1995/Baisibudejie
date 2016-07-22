//
//  LXMeViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXMeViewController.h"
#import "LXMineFooterView.h"
#import "LXMineCell.h"

#import "PrefixHeader.pch"
#import "UIBarButtonItem+LXExtension.h"

static NSString *mineID = @"mine";

@interface LXMeViewController ()

@end

@implementation LXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
}

-(void)setupNav {
    self.view.backgroundColor = LXGlobalBg;
    //设置导航栏内容
    self.navigationItem.title = @"我的";
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_coin_icon" highImage:@"nav_coin_icon_click" target:self action:@selector(coinButtonClick)];
    
    //导航栏右边的按钮
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonClick)], [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonButtonClick)]];
}

-(void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LXMineCell class] forCellReuseIdentifier:mineID];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = LXTopicCellMargin;
    //往上移动 25
    self.tableView.contentInset = UIEdgeInsetsMake(LXTopicCellMargin - 35, 0, 0, 0);
    //设置footerView
    self.tableView.tableFooterView = [[LXMineFooterView alloc] init];
}

#pragma mark 导航栏左边的按钮点击
-(void)coinButtonClick {
    LXLogFunc;
}

#pragma mark 导航栏夜间模式按钮点击
-(void)moonButtonClick {
    LXLogFunc;
}

#pragma mark 导航栏右边设置的按钮点击
-(void)settingButtonClick {
    LXLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineID];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
