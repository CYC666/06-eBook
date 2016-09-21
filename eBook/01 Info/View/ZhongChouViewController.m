//
//  ZhongChouViewController.m
//  eBook
//
//  Created by CYC on 16/4/27.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "ZhongChouViewController.h"

@interface ZhongChouViewController ()

@end

@implementation ZhongChouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.title = @"掌阅iReader";
    //创建网页视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - NavigationBarHeight)];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://wapbaike.baidu.com/view/12623441.htm?fr=aladdin&ref=wise&ssid=0&from=1099b&uid=0&pu=usm@3,sz@1320_2001,ta@iphone_1_9.2_3_601&bd_page_type=1&baiduid=6FAFADC38908D9BD0F5B9351D435BBD3&tj=Xv_2_0_10_title"];
    //创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //接收网络请求
    [webView loadRequest:request];
}



@end
