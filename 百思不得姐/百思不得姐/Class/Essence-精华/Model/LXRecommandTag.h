//
//  LXRecommandTag.h
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXRecommandTag : NSObject

@property (nonatomic, copy) NSString *image_list;

@property (nonatomic, copy) NSString *theme_id;

@property (nonatomic, copy) NSString *theme_name;

@property (nonatomic, assign) NSInteger is_sub;

@property (nonatomic, assign) NSInteger is_default;

@property (nonatomic, assign) NSInteger sub_number;

@end
