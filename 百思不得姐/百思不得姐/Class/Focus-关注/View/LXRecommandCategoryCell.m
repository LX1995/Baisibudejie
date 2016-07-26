//
//  LXRecommandCategoryCell.m
//  百思不得姐
//
//  Created by 李想 on 16/7/26.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXRecommandCategoryCell.h"
#import "LXRecommandCategory.h"
#import "PrefixHeader.pch"

@interface LXRecommandCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicater;


@end

@implementation LXRecommandCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = LXColor(244, 244, 244);
    self.selectedIndicater.backgroundColor = LXColor(219, 21, 26);
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicater.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedIndicater.backgroundColor: LXColor(78, 78, 78);
}

-(void)setCategory:(LXRecommandCategory *)category {
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height -2 * self.textLabel.y;
}



@end
