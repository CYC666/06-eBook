//
//  SetViewController.m
//  eBook
//
//  Created by CYC on 16/4/27.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "SetViewController.h"
#import "SetReadingViewController.h"
#import "AccountViewController.h"
#import "AboutUSViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.title = @"设置";
    
}


//切换到阅读设置
- (IBAction)readSetButton:(UIButton *)sender {
    SetReadingViewController *setReadingViewController = [[SetReadingViewController alloc] init];
    [self.navigationController pushViewController:setReadingViewController animated:YES];
}
//切换到账户与安全
- (IBAction)accountButton:(UIButton *)sender {
    AccountViewController *accountViewController = [[AccountViewController alloc] init];
    [self.navigationController pushViewController:accountViewController animated:YES];
}
//切换到关于我们
- (IBAction)aboutButton:(UIButton *)sender {
    AboutUSViewController *aboutUSViewController = [[AboutUSViewController alloc] init];
    [self.navigationController pushViewController:aboutUSViewController animated:YES];
}
//切换到隐私策略
- (IBAction)secretsButton:(UIButton *)sender {
}
@end
