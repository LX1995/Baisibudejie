//
//  LXCommentHeaderView.m
//  百思不得姐
//
//  Created by 李想 on 16/7/22.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXCommentHeaderView.h"
#import "PrefixHeader.pch"
@interface LXCommentHeaderView ()

/** 文字*/
@property (nonatomic, weak) UILabel *label;

@end

@implementation LXCommentHeaderView

+(instancetype)headerViewTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    LXCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[self alloc] initWithReuseIdentifier:ID];
        
    }
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LXGlobalBg;
        UILabel *label = [[UILabel alloc] init];
        label.x = LXTopicCellMargin;
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textColor = LXColor(67, 67, 67);
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

@end
