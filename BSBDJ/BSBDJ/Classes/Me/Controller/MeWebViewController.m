//
//  WebViewController.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "MeWebViewController.h"

@interface MeWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation MeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (IBAction)back
{
    [self.webView goBack];
}
- (IBAction)forward
{
    [self.webView goForward];
}
- (IBAction)reload
{
    [self.webView reload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}


@end
