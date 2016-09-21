//
//  ZhangYueViewController.m
//  eBook
//
//  Created by CYC on 16/4/27.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "ZhangYueViewController.h"

@interface ZhangYueViewController ()

@end

@implementation ZhangYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.title = @"掌阅电子书";
    //创建滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:scrollView];
    //控制速度，使滑动更加清爽可控
    scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    //设置内容尺寸
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*5);
    float countHeight = 0;  //imageView的偏移
    for (int i = 0; i < 9; i++) {
        //拼接字符串， 图片名
        NSString *imageString = [NSString stringWithFormat:@"image%d.png", i+1];
        //加载图片
        UIImage *image = [UIImage imageNamed:imageString];
        //通过图片的大小来创建图片视图的大小
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, countHeight, kScreenWidth, image.size.height/2)];
        //存储下一个imageview的偏移量
        countHeight += image.size.height/2;
        //讲图片添加到图片视图
        imageView.image = image;
        //将图片视图添加到滑动视图
        [scrollView addSubview:imageView];

    }
    
    
}




@end
