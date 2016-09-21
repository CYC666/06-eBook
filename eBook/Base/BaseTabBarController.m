//
//  BaseTabBarController.m
//  eBook
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始显示中间的标签栏
    self.selectedIndex = 1;
    //设置标签栏透明度
    self.tabBar.translucent = NO;
}




@end
