//
//  LXConst.h
//  百思不得姐
//
//  Created by 李想 on 16/7/15.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    LXTopicTypeAll = 1,
    LXTopicTypePicture = 10,
    LXTopicTypeWord = 29,
    LXTopicTypeVoice = 31,
    LXTopicTypeVideo = 41,
    
}LXTopicType;

//精华 - 标题高度
UIKIT_EXTERN CGFloat const LXTitlesViewH;
//精华 - 标题的Y
UIKIT_EXTERN CGFloat const LXTitlesViewY;

/** 精华-cell的间距*/
UIKIT_EXTERN CGFloat const LXTopicCellMargin;
/** 精华-cell文字的y*/
UIKIT_EXTERN CGFloat const LXTopicCellTextY;
/** 精华-cell底部工具条的高度*/
UIKIT_EXTERN CGFloat const LXTopicCellBottomBarH;
/** 精华-cell-图片帖子的最大高度*/
UIKIT_EXTERN CGFloat const LXTopicCellPictureMaxH;
/** 精华-cell-图片帖子的一旦超过最大高度，就用Break*/
UIKIT_EXTERN CGFloat const LXTopicCellPictureBreakH;
/** 用户模型性别属性值-男*/
UIKIT_EXTERN NSString *const LXUserSexMale;
/** 用户模型性别属性值-女*/
UIKIT_EXTERN NSString *const LXUserSexFamale;
/** 最热评论标题的高度*/
UIKIT_EXTERN CGFloat const LXTopicCellCmtTitleH;
/** tabBar 被点击的通知*/
UIKIT_EXTERN NSString *const LXTabBarDidSelectedNotification;
/** tabBar 被点击的通知 - 被点击的控制器的 index key*/
UIKIT_EXTERN NSString *const LXSelectedControllerIndexKey;
/** tabBar 被点击的通知 - 被点击的控制器 key*/
UIKIT_EXTERN NSString *const LXSelectedControllerKey;