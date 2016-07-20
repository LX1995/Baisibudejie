//
//  UIBarButtonItem+LXExtension.h
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LXExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
