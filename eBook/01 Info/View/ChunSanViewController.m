//
//  ChunSanViewController.m
//  eBook
//
//  Created by CYC on 16/4/27.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "ChunSanViewController.h"

@interface ChunSanViewController ()

@end

@implementation ChunSanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.title = @"纯三国";
    //创建网页视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - NavigationBarHeight)];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://chunsanguo.youkia.com/Phone"];
    //创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //接收网络请求
    [webView loadRequest:request];
}



@end
