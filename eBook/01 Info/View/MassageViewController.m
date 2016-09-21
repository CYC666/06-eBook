//
//  MassageViewController.m
//  eBook
//
//  Created by CYC on 16/4/27.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "MassageViewController.h"

@interface MassageViewController ()

@end

@implementation MassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.title = @"消息中心";
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空 "
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(clearButton:)];
    
}
#pragma mark - 清空按钮响应
- (void)clearButton:(UIButton *)button {
    //弹出提示框
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"确定要清空当前列表码？"
                                  delegate:self cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"删除"
                                  otherButtonTitles:@"确定", nil];
    //将actionSheet显示在视图上
    [actionSheet showInView:self.view];
}

@end
