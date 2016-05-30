//
//  MeFooterView.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "MeFooterView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MeModel.h"
#import "MeSguareButton.h"
#import "MeWebViewController.h"
@implementation MeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            NSArray *meModels = [MeModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:meModels];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"请求失败%@",error);
        }];
    }
    return self;
}
- (void)createSquares:(NSArray *)meModels
{
    NSInteger count = meModels.count;
    NSInteger maxColsCount = 4;
    CGFloat buttonWidth = self.width / maxColsCount;
    CGFloat buttonHeight = buttonWidth;
    
    for (NSInteger i = 0; i < count; i++) {
        MeModel *meModel = meModels[i];
        MeSguareButton *button = [MeSguareButton buttonWithType:UIButtonTypeCustom];
        button.model = meModel;
        button.frame = CGRectMake(buttonWidth * (i % maxColsCount), buttonHeight * (i / maxColsCount), buttonWidth, buttonHeight);
        [button addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    self.height = self.subviews.lastObject.bottom;
    UITableView *tableView = ( UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData];

    
}
- (void)btnClik:(MeSguareButton *)button
{
    MeModel *meModel = button.model;
    NSString *url = meModel.url;
    if ([url hasPrefix:@"http"]) {
        UITabBarController *tableVc =  (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tableVc.selectedViewController;
        MeWebViewController *webView = [[MeWebViewController alloc] init];
        webView.url = url;
        webView.navigationItem.title = button.currentTitle;
        [nav pushViewController:webView animated:YES];
    }else if ([url hasPrefix:@"mod"]) {
        if ([url hasSuffix:@"BDJ_To_Check"]) {
            DLog(@"跳转到[审帖]界面");
        } else if ([url hasSuffix:@"BDJ_To_RecentHot"]) {
            DLog(@"跳转到[每日排行]界面");
        } else {
            DLog(@"跳转到其他界面");
        }
    }else {
        DLog(@"发的都是什么玩意？");
    }
    
}
@end
