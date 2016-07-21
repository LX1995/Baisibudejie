//
//  LXVideoView.h
//  百思不得姐
//
//  Created by 李想 on 16/7/20.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXTopic;

@interface LXVideoView : UIView

@property (nonatomic, strong) LXTopic *topic;

+ (instancetype)videoView;

@end
