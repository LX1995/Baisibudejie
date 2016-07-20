//
//  NSDate+LXExtension.h
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LXExtension)

//判断某个时间是否为今年
-(BOOL)isThisYear;

//判断是否为昨天
-(BOOL)isYesterday;

//判断是否为今天
-(BOOL)isToday;

@end
