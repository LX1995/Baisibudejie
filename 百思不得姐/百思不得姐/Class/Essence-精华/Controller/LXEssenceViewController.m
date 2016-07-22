//
//  LXEssenceViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/15.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXEssenceViewController.h"

#import "LXTopicViewController.h"

#import "LXRecommandTagsViewController.h"

#import "UIBarButtonItem+LXExtension.h"

#import "PrefixHeader.pch"

@interface LXEssenceViewController ()<UIScrollViewDelegate>

//顶部滚动标题下滑线
@property (nonatomic, weak) UIView       *indicatorLine;

//顶部滚动标题视图
@property (nonatomic, weak) UIView       *titlesView;

//选中的按钮
@property (nonatomic, weak) UIButton     *selectedButton;

//子控制器滚动视图（用于左右滚动切换控制器）
@property (nonatomic, weak) UIScrollView *contentScrollView;

@end

@implementation LXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor grayColor];
    
    //子控制器
    [self setUpChildViewController];
    
    //导航栏
    [self setUpNavigation];
    
    //标题视图
    [self setUpTitlesView];
    
    //子控制器滚动视图
    [self setUpContentScrollView];
}

#pragma mark - 子控制器
- (void)setUpChildViewController
{
    LXTopicViewController *allVC = [[LXTopicViewController alloc] init];
    allVC.title = @"全部";
    allVC.type = LXTopicTypeAll;
    [self addChildViewController:allVC];
    
    LXTopicViewController *videoVC = [[LXTopicViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.type = LXTopicTypeVideo;
    [self addChildViewController:videoVC];
    
    LXTopicViewController *voiceVC = [[LXTopicViewController alloc] init];
    voiceVC.title = @"声音";
    voiceVC.type = LXTopicTypeVoice;
    [self addChildViewController:voiceVC];
    
    LXTopicViewController *pictureVC = [[LXTopicViewController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.type = LXTopicTypePicture;
    [self addChildViewController:pictureVC];
    
    LXTopicViewController *wordVC = [[LXTopicViewController alloc] init];
    wordVC.title = @"段子";
    wordVC.type = LXTopicTypeWord;
    [self addChildViewController:wordVC];
}

#pragma mark - 导航栏
- (void)setUpNavigation
{
    self.view.backgroundColor = LXGlobalBg;
    //设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(clickTagButton:)];
    
//    UIImage *leftImage = [[UIImage imageNamed:@"MainTagSubIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UIBarButtonItem *tagButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(clickTagButton:)];
//
//    self.navigationItem.leftBarButtonItem = tagButtonItem;
}

#pragma mark 导航栏左边的按钮点击
- (void)clickTagButton:(UIButton *)tagButtonItem {
    LXRecommandTagsViewController *tagVC = [[LXRecommandTagsViewController alloc] init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

#pragma mark - 标题视图
- (void)setUpTitlesView
{
    //标签栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titlesView.frame = CGRectMake(0, LXTitlesViewY, self.view.width, LXTitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorLine = indicatorView;
    
    //内部子标签
    NSInteger count = self.childViewControllers.count;
    CGFloat width = titlesView.width / count;
    CGFloat height = titlesView.height;
    for (int i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * width;
        button.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            //让按钮内部的Label根据文字来计算内容
            [button.titleLabel sizeToFit];
            self.indicatorLine.width = button.titleLabel.width;
            //            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorLine.centerX = button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

#pragma mark 便签栏按钮点击
- (void)titleClick:(UIButton *)button {
    //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    //让标签执行动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorLine.width = self.selectedButton.titleLabel.width;
        self.indicatorLine.centerX = self.selectedButton.centerX;
    }];
    //滚动,切换子控制器
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = button.tag * self.contentScrollView.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark - 子控制器滚动视图
- (void)setUpContentScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    
    contentScrollView.frame = self.view.bounds;
    
    contentScrollView.delegate = self;
    
    //有几个子控制器就有多少滚动范围
    contentScrollView.contentSize = CGSizeMake(contentScrollView.frame.size.width * self.childViewControllers.count, 0);
    
    contentScrollView.pagingEnabled = YES;
    
    [self.view insertSubview:contentScrollView atIndex:0];
    
    self.contentScrollView = contentScrollView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentScrollView];
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加子控制器的view
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器的y值为0(默认为20)
    vc.view.height = scrollView.height;//设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //点击button
    [self titleClick:self.titlesView.subviews[index]];
}

@end
