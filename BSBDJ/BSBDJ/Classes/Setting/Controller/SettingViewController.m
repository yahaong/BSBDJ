//
//  SettingViewController.m
//  BSBDJ
//
//  Created by Yahaong on 16/5/30.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "SettingViewController.h"
#import "CleanViewCell.h"
@interface SettingViewController ()

@end


static NSString *const kCleanCellReuseIdentifier = @"kCleanCellReuseIdentifier";
@implementation SettingViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCommonBgColor;
    self.navigationItem.title = @"设置";
    [self.tableView registerClass:[CleanViewCell class] forCellReuseIdentifier:kCleanCellReuseIdentifier];
}


- (void)getCacheSize
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CleanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCleanCellReuseIdentifier];

    DLog(@"%@",NSHomeDirectory());
    return cell;
}

@end
