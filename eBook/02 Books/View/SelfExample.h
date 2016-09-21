//
//  SelfExample.h
//  eBook
//
//  Created by CYC on 16/5/2.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfExample : NSObject

@property (assign, nonatomic) BOOL isNight;     //夜间模式
@property (assign, nonatomic) BOOL isPageCurl;  //翻页效果
@property (assign, nonatomic) NSUInteger lastPageNum;   //退出时的页数
@property (assign, nonatomic) NSUInteger bookID;    //用来表示书本的ID,判断打开的是否是同一本

@property (assign, nonatomic) BOOL isGrayColor;     //灰色
@property (assign, nonatomic) BOOL isMeatColor;     //肉色
@property (assign, nonatomic) BOOL isTenderColor;   //嫩色
@property (assign, nonatomic) BOOL isNavyColor;     //青色
@property (assign, nonatomic) BOOL isBlueColor;     //蓝色
@property (assign, nonatomic) BOOL isPurpleColor;   //紫色
@property (assign, nonatomic) BOOL isBlackColor;    //黑色

@property (assign, nonatomic) float shadeAlphaValue;   //遮罩层的透明度

@property (assign, nonatomic) NSUInteger sizeValue; //字体大小
@property (assign, nonatomic) BOOL isWhite;         //字体颜色是否是白色
@property (copy, nonatomic) NSString *fontStyle;         //字体样式

+ (id)shareInstance;

@end
