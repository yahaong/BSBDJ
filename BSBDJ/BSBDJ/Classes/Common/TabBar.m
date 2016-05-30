//
//  TabBar.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "TabBar.h"

@interface TabBar ()
@property(nonatomic, strong)UIButton *publishButton;
@end
@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib
{
    [self setup];
}
- (void)setup
{
    // 设置tabbar的背景图片
    [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    [self addSubview:self.publishButton];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = 5;
    CGFloat itemWidth = self.frame.size.width / count;
    CGFloat itemHeight = self.frame.size.height;
    CGFloat itemY = 0;
    NSInteger itemIndex = 0;
    for (UIView *child in  self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class] ) {
            
            child.frame = CGRectMake(itemWidth *itemIndex, itemY, itemWidth, itemHeight);
            itemIndex++;
            if (itemIndex == 2) {
                itemIndex++;
            }
        }
    }
    self.publishButton.width = itemWidth;
    self.publishButton.height = itemHeight;
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
}
- (UIButton *)publishButton
{
    if (!_publishButton) {
        _publishButton = [[UIButton alloc]init];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
    }
    return _publishButton;
}

- (void)publishButtonClick
{
    NSLog(@"%s",__FUNCTION__);
}
@end
