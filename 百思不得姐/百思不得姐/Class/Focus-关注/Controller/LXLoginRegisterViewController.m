//
//  LXLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/21.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXLoginRegisterViewController.h"

@interface LXLoginRegisterViewController ()

@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LXLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view insertSubview:self.bgView atIndex:0];
}

#pragma mark 当前控制器的状态栏为白色
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLoginOrRegister:(id)sender {
//    //退出键盘
//    [self.view endEditing:YES];
//    
//    if (self.loginViewLeftMargin.constant == 0) { //显示注册界面
//        self.loginViewLeftMargin.constant = -self.view.width;
//        sender.selected = YES;
//    } else {
//        self.loginViewLeftMargin.constant = 0;
//        sender.selected = NO;
//    }
//    [UIView animateWithDuration:0.25 animations:^{
//        [self.view layoutSubviews];
//    }];
}


- (IBAction)exitButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
