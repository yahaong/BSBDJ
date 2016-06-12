//
//  UIBarButtonItem+Extension.h
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (nonnull UIBarButtonItem * )createBarButtonItem:(nonnull NSString *)image highlightedImage:(nonnull NSString *)highlightedImage target:(nullable id)target action:(nonnull SEL)action;
@end
