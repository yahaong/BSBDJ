//
//  NavigationController.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}
- (void)setup
{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    self.interactivePopGestureRecognizer.delegate = self;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [backButton sizeToFit];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
    }
    [super pushViewController:viewController animated:animated];
}
- (void)backButtonClick
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}
@end
