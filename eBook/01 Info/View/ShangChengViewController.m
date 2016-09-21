//
//  ShangChengViewController.m
//  eBook
//
//  Created by CYC on 16/4/27.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "ShangChengViewController.h"

@interface ShangChengViewController ()

@end

@implementation ShangChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.title = @"夺宝";
    //创建网页视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - NavigationBarHeight)];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://dushu.baidu.com"];
    //创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //接收网络请求
    [webView loadRequest:request];
}



@end
