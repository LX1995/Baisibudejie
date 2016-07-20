//
//  NSString+LXExtension.m
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "NSString+LXExtension.h"

@implementation NSString (LXExtension)

/**
 *  根据秒数计算时间
 */
+(NSString *)caculateTimeWithTimeFormatter:(long long)timeSecond {
    NSString *lastTime = nil;
    if (timeSecond < 60) {
        lastTime = [NSString stringWithFormat:@"00:%.2lld", timeSecond];
    } else if (timeSecond >= 60 && timeSecond < 3600) {
        lastTime = [NSString stringWithFormat:@"%.2lld:%.2lld", timeSecond / 60, timeSecond % 60];
    } else if (timeSecond >= 3600) {
        lastTime = [NSString stringWithFormat:@"%.2lld:%.2lld:%.2lld", timeSecond / 3600, timeSecond % 3600 / 60, timeSecond % 60];
    }
    return lastTime;
}

@end
