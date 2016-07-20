//
//  LXUser.h
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXUser : NSObject

/** 用户名*/
@property (nonatomic, copy) NSString *username;
/** 性别*/
@property (nonatomic, copy) NSString *sex;
/** 头像*/
@property (nonatomic, copy) NSString *profile_image;

@end
