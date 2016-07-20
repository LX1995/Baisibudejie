//
//  LXConst.m
//  百思不得姐
//
//  Created by 李想 on 16/7/15.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>

CGFloat const LXTitlesViewH = 35;
CGFloat const LXTitlesViewY = 64;

CGFloat const LXTopicCellMargin = 10;
CGFloat const LXTopicCellTextY = 70;
CGFloat const LXTopicCellBottomBarH = 44;

/** 精华-cell-图片帖子的最大高度*/
CGFloat const LXTopicCellPictureMaxH = 1000;
/** 精华-cell-图片帖子的一旦超过最大高度，就用Break*/
CGFloat const LXTopicCellPictureBreakH = 250;

/** 用户模型性别属性值-男*/
NSString *const LXUserSexMale = @"m";
/** 用户模型性别属性值-女*/
NSString *const LXUserSexFamale = @"f";
/** 最热评论标题的高度*/
CGFloat const LXTopicCellCmtTitleH = 20;
/** tabBar 被点击的通知*/
NSString *const LXTabBarDidSelectedNotification = @"LXTabBarDidSelectedNotification";
/** tabBar 被点击的通知 - 被点击的控制器的 index key*/
NSString *const LXSelectedControllerIndexKey = @"LXSelectedControllerIndexKey";
/** tabBar 被点击的通知 - 被点击的控制器 key*/
NSString *const LXSelectedControllerKey = @"LXSelectedControllerKey";