//
//  LXSquareButton.m
//  百思不得姐
//
//  Created by 李想 on 16/7/22.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXSquareButton.h"
#import "LXSquare.h"
#import "UIButton+WebCache.h"

#import "PrefixHeader.pch"

@implementation LXSquareButton

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

-(void)awakeFromNib {
    [self setup];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    // 调整图片
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

-(void)setSquare:(LXSquare *)square {
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

@end
