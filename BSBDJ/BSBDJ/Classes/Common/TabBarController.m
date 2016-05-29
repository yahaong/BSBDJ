//
//  TabBarController.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "TabBar.h"
@interface TabBarController ()

@end

@implementation TabBarController

+ (void)initialize
{
    if (self == [TabBarController class]) {
        UITabBarItem *item = [UITabBarItem appearance];
        // 普通状态下的文字属性
        NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
        normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        // 选中状态下的文字属性
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
        [item setTitleTextAttributes:normalAttrs forState:UIControlStateSelected];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAllChildController];
    [self setValue:[[TabBar alloc]init] forKey:@"tabBar"];
    
}

- (void)createAllChildController
{
    [self createOneChildController:[[UIViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self createOneChildController:[[UIViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self createOneChildController:[[UIViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self createOneChildController:[[UIViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}
- (void)createOneChildController:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    if (image.length) {
        childVc.tabBarItem.image = [UIImage imageNamed:image];
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
