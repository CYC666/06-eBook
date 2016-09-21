//
//  CellHeaderView.m
//  eBook
//
//  Created by CYC on 16/4/27.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "CellHeaderView.h"
#import "BaseNavigationController.h"
#import "MassageViewController.h"
#import "SetViewController.h"
#import "MineViewController.h"
#import "RoseViewController.h"

@implementation CellHeaderView


#pragma mark - 切换到 消息中心
- (IBAction)massageButton:(UIButton *)sender {
    //获取当前view对应的导航器
    BaseNavigationController *baseNavigationController = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
    MassageViewController *massageViewController = [[MassageViewController alloc] init];
    //切换后隐藏标签栏
    massageViewController.hidesBottomBarWhenPushed = YES;
    [baseNavigationController pushViewController:massageViewController animated:YES];
}
#pragma mark - 切换到 设置
- (IBAction)setButton:(UIButton *)sender {
    //获取当前view对应的导航器
    BaseNavigationController *baseNavigationController = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
    SetViewController *setViewController = [[SetViewController alloc] init];
    //切换后隐藏标签栏
    setViewController.hidesBottomBarWhenPushed = YES;
    [baseNavigationController pushViewController:setViewController animated:YES];
}
#pragma mark - 切换到 我的
- (IBAction)mineButton:(UIButton *)sender {
    //获取当前view对应的导航器
    BaseNavigationController *baseNavigationController = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
    MineViewController *mineViewController = [[MineViewController alloc] init];
    //切换后隐藏标签栏
    mineViewController.hidesBottomBarWhenPushed = YES;
    [baseNavigationController pushViewController:mineViewController animated:YES];
}

- (IBAction)rose:(UIButton *)sender {
    BaseNavigationController *baseNavigationController = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
    RoseViewController *roseViewController = [[RoseViewController alloc] init];
    roseViewController.hidesBottomBarWhenPushed = YES;
    [baseNavigationController pushViewController:roseViewController animated:YES];
}
@end
