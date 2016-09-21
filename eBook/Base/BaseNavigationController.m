//
//  BaseNavigationController.m
//  eBook
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏透明度
    self.navigationBar.translucent = NO;
    //导航栏字体属性
    NSDictionary *attributesDic = @{
                                    NSForegroundColorAttributeName:[UIColor blackColor],    //字体颜色
                                    NSFontAttributeName:[UIFont systemFontOfSize:22],       //字体大小
                                    };
    self.navigationBar.titleTextAttributes = attributesDic;
}
#pragma mark - 修改状态栏字体的显示样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault; //默认
}


@end
