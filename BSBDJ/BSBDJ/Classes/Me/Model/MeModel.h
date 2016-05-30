//
//  MeModel.h
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeModel : NSObject
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 路径 */
@property (nonatomic, copy) NSString *url;
@end
