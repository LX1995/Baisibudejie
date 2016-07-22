//
//  LXCommentCell.m
//  百思不得姐
//
//  Created by 李想 on 16/7/22.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXCommentCell.h"
#import "LXComment.h"
#import "LXUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+LXExtension.h"
#import "UIImageView+LXExtension.h"
#import "LXConst.h"

@interface LXCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexView;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end

@implementation LXCommentCell

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

- (void)setComment:(LXComment *)comment {
    _comment = comment;
    
    [self.profileImageView setCircleHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:LXUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = LXTopicCellMargin;
    frame.size.width -= 2 * LXTopicCellMargin;
    [super setFrame:frame];
}

@end
