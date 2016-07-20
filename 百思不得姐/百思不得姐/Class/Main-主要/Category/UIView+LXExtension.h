//
//  UIView+LXExtension.h
//  百思不得姐
//
//  Created by 李想 on 16/7/15.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LXExtension)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

@end
