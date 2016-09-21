//
//  BookCollectionView.m
//  eBook
//
//  Created by CYC on 16/4/29.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "BookCollectionView.h"
#import "BookCollectionViewCell.h"
#import "BookCollectionViewFlowLayout.h"
#import "BooksViewController.h"
#import "ReadingViewController.h"
#import "SelfExample.h"

#define BookCollectionViewCellID @"BookCollectionViewCellID"

@interface BookCollectionView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation BookCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self != nil) {
        //控制滑动速度
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        //清空集合视图背景颜色
        self.backgroundColor = [UIColor clearColor];
        //不显示水平滑动条
        self.showsHorizontalScrollIndicator = NO;
        //注册单元格
        [self registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:[NSBundle mainBundle]]
              forCellWithReuseIdentifier:BookCollectionViewCellID];
        //设置代理，签订协议
        self.dataSource = self;
        self.delegate = self;

    }
    return self;
}

#pragma mark - 单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _subBookModels.count;
}
#pragma mark - 创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BookCollectionViewCellID
                                                                             forIndexPath:indexPath];
    //将数据传给子类化的cell对象(用self调用)
    cell.bookModel = self.subBookModels[indexPath.item];
    return cell;
}
#pragma mark - 设置集合视图边缘留白
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, (kScreenWidth - 262)/2, 0, (kScreenWidth - 262)/2);
}
#pragma mark - 点击边缘单元格，移动到该单元格||跳转到阅读界面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentPage != indexPath.item) {
        //点击之后不允许用户再点击视图
        self.userInteractionEnabled = NO;
        //将点击的视图移动到中央
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //0.35秒后，用户可以再次点击视图
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
        //保存点击之后对应中间的item的位置
        self.currentPage = indexPath.item;
    } else {
        //跳转阅读界面
        //1.获取当前视图的导航控制器
        BooksViewController *booksViewController = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[1];
        //2.push
        ReadingViewController *readingViewController = [[ReadingViewController alloc] init];
        //将电子书名这个数据传给ReadingViewController
        BookModel *model = _subBookModels[indexPath.item];
        readingViewController.eBookName = model.book;
        readingViewController.bookName = model.title;
        //记录当前页
        SelfExample *selfExample = [SelfExample shareInstance];
        if (indexPath.item != selfExample.bookID) { //判断与上次打开的是否是同一本
            selfExample.bookID = indexPath.item;
            selfExample.lastPageNum = 0;
            selfExample.isNight = NO;
        } else {
        }
        //翻转效果
        readingViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [booksViewController presentViewController:readingViewController animated:YES completion:nil];

    }
}
#pragma mark - 移动单元格的时候，自动居中
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //x轴位移(相对原始)
    NSInteger xOffset = targetContentOffset->x;
    //获取当前视图的布局对象
    BookCollectionViewFlowLayout *flowLayout = (BookCollectionViewFlowLayout *)self.collectionViewLayout;
    //cell单元格页的宽度
    NSInteger pageWidth = 262 + flowLayout.minimumLineSpacing/2 * 2;
    //当前cell的页数
    NSInteger pageNum = (pageWidth/2 + xOffset) / pageWidth;
    //通过判断滑动的速度来确定当前的页数(优化)
    pageNum = velocity.x == 0 ? pageNum : (velocity.x > 0 ? pageNum + 1 : pageNum - 1);
    //设置当前 pagenum 的范围(0 -- _collectionMoviesData.count-1),防止划过限产生的bug
    pageNum = MIN(MAX(pageNum, 0), _subBookModels.count-1);
    //通过当前页数，直接修改目标偏移量到当前页面中间
    targetContentOffset->x = pageNum * pageWidth;
    //修改当前页数属性
    self.currentPage = pageNum;
}



















@end
