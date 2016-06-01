//
//  MeViewController.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "MeViewController.h"
#import "MeCell.h"
#import "MeFooterView.h"
#import "SettingViewController.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationView];
    [self setupTableView];
}

- (void)setupNavigationView
{
    self.navigationItem.title = @"我";
    UIBarButtonItem *settingItem = [UIBarButtonItem createBarButtonItem:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click-click" target:self action:@selector(settingItemClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem createBarButtonItem:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonItemClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}
- (void)setupTableView
{
    self.view.backgroundColor = kCommonBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(kMargin - 35, 0, 0, 0);
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = kMargin;
    MeFooterView *footerView = [[MeFooterView alloc]init];
    self.tableView.tableFooterView = footerView;
    
}
- (void)settingItemClick
{
    SettingViewController *settingVc = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
- (void)moonItemClick
{
    NSLog(@"moonItemClick");
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    MeCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else if (indexPath.section == 1)
    {
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (2 == indexPath.section) {
        return 200.0f;
    }
    return 44.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
