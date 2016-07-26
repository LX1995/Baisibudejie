//
//  LXTextField.m
//  百思不得姐
//
//  Created by 李想 on 16/7/26.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXTextField.h"

@implementation LXTextField

static NSString *const LXPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

-(void)awakeFromNib {
    //修改占位符文字颜色
    //    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

/**
 *  当前文本框聚焦时就会调用
 */
-(BOOL)becomeFirstResponder {
    //修改占位符文字颜色
    [self setValue:self.textColor forKeyPath:LXPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时就会调用
 */
-(BOOL)resignFirstResponder {
    //修改占位符文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:LXPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
