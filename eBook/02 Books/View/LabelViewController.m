//
//  LabelViewController.m
//  eBook
//
//  Created by CYC on 16/4/29.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "LabelViewController.h"
#import "ReadingViewController.h"
#import "SelfExample.h"

@interface LabelViewController () 

@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SelfExample *selfExample = [SelfExample shareInstance];
    if (selfExample.isGrayColor == YES) {
        self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    if (selfExample.isMeatColor == YES) {
        self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:219/255.0 blue:206/255.0 alpha:1];
    }
    if (selfExample.isTenderColor == YES) {
        self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:217/255.0 blue:173/255.0 alpha:1];
    }
    if (selfExample.isNavyColor == YES) {
        self.view.backgroundColor = [UIColor colorWithRed:185/255.0 green:217/255.0 blue:173/255.0 alpha:1];
    }
    if (selfExample.isBlueColor == YES) {
        self.view.backgroundColor = [UIColor colorWithRed:139/255.0 green:206/255.0 blue:255/255.0 alpha:1];
    }
    if (selfExample.isPurpleColor == YES) {
        self.view.backgroundColor = [UIColor colorWithRed:139/255.0 green:134/255.0 blue:255/255.0 alpha:1];
    }
    if (selfExample.isBlackColor == YES) {
        self.view.backgroundColor = [UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1];
    }
    if (selfExample.isNight == YES) {   //夜间模式
        self.view.backgroundColor = [UIColor grayColor];
    } else if (!selfExample.isGrayColor && !selfExample.isMeatColor && !selfExample.isTenderColor && !selfExample.isNavyColor && !selfExample.isBlueColor && !selfExample.isPurpleColor && !selfExample.isBlackColor) { //当不是夜间模式也未给背景设置颜色，那就设置白色
        self.view.backgroundColor = [UIColor whiteColor];
    }

    //这个view用来装文本框
    _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, kScreenWidth - 20, kScreenHeight - 50)];
    _label.numberOfLines = 0;
    _label.textAlignment = NSTextAlignmentLeft;
    //给文本框添加内容
    _label.text = (NSString *)self.dataObject;
    //设置字体样式、大小
    if ([selfExample.fontStyle isEqualToString:@"经典行书简"]) {
        if (selfExample.sizeValue == 0) {
            [_label setFont:[UIFont fontWithName:@"经典行书简" size:18]];
        } else {
            [_label setFont:[UIFont fontWithName:@"经典行书简" size:selfExample.sizeValue]];
        }
    } else if ([selfExample.fontStyle isEqualToString:@"MF KeSong(Noncommercial)"]) {
        if (selfExample.sizeValue == 0) {
            [_label setFont:[UIFont fontWithName:@"MFKeSong_Noncommercial-Regular" size:18]];
        } else {
            [_label setFont:[UIFont fontWithName:@"MFKeSong_Noncommercial-Regular" size:selfExample.sizeValue]];
        }
    } else if ([selfExample.fontStyle isEqualToString:@"迷你简娃娃篆"]) {
        if (selfExample.sizeValue == 0) {
            [_label setFont:[UIFont fontWithName:@"迷你简娃娃篆" size:18]];
        } else {
            [_label setFont:[UIFont fontWithName:@"迷你简娃娃篆" size:selfExample.sizeValue]];
        }
    } else {
        if (selfExample.sizeValue == 0) {
            _label.font = [UIFont systemFontOfSize:18];
        } else {
            _label.font = [UIFont systemFontOfSize:selfExample.sizeValue];
        }
    }

    //设置字体颜色 黑/白
    if (selfExample.isWhite == YES) {
        _label.textColor = [UIColor whiteColor];
    } else {
        _label.textColor = [UIColor blackColor];
    }
    [self.view addSubview:_label];
    //遮罩层，用于调节亮度
    UIView *shadeView = [[UIView alloc] initWithFrame:self.view.bounds];
    shadeView.backgroundColor = [UIColor colorWithWhite:0 alpha:selfExample.shadeAlphaValue];
    [self.view addSubview:shadeView];
    
    
}




@end
