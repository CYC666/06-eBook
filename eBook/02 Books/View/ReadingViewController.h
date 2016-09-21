//
//  ReadingViewController.h
//  eBook
//
//  Created by CYC on 16/4/29.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "BaseViewController.h"

@interface ReadingViewController : BaseViewController

@property (copy, nonatomic) NSString *eBookName;    //电子书名
@property (copy, nonatomic) NSString *bookName;     //书名
@property (strong, nonatomic) UIPageViewController *pageViewController;    //页面控制器
@property (strong, nonatomic) NSArray *pageContent;     //储存已经装载内容的字符串对象


@end
