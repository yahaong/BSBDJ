//
//  MeViewController.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationView];
}
- (void)setupNavigationView
{
    self.navigationItem.title = @"我";
    UIBarButtonItem *settingItem = [UIBarButtonItem createBarButtonItem:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click-click" target:self action:@selector(settingItemClick)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem createBarButtonItem:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonItemClick)];

    
    self.navigationItem.rightBarButtonItems = @[moonItem, settingItem];
}
- (void)settingItemClick
{
    NSLog(@"settingItemClick");
}
- (void)moonItemClick
{
    NSLog(@"moonItemClick");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
