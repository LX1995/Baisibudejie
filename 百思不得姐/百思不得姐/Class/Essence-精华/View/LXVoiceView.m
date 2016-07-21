//
//  LXVoiceView.m
//  百思不得姐
//
//  Created by 李想 on 16/7/21.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXVoiceView.h"
#import "LXTopic.h"
#import "UIImageView+WebCache.h"
#import "MJRefreshAutoFooter.h"

@interface LXVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UIButton *playButton;


@end

@implementation LXVoiceView

- (void)setTopic:(LXTopic *)topic {
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    //时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

+ (instancetype)voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    //如果发现控件的位置和尺寸不是自己设置的，那么有可能是自动伸缩属性导致
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setPlayButton:(UIButton *)playButton {
    _playButton = playButton;
    [self.playButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    [self.playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateSelected];
}

- (IBAction)playButtonClick:(id)sender {
    //sender.hidden = YES;
}

@end
