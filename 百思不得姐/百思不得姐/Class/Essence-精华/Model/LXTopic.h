//
//  LXTopic.h
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXConst.h"
@class LXComment;

@interface LXTopic : NSObject

/** id*/
@property (nonatomic, copy) NSString *ID;
/** 名称*/
@property (nonatomic, copy) NSString *name;
/** 头像*/
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间*/
@property (nonatomic, copy) NSString *create_time;
/** 文字时间*/
@property (nonatomic, copy) NSString *text;
/** 踩的数量*/
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量*/
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量*/
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量*/
@property (nonatomic, assign) NSInteger comment;
/** 是否是新浪加v用户*/
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 图片的宽度*/
@property (nonatomic, assign) CGFloat width;
/** 图片的高度*/
@property (nonatomic, assign) CGFloat height;
/** 小图片路径*/
@property (nonatomic, copy) NSString *small_image;
/** 大图片路径*/
@property (nonatomic, copy) NSString *large_image;
/** 中图片路径*/
@property (nonatomic, copy) NSString *middle_image;
/** 音频时长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长*/
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数*/
@property (nonatomic, assign) int playcount;
/** 视频路径*/
@property (nonatomic, copy) NSString *videouri;
/** 最热评论(存放LXComment数据)*/
@property (nonatomic, strong) LXComment *top_cmt;
/** ctime*/
@property (nonatomic, copy) NSString *qzone_uid;

/******** 额外属性 *********/
/** cell的高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 帖子的类型*/
@property (nonatomic, assign) LXTopicType type;
/** 图片控件的frame*/
@property (nonatomic, assign, readonly) CGRect pictureF;
/** 声音控件的frame*/
@property (nonatomic, assign, readonly) CGRect voiceF;
/** 视频控件的frame*/
@property (nonatomic, assign, readonly) CGRect videoF;
/** 图片控件的frame*/
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 图片下载进度*/
@property (nonatomic, assign) CGFloat pictureProgress;

@end
