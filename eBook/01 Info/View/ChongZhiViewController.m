//
//  ChongZhiViewController.m
//  eBook
//
//  Created by CYC on 16/4/27.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "ChongZhiViewController.h"

@interface ChongZhiViewController ()

@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建网页视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -NavigationBarHeight + 13, kScreenWidth, kScreenHeight + NavigationBarHeight)];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://m.lankdo.net"];
    //创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //接收网络请求
    [webView loadRequest:request];
    
    
}




@end
