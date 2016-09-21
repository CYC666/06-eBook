//
//  ReadingViewController.m
//  eBook
//
//  Created by CYC on 16/4/29.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "ReadingViewController.h"
#import "LabelViewController.h"
#import "SelfExample.h"

@interface ReadingViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UITextFieldDelegate> {
    UIView *_backgroundView;    //背景视图
    UIView *_headerView;        //头视图
    UIView *_footerView;        //尾视图
    UIView *_listView;          //目录视图
    UIView *_findView;          //查找页面视图
    
    UILabel *_headerLabel;      //头视图显示的书名
    LabelViewController *_initialViewController;    //阅读界面控制器
    
    NSUInteger _countPage;   //页数
    BOOL _isTap;             //头部视图的显示隐藏
    
    UISlider *_slider;      //底部页数控制滑动条
    
    UILabel *_nilLabel;    //搜索框无结果提示
}
@end

@implementation ReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建背景视图
    [self _creatBackgroundView];
    //2.创建头部视图
    [self _creatHeaderView];
    //3.创建底部视图
    [self _creatFooterView];
    //4.创建目录视图
    [self _creatListView];
    //5.创建查找页面视图
    [self _creatFindView];
}
#pragma mark - set方法加载数据
- (void)setEBookName:(NSString *)eBookName {
    _eBookName = eBookName;
    //创建可变数组，用来储存截取好的字符串对象
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    //获取txt中所有的字符串
    NSString *txtString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_eBookName ofType:nil]
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    //截取字符串，每页400
    for (int i = 0; i < txtString.length / 400; i++) {
        NSString *string = [txtString substringWithRange:NSMakeRange(400*i, 400)];
        //将截取好的字符串对象存储到可变数组中
        [pageStrings addObject:string];
    }
    //将存好字符串对象的数组存到属性pageContent里
    self.pageContent = [[NSArray alloc] initWithArray:pageStrings];
    
}
#pragma mark - 创建背景视图||分页控制器
- (void)_creatBackgroundView {
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_backgroundView];
    _backgroundView.backgroundColor = [UIColor colorWithRed:240/255.5 green:240/255.5 blue:240/255.5 alpha:1];
   
    SelfExample *selfExample = [SelfExample shareInstance];
    //1.实例化手势控制器
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                        forKey:UIPageViewControllerOptionSpineLocationKey];
    
    if (selfExample.isPageCurl == YES) {    //判断是否为仿真翻页效果
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl   //翻页效果
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal //水平、竖直
                                                                            options:options];
    } else {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll   //翻页效果
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal //水平、竖直
                                                                            options:options];
    }
    
    //2.设置frame
    _pageViewController.view.frame = self.view.bounds;
    //3.设置UIPageViewController的代理，签订协议
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    //获取上次退出时的页面
    _initialViewController = [self viewControllerAtIndex:selfExample.lastPageNum];
    NSArray * viewControllers = [NSArray arrayWithObject:_initialViewController];
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
    
    //4.将UIPageViewController对象布局在控制器上
    [self addChildViewController:_pageViewController];
    //5.将UIPageViewController对象的view添加到某视图上
    [_backgroundView addSubview:_pageViewController.view];
    //点击屏幕的手势 响应
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    [_backgroundView addGestureRecognizer:tapGestureRecognizer];
    //捏合手势 响应
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [_backgroundView addGestureRecognizer:pinchGestureRecognizer];
}
#pragma mark - 创建头部视图
- (void)_creatHeaderView {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, NavigationBarHeight)];
    _headerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    [self.view addSubview:_headerView];
    //头视图显示的书名
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    _headerLabel.center = CGPointMake(kScreenWidth/2, 40);
    [_headerView addSubview:_headerLabel];
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel.textColor = [UIColor whiteColor];
    _headerLabel.font = [UIFont systemFontOfSize:22];
    _headerLabel.text = _bookName;
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(10, 25, 30, 30);
    [_headerView addSubview:backButton];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //创建夜间模式按钮
    UIButton *nightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nightButton.frame = CGRectMake(335, 27, 30, 30);
    [nightButton setImage:[UIImage imageNamed:@"day.png"] forState:UIControlStateNormal];
    [_headerView addSubview:nightButton];
    [nightButton addTarget:self action:@selector(nightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //创建查找按钮
    UIButton *findButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findButton.frame = CGRectMake(300, 28, 27, 27);
    [findButton setImage:[UIImage imageNamed:@"find.png"] forState:UIControlStateNormal];
    [_headerView addSubview:findButton];
    [findButton addTarget:self action:@selector(findButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark - 创建底部视图
- (void)_creatFooterView {
    SelfExample *selfExample = [SelfExample shareInstance];
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - TabBarHeight, kScreenWidth, TabBarHeight)];
    _footerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    [self.view addSubview:_footerView];
    _footerView.hidden = NO;   //隐藏底部视图
    //滑动条
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(60, 10, 250, 30)];
    _slider.minimumValue = 0;
    _slider.maximumValue = [self.pageContent count] - 1;
    _slider.value = selfExample.lastPageNum;
//    [_slider setThumbImage:[UIImage imageNamed:@"dog"] forState:UIControlStateNormal];
    [_footerView addSubview:_slider];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    //上一章、下一章
    UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 50, 30)];
    [_footerView addSubview:upLabel];
    upLabel.text = @"上一章";
    upLabel.font = [UIFont systemFontOfSize:16];
    UILabel *downLabel = [[UILabel alloc] initWithFrame:CGRectMake(318, 10, 50, 30)];
    [_footerView addSubview:downLabel];
    downLabel.text = @"下一章";
    downLabel.font = [UIFont systemFontOfSize:16];
}
#pragma mark - 创建目录视图
- (void)_creatListView {
    _listView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_listView];
    _listView.hidden = YES;
}
#pragma mark - 创建查找页面视图
- (void)_creatFindView {
    //实例化查找页面
    _findView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    _findView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:_findView];
    //查找栏的背景
    UIImageView *findViewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 325, 35)];
    findViewHeader.image = [UIImage imageNamed:@"findViewHeader.png"];
    [_findView addSubview:findViewHeader];
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(328, 25, 45, 35);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_findView addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(findViewCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    //查找框
    UITextField *findTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 27, 290, 30)];
    [findTextField setFont:[UIFont systemFontOfSize:14]];
    findTextField.placeholder = @"请输入查找内容:";
    findTextField.borderStyle = UITextBorderStyleNone;
    findTextField.returnKeyType = UIReturnKeySearch;
    findTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    findTextField.delegate = self;
    [_findView addSubview:findTextField];
    //查找结果提示框
    _nilLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    _nilLabel.center = CGPointMake(kScreenWidth/2, 100);
    _nilLabel.numberOfLines = 0;
    _nilLabel.text = @"输入关键字，前往TA那里";
    _nilLabel.textColor = [UIColor grayColor];
    _nilLabel.textAlignment = NSTextAlignmentCenter;
    _nilLabel.font = [UIFont systemFontOfSize:14];
    [_findView addSubview:_nilLabel];
}
#pragma mark - return隐藏键盘代理方法,搜索关键词，并前往关键词位置
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    for (int i = 0; i < [self.pageContent count]; i++) {
        NSString *string = self.pageContent[i];
        NSRange range = [string rangeOfString:textField.text];
        if (range.location != NSNotFound) {
            SelfExample *selfExample = [SelfExample shareInstance];
            selfExample.lastPageNum = i;
            //修改当前页数
            _countPage = i;
            //加载到搜索关键字页面
            _initialViewController = [self viewControllerAtIndex:selfExample.lastPageNum];
            NSArray * viewControllers = [NSArray arrayWithObject:_initialViewController];
            [_pageViewController setViewControllers:viewControllers
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:nil];
            //隐藏搜索页面
            [UIView transitionWithView:_findView
                              duration:.35
                               options:UIViewAnimationOptionTransitionNone
                            animations:^{
                                _findView.transform = CGAffineTransformIdentity;
                            }
                            completion:^(BOOL finished) {
                                ;
                            }];
            //修改滑动条的进度
            _slider.value = i;
            //更换nilLabel提示
            _nilLabel.text = @"输入关键字，前往TA那里";
            //隐藏键盘
            [textField resignFirstResponder];
            return YES;
            
        } else {
            NSString *nilString = [NSString stringWithFormat:@"很抱歉，没有找到 %@ 相关内容，换个词试试吧", textField.text];
            _nilLabel.text = nilString;
        }
    }

    //隐藏键盘
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - 点击清除小按钮
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _nilLabel.text = @"输入关键字，前往TA那里";
    return YES;
}
#pragma mark - 查找页面取消按钮
- (void)findViewCancelButton:(UIButton *)button {
    [UIView transitionWithView:_findView
                      duration:.35
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        _findView.transform = CGAffineTransformMakeTranslation(0, 0);
                    }
                    completion:^(BOOL finished) {
                        ;
                    }];
    //隐藏键盘
    [self.view endEditing:YES];
}
#pragma mark - 捏合手势响应
- (void)pinchAction:(UIPinchGestureRecognizer *)sender {
    _listView.hidden = NO;
}
#pragma mark - 滑动条值变化响应
- (void)sliderAction:(UISlider *)sender {
    //改变当前页，重新加载
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.lastPageNum = (NSInteger)sender.value;
    _initialViewController = [self viewControllerAtIndex:selfExample.lastPageNum];
    NSArray * viewControllers = [NSArray arrayWithObject:_initialViewController];
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
}
#pragma mark - 夜间按钮响应
- (void)nightButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {  //开启夜间模式
        [button setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateSelected];
        SelfExample *selfExample = [SelfExample shareInstance];
        selfExample.isNight = YES;
        selfExample.lastPageNum = _countPage;   //记录当前页面
        //重新加载
        _initialViewController = [self viewControllerAtIndex:selfExample.lastPageNum];
        NSArray * viewControllers = [NSArray arrayWithObject:_initialViewController];
        [_pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];

    } else {                //关闭夜间模式
        [button setImage:[UIImage imageNamed:@"day.png"] forState:UIControlStateNormal];
        SelfExample *selfExample = [SelfExample shareInstance];
        selfExample.isNight = NO;
        selfExample.lastPageNum = _countPage;   //记录当前页面
        //重新加载
        _initialViewController = [self viewControllerAtIndex:selfExample.lastPageNum];
        NSArray * viewControllers = [NSArray arrayWithObject:_initialViewController];
        [_pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    }
}
#pragma mark - 查找按钮响应
- (void)findButtonAction:(UIButton *)button {
    [UIView transitionWithView:_findView
                      duration:.35
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        _findView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
                    }
                    completion:^(BOOL finished) {
                        ;
                    }];
}
#pragma mark - 中部响应手势,显示/隐藏头尾视图
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)sender {
    _isTap = !_isTap;
    if (_isTap) {
        [UIView transitionWithView:_headerView
                          duration:.35
                           options:UIViewAnimationOptionLayoutSubviews
                        animations:^{
                            _headerView.transform = CGAffineTransformMakeTranslation(0, -NavigationBarHeight);    //隐藏头部视图
                            _footerView.transform = CGAffineTransformMakeTranslation(0, +TabBarHeight);     //隐藏底部视图
                        } completion:^(BOOL finished) {
                            ;
                        }];
    } else {
        [UIView transitionWithView:_headerView
                          duration:.35
                           options:UIViewAnimationOptionLayoutSubviews
                        animations:^{
                            _headerView.transform = CGAffineTransformMakeTranslation(0, 0);    //显示头部视图
                            _footerView.transform = CGAffineTransformMakeTranslation(0, 0);    //显示底部视图
                        } completion:^(BOOL finished) {
                            ;
                        }];
    }
}
#pragma mark - 返回按钮响应,返回主屏幕
- (void)backButtonAction:(UIButton *)button {
    //记录退出时的页面
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.lastPageNum = _countPage;
    //返回主屏幕
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 下一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerAfterViewController:(UIViewController *)viewController {
    //获取当前页的index
    NSUInteger index = [self indexOfViewController:(LabelViewController *)viewController];
    if (index == NSNotFound) {  //如果找不到
        return nil;
    }
    index++;    //下一页
    if (index == [self.pageContent count]) {    //如果下一页已经到尽头
        return nil;
    }
    _countPage = index;      //设置当前页数
    _slider.value = index;
    return [self viewControllerAtIndex:index];
}
#pragma mark - 上一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:(LabelViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {    //当当前页为首页或者找不到
        return nil;
    }
    index--;    //指向上一页
    _countPage = index;  //修改页数
    _slider.value = index;
    return [self viewControllerAtIndex:index];
}
#pragma mark - 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(LabelViewController *)labelViewController{
    return [self.pageContent indexOfObject:labelViewController.dataObject];
}
#pragma mark - 根据下标值得到相应的viewController对象
- (LabelViewController *)viewControllerAtIndex:(NSUInteger)index{
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count])) {
        return nil;
    }
    //创建一个新的控制器类，并且分配给相应的数据
    LabelViewController *dataViewController = [[LabelViewController alloc] init];
    dataViewController.dataObject = [self.pageContent objectAtIndex:index];
    return dataViewController;
}
















@end
