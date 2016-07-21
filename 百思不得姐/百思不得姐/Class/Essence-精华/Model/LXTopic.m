//
//  LXTopic.m
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXTopic.h"

#import "NSDate+LXExtension.h"
#import <MJExtension.h>
#import "LXComment.h"
#import "LXUser.h"

#import "PrefixHeader.pch"

@implementation LXTopic {
    CGFloat _cellHeight;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"top_cmt" : @"top_cmt[0]",
             @"qzone_uid" : @"top_cmt[0].user.qzone_uid"
             };
}

+(NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt" : @"YMComment"};
}

-(NSString *)create_time  {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //创建时间
    NSDate  *createDate = [fmt dateFromString:_create_time];
    //当前时间
    NSDate *now = [NSDate date];
    
    //日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calender components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { //今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) {
            if (comps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)comps.hour];
            } else if (comps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)comps.minute];
            } else {
                return @"刚刚";
            }
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { //不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [fmt stringFromDate:createDate];
    }
}

-(CGFloat)cellHeight {
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LXTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        // 文字部分的高度
        _cellHeight = LXTopicCellTextY + textH + LXTopicCellMargin;
        //根据段子的类型来计算cell的高度
        if (self.type == LXTopicTypePicture) { //图片帖子
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= LXTopicCellPictureMaxH) { //图片高度过长
                pictureH = LXTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            
            //计算图片控件的frame
            CGFloat pictureX = LXTopicCellMargin;
            CGFloat pictureY = LXTopicCellTextY + textH + LXTopicCellMargin * 2;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            //图片的高度
            _cellHeight += pictureH + LXTopicCellMargin;
        } else if (self.type == LXTopicTypeVoice) { //声音帖子
            CGFloat voiceX = LXTopicCellMargin;
            CGFloat voiceY = LXTopicCellTextY + textH + LXTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + LXTopicCellMargin;
        } else if (self.type == LXTopicTypeVideo) { //视频帖子
            CGFloat videoX = LXTopicCellMargin;
            CGFloat videoY = LXTopicCellTextY + textH + LXTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + LXTopicCellMargin;
        }
        
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@:%@", self.top_cmt.user.username, self.top_cmt];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
            _cellHeight += LXTopicCellCmtTitleH + contentH + LXTopicCellMargin;
        }
        
        //底部的高度
        _cellHeight += LXTopicCellBottomBarH + LXTopicCellMargin;
    }
    return _cellHeight;
}

@end
