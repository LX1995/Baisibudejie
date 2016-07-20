//
//  LXCommentViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXCommentViewController.h"

//#import "LXTopicCell.h"
#import "LXTopic.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "LXComment.h"
#import "MJExtension.h"
//#import "LXCommentHeaderView.h"
//#import "LXCommentCell.h"
//#import "SVProgressHUD.h"

#import "LXConst.h"

@interface LXCommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LXCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
