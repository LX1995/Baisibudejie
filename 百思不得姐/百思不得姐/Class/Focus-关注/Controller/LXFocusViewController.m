//
//  LXFocusViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/21.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXFocusViewController.h"
#import "LXRecommandViewController.h"
#import "LXLoginRegisterViewController.h"
#import "UIBarButtonItem+LXExtension.h"
#import "PrefixHeader.pch"

@interface LXFocusViewController ()


@end

@implementation LXFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LXGlobalBg;
    //设置导航栏内容
    self.navigationItem.title = @"我的关注";
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecButtonClick)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 导航栏左边的按钮点击
-(void)friendsRecButtonClick {
    LXRecommandViewController *recommandVC = [[LXRecommandViewController alloc] init];
    
    [self.navigationController pushViewController:recommandVC animated:YES];
}

- (IBAction)loginRegister:(id)sender {
    LXLoginRegisterViewController *login = [[LXLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
    
}

@end
