//
//  NSString+LXExtension.h
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LXExtension)

/** 根据秒数计算时间*/
+(NSString *)caculateTimeWithTimeFormatter:(long long)timeSecond;

@end
