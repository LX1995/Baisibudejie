//
//  LXTabbar.m
//  百思不得姐
//
//  Created by 李想 on 16/7/15.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXTabbar.h"

#import "UIView+LXExtension.h"

@interface LXTabbar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation LXTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        //设置发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

-(void)publishButtonClick {
    //[LXPublishView show];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    //设置发布按钮frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他按钮的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //如果是系统的按钮，继续执行
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        //        if (!button isKindOfClass:[UIControl class] || self.publishButton) continue;
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //索引+1
        index ++;
    }
}

@end
