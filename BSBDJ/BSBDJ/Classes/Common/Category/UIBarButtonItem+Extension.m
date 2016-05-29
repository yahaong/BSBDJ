//
//  UIBarButtonItem+Extension.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)createBarButtonItem:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(nullable id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
