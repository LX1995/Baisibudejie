//
//  LXSetViewController.m
//  百思不得姐
//
//  Created by 李想 on 16/7/27.
//  Copyright © 2016年 李想. All rights reserved.
//

#import "LXSetViewController.h"

@interface LXSetViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LXSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableView];
    
    self.navigationItem.title = @"设置";
    
    NSString *a = @"2222";
//    NSString * path = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/ImageCaches"];
//    NSDictionary * dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
//    NSLog(@"缓存缓存缓存缓存缓存缓存缓存缓存%@",[dict objectForKey:NSFileSize]);
}

- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}



#pragma mark - 三问一答
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
            
        case 1:
            return 7;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSString *b = @"sihhsh";
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"字体大小";
            }else{
                cell.textLabel.text = @"摇一摇夜间模式";
                UISwitch *rightSwitch = [[UISwitch alloc] init];
                [cell addSubview:rightSwitch];
                cell.accessoryView = rightSwitch;
            }
            break;
            
        case 1:
            if (indexPath.row == 0) {
                cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(已使用%@MB)", b];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边小箭头
            }else if (indexPath.row == 1) {
                cell.textLabel.text=@"推荐给朋友";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边小箭头
            }else if (indexPath.row == 2) {
                cell.textLabel.text = @"帮助";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边小箭头
            }else if (indexPath.row == 3) {
                cell.textLabel.text = @"当前版本：4.3";
            }else if (indexPath.row == 4) {
                cell.textLabel.text = @"关于我们";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边小箭头
            }else if (indexPath.row == 5) {
                cell.textLabel.text = @"隐私政策";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边小箭头
            }else if (indexPath.row == 6) {
                cell.textLabel.text = @"打分支持不得姐！";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边小箭头
            }
            
        default:
            break;
    }
    
    return cell;
}



#pragma mark - 分区头标题

// 设置分区头部文字
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] init];
//    
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width - 15, 20)];
//    lab.font = [UIFont systemFontOfSize:15];
//    lab.text = @"功能设置";
//    //lab.textColor = kTitleDarkColor;
//    [view addSubview:lab];
//    
//    return view;
//}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            return @"功能设置";
            //header.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
            
        case 1:
            return @"其他";
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 44;
    }
    else
    {
        return 44;
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
            
        case 1:
            return 0;
            
        default:
            break;
    }
    
    return 0;
}

@end
