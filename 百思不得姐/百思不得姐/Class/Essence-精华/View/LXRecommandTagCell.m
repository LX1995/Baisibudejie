//
//  LXRecommandTagCell.m
//  百思不得姐
//
//  Created by 李想 on 16/7/20.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXRecommandTagCell.h"
#import "LXRecommandTag.h"
#import "UIImageView+WebCache.h"
#import "UIImage+LXExtension.h"
#import "UIImageView+LXExtension.h"

@interface LXRecommandTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *subscribe;

@end

@implementation LXRecommandTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame {
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

-(void)setRecommandTag:(LXRecommandTag *)recommandTag {
    _recommandTag = recommandTag;
    
    [self.imageListImageView setCircleHeader:recommandTag.image_list];
    self.themeNameLabel.text = recommandTag.theme_name;
    NSString *fansCount = nil;
    if (recommandTag.sub_number < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人订阅",recommandTag.sub_number];
    } else {//>= 10000
        fansCount = [NSString stringWithFormat:@"%.1f万人订阅",recommandTag.sub_number / 10000.0];
    }
    self.subNameLabel.text = fansCount;
}

- (IBAction)subscribe:(id)sender {
    
}
@end
