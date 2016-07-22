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

//针对点击控制器view，系统自动调用下面方法，
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self.textField resignFirstResponder];//点击空白处关某一个键盘-------------------------**
    
    //通知文本框所属的父视图结束编辑状态，父视图就会将其中包含的所有文本框一一放弃第一响应者
    
    [self.view endEditing:YES];//关闭任意文本框的键盘----------------------------------------**
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
