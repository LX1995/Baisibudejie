

//
//  LXRecommandCategory.m
//  百思不得姐
//
//  Created by 李想 on 16/7/26.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXRecommandCategory.h"
#import <MJExtension.h>

@implementation LXRecommandCategory

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id"
             };
}

-(NSMutableArray *)users{
    if (_users == nil) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

@end
