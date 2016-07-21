//
//  LXComment.h
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXUser;

@interface LXComment : NSObject

//ID
@property (nonatomic, copy)   NSString  *ID;

//音频文件的时长
@property (nonatomic, assign) NSInteger voiceTime;

//音频文件的路径
@property (nonatomic, copy)   NSString  *voiceURL;

//评论的文字内容
@property (nonatomic, copy)   NSString  *contentWord;

//被点赞的数量
@property (nonatomic, assign) NSInteger like_count;

//用户
@property (nonatomic, strong) LXUser    *user;

@end
