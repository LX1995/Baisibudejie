//
//  LXAVPlayerDefine.h
//  百思不得姐
//
//  Created by 李想 on 16/7/21.
//  Copyright © 2016年 李想. All rights reserved.
//

#ifndef LXAVPlayerDefine_h
#define LXAVPlayerDefine_h


#endif /* LXAVPlayerDefine_h */


//整个屏幕代表的时间
#define TotalScreenTime 90
#define LeastDistance 15

//判断是否为ipad设备
#define IsIpad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//获取到window
#define Window [[UIApplication sharedApplication].delegate window]

//用来标记是否调试模式
//#define AvplayerDebug //

#ifdef DEBUG

//根据是否为调试模式, 来开启打印
#ifdef AvplayerDebug
#define AVDLog(content, ...) NSLog((@"函数名: %s [行: %d]" content), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define AVDLog(...) //
#endif

#else
#define AVDLog(...) //
#endif

#define iOS8 [UIDevice currentDevice].systemVersion.floatValue >= 8.0

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)