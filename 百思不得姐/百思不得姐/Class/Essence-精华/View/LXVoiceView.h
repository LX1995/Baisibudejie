//
//  LXVoiceView.h
//  百思不得姐
//
//  Created by 李想 on 16/7/21.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXTopic;

@interface LXVoiceView : UIView

@property (nonatomic, strong) LXTopic *topic;

+ (instancetype)voiceView;

@end
