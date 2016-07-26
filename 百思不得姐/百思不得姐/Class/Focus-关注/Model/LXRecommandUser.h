//
//  LXRecommandUser.h
//  百思不得姐
//
//  Created by 李想 on 16/7/26.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXRecommandUser : NSObject

//头像
@property (nonatomic, copy) NSString *header;

//粉丝数
@property (nonatomic, assign) NSInteger fans_count;

//昵称
@property (nonatomic, copy) NSString *screen_name;

@end
