//
//  LXTabbarController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/15.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXTabbarController.h"
#import "LXNavigationController.h"
#import "LXEssenceViewController.h"
#import "LXNewViewController.h"
#import "LXFocusViewController.h"
#import "LXMeViewController.h"
#import "LXTabbar.h"

@interface LXTabbarController ()

@end

@implementation LXTabbarController

+ (void)initialize {
    
    //设置tabbar点击字体颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    //通过appearance统一设置tabbarItem的样式
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self setChildController:[[LXEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setChildController:[[LXNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setChildController:[[LXFocusViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];

    [self setChildController:[[LXMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    //设置tabBar
    [self setValue:[[LXTabbar alloc] init] forKey:@"tabBar"];
}

//初始化子控制器
//@param vc            控制器
//@param title         名称
//@param image         默认图片
//@param selectedImage 选中图片
- (void)setChildController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    //设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //包装一个导航控制器，添加导航控制器为tabbarController的子控制器
    LXNavigationController *nav = [[LXNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
