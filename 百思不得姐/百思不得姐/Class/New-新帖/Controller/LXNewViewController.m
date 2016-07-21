//
//  LXNewViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/21.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXNewViewController.h"
#import "PrefixHeader.pch"
#import "UIBarButtonItem+LXExtension.h"
@interface LXNewViewController ()

@end

@implementation LXNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LXGlobalBg;
    //设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagButtonClick)];
}

#pragma mark 导航栏左边的按钮点击
-(void)tagButtonClick {
    LXLog(@"%s",__func__);
}

@end
