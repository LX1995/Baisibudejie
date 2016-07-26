//
//  LXLightView.h
//  百思不得姐
//
//  Created by 李想 on 16/7/26.
//  Copyright © 2016年 李想. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXLightView : UIView
@property (weak, nonatomic) IBOutlet UIView *lightBackView;

@property (nonatomic, strong) NSMutableArray * lightViewArr;

-(void)changeLightViewWithValue:(float)lightValue;

@end
