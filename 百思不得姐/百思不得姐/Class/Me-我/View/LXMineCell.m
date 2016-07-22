//
//  LXMineCell.m
//  百思不得姐
//
//  Created by 李想 on 16/7/22.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXMineCell.h"
#import "PrefixHeader.pch"

@implementation LXMineCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + LXTopicCellMargin;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
