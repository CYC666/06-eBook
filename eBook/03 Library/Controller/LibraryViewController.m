//
//  LibraryViewController.m
//  eBook
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "LibraryViewController.h"

@interface LibraryViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation LibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个网页
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight - TabBarHeight)];
    _webView.scalesPageToFit = YES; //让网页适应屏幕
    [self.view addSubview:_webView];
    
    //加载网页
    NSURL *url = [NSURL URLWithString:@"http://m.ireader.com/index.php?key=4B4&p2=104005&p5=16&rgt=5&pc=61&jump=&sessionid=096dAwYAAFJSAwkIAwxQCVJWDwdVVgVUU1QDXwZTFVZQBEVFAFZcUgVDAA9bWgBWV1RVQgITAQ"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];  //发送一个网络请求
    [_webView loadRequest:request];
    
}




@end
