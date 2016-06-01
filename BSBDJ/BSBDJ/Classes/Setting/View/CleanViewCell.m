//
//  CleanViewCell.m
//  BSBDJ
//
//  Created by Yahaong on 16/5/30.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "CleanViewCell.h"
#import "SVProgressHUD.h"
#import "FileTools.h"
#import "SDImageCache.h"

@interface CleanViewCell ()
@property(nonatomic, copy)NSString *cachePath;
@end
@implementation CleanViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.textLabel.text = @"清除缓存(正在计算缓存大小)";
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicatorView startAnimating];
        self.accessoryView = indicatorView;
         self.userInteractionEnabled = NO;

        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(2);
            NSString *text = [weakSelf getCacheSize];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.textLabel.text = text;
                weakSelf.accessoryView = nil;
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
                [self addGestureRecognizer:tap];
                weakSelf.userInteractionEnabled = YES;
            });
        });
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (NSString *)getCacheSize
{
    NSInteger size =  [FileTools fileSizeForfile:self.cachePath];
    NSString * sizeStr = nil;
    if (size > 1000 * 1000 * 1000) {
        sizeStr = [NSString stringWithFormat:@"%.2fG", size / (1000.0 * 1000 *1000)
                   ];
    } else if (size > 1000 * 1000) {
        sizeStr = [NSString stringWithFormat:@"%.2fM", size / (1000.0 * 1000 )
                   ];
    } else if (size > 1000) {
        sizeStr = [NSString stringWithFormat:@"%.2fK", size / (1000.0)
                   ];
    } else {
        sizeStr = [NSString stringWithFormat:@"%zdB", size];
    }
    return [NSString stringWithFormat:@"清楚缓存(%@)", sizeStr];
}
- (void)click
{

    [SVProgressHUD showWithStatus:@"正在清理中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:self.cachePath error:nil];
        [manager createDirectoryAtPath:self.cachePath withIntermediateDirectories:YES attributes:nil error:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//            // 设置文字
//            self.textLabel.text = @"清除缓存(0B)";
//        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            // 设置文字
            self.textLabel.text = @"清除缓存(0B)";
        });
    });
  
     
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (NSString *)cachePath
{
	if (!_cachePath){
        NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [[cache stringByAppendingPathComponent:@"default"]stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
        _cachePath = path;
	}
	return _cachePath;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)self.accessoryView;
    [indicatorView startAnimating];
}

@end
