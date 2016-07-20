//
//  LXTopicCell.m
//  百思不得姐
//
//  Created by 李想 on 16/7/18.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXTopicCell.h"
#import "LXTopic.h"
#import "UIImageView+WebCache.h"
//#import "LXTopicPictureView.h"
//#import "LXVoiceView.h"
//#import "LXVideoView.h"
#import "LXComment.h"
#import "LXUser.h"
#import "UIImage+LXExtension.h"
#import "UIImageView+LXExtension.h"

@interface LXTopicCell ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//创建时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
//顶
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
//踩
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
//分享
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
//评论
@property (weak, nonatomic) IBOutlet UIButton *commentBuuton;
//新浪加V
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
//帖子内容文字
@property (weak, nonatomic) IBOutlet UILabel *text_label;
//最热评论内容文字
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
//最热评论整个view
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

////图片帖子中间的内容
//@property (nonatomic, weak) LXTopicPictureView *pictureView;
////声音帖子中间的内容
//@property (nonatomic, weak) LXVoiceView *voiceView;
////视频帖子中间的内容
//@property (nonatomic, weak) LXVideoView *videoView;

@end

@implementation LXTopicCell

+(instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(LXVideoView *)videoView{
//    if (_videoView  == nil) {
//        LXVideoView *videoView = [LXVideoView videoView];
//        [self.contentView addSubview:videoView];
//        _videoView = videoView;
//    }
//    return _videoView;
//}
//
//-(LXVoiceView *)voiceView{
//    if (_voiceView == nil) {
//        LXVoiceView *voiceView = [LXVoiceView voiceView];
//        [self.contentView addSubview:voiceView];
//        _voiceView = voiceView;
//    }
//    return _voiceView;
//}
//
//-(LXTopicPictureView *)pictureView{
//    if (_pictureView == nil) {
//        LXTopicPictureView *pictureView = [LXTopicPictureView pictureView];
//        [self.contentView addSubview:pictureView];
//        _pictureView = pictureView;
//    }
//    return _pictureView;
//}
//
-(void)setTopic:(LXTopic *)topic {
    _topic = topic;
    //新浪加V
    self.sina_vImageView.hidden = !topic.sina_v;
    //设置头像
    [self.profileImageView setCircleHeader:topic.profile_image];
    //设置名字
    self.nameLabel.text = topic.name;
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    //设置帖子的文字内容
    self.text_label.text = topic.text;
    
    //设置按钮的文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentBuuton count:topic.comment placeholder:@"评论"];
    
    //根据模型类型（帖子类型）添加到对应的内容cell中间
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
//    if (topic.type == LXTopicTypePicture) { // 图片帖子
//        self.pictureView.hidden = NO;
//        self.pictureView.topic = topic;
//        self.pictureView.frame = topic.pictureF;
//        
//        self.voiceView.hidden = YES;
//        self.videoView.hidden = YES;
//    } else if (topic.type == LXTopicTypeVoice) { // 声音帖子
//        self.voiceView.hidden = NO;
//        self.voiceView.topic = topic;
//        self.voiceView.frame = topic.voiceF;
//        
//        self.pictureView.hidden = YES;
//        self.videoView.hidden = YES;
//    } else if (topic.type == LXTopicTypeVideo) { // 视频帖子
//        self.videoView.hidden = NO;
//        self.videoView.topic = topic;
//        self.videoView.frame = topic.videoF;
//        
//        self.voiceView.hidden = YES;
//        self.pictureView.hidden = YES;
//    } else { // 段子帖子
//        self.videoView.hidden = YES;
//        self.voiceView.hidden = YES;
//        self.pictureView.hidden = YES;
//    }
    //处理最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        //self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@:%@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
}

-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame {
    
    frame.origin.x = LXTopicCellMargin;
    frame.size.width -= 2 * LXTopicCellMargin;
    frame.size.height = self.topic.cellHeight - LXTopicCellMargin;
    frame.origin.y += LXTopicCellMargin;
    
    [super setFrame:frame];
}
- (IBAction)more:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
}

@end
