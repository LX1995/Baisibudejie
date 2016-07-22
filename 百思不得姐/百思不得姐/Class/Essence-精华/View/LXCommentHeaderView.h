//
//  LXCommentHeaderView.h
//  百思不得姐
//
//  Created by 李想 on 16/7/22.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXCommentHeaderView : UITableViewHeaderFooterView

//文本
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewTableView:(UITableView *)tableView;

@end
