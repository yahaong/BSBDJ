//
//  titleLabel.m
//  BSBDJ
//
//  Created by Yahaong on 16/6/2.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
