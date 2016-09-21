//
//  BooksViewController.m
//  eBook
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "BooksViewController.h"
#import "BookModel.h"
#import "BookCollectionView.h"
#import "BookCollectionViewFlowLayout.h"
#import "BookCollectionViewCell.h"



@interface BooksViewController () {
    NSMutableArray *_bookModels;    //存放model的数组
    BookCollectionView *_bookCollectionView;    //集合视图
    UILabel *_titleLabel;   //书名
}

@end

@implementation BooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //加载数据
    [self _loadData];
    //创建集合视图
    [self _creatCollectionView];
    //创建标题label
    [self _creatTitleLabel];
    //添加观察者
    [_bookCollectionView addObserver:self
                          forKeyPath:@"currentPage"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
}
#pragma mark - 观察者的响应方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    //获取到监控到的最新的属性的变化之后的值(页数currentPage)
    NSInteger index = [change[@"new"] integerValue];
    //修改图书标题
    BookModel *bookModel = _bookModels[index];
    _titleLabel.text = bookModel.title;
}
#pragma mark - 加载数据
- (void)_loadData {
    //获取book.plist文件路径
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"plist"];
    //通过路径获取里边的元素
    NSArray *array = [NSArray arrayWithContentsOfFile:pathString];
    //实例化_bookModels
    _bookModels = [NSMutableArray array];
    //将数据取出来，存到model里，并用数组存model
    for (NSDictionary *dic in array) {
        //创建model，准备存数据
        BookModel *model = [[BookModel alloc] init];
        //数据转接
        model.title = dic[@"title"];
        model.image = dic[@"image"];
        model.book = dic[@"book"];
        //将model存到_bookModels
        [_bookModels addObject:model];
    }
}
#pragma mark - 创建集合视图
- (void)_creatCollectionView {
//1.创建布局对象
    BookCollectionViewFlowLayout *bookCollectionViewFlowLayout = [[BookCollectionViewFlowLayout alloc] init];
//2.创建集合视图
    //集合视图的frame
    CGRect rect = CGRectMake(0, 50, kScreenWidth, kScreenHeight - NavigationBarHeight - TabBarHeight - 70);
    _bookCollectionView = [[BookCollectionView alloc] initWithFrame:rect collectionViewLayout:bookCollectionViewFlowLayout];
    [self.view addSubview:_bookCollectionView];
    //将数据传给子类化的集合视图
    _bookCollectionView.subBookModels = _bookModels;
}
#pragma mark - 书名标题
- (void)_creatTitleLabel {
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    _titleLabel.center = CGPointMake(kScreenWidth/2, 40);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:30];
    //设置初始化的title内容
    BookModel *firstBookModel = _bookModels[0];
    _titleLabel.text = firstBookModel.title;
    [self.view addSubview:_titleLabel];
}
#pragma mark - 接收通知后响应，更改title内容
- (void)receiveNotification:(NSNotification *)notification {
    _titleLabel.text = notification.object;
}












































@end
