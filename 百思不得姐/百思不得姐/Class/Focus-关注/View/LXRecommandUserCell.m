//
//  LXRecommandUserCell.m
//  百思不得姐
//
//  Created by 李想 on 16/7/26.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXRecommandUserCell.h"
#import "LXRecommandUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+LXExtension.h"
#import "UIImageView+LXExtension.h"

@interface LXRecommandUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end

@implementation LXRecommandUserCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setUser:(LXRecommandUser *)user {
    
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    if (user.fans_count < 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    } else {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }
    
    [self.headerImageView setCircleHeader:user.header];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
