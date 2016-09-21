//
//  InfoViewController.m
//  eBook
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoTableViewCell.h"
#import "CellHeaderView.h"
#define InfoTableViewCellID @"InfoTableViewCellIDCYC666"
//子视图二级视图控制器
#import "ZhangYueViewController.h"
#import "ShangChengViewController.h"
#import "HuoDongViewController.h"
#import "QianDaoViewController.h"
#import "JinRiViewController.h"
#import "ChunSanViewController.h"
#import "ZhongChouViewController.h"
#import "ChongZhiViewController.h"

@interface InfoViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_imagesNameArray;
    NSArray *_titlesNameArray;
}

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建表视图
    [self _creatTableView];
}

#pragma mark - 创建表视图
- (void)_creatTableView {
    //1.创建表视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight - TabBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    //表视图背景颜色
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    tableView.showsVerticalScrollIndicator = NO;    //取消显示垂直滑动条
    //2.设置代理，签协议
    tableView.dataSource = self;
    tableView.delegate = self;
    //3.加载数据(XIB方式注册单元格)
    [tableView registerNib:[UINib nibWithNibName:@"InfoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:InfoTableViewCellID];
    //4.实现协议
    
    
    //创建数组存图片名字
    _imagesNameArray = @[@"zhangyuedianzishuerdai",
                         @"shangchengduobao",
                         @"tiantiantejia",
                         @"qiandaorenwu",
                         @"jinrimianfei",
                         @"chunsanguo",
                         @"zhangyuezhongchou",
                         @"zhongzhizuigaozengsong"];
    //创建数组存单元格的标题
    _titlesNameArray = @[@"掌阅电子书六代",
                         @"商城/夺宝",
                         @"天天特价",
                         @"签到/任务",
                         @"今日免费",
                         @"纯三国",
                         @"掌阅统筹",
                         @"充值最高赠送1000"];

}
//表视图代理方法
#pragma mark - 返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}
#pragma mark - 创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoTableViewCellID forIndexPath:indexPath];
    [cell.headImageView setImage:[UIImage imageNamed:_imagesNameArray[indexPath.row]]];     //给headImageView设置图片
    cell.titleLabel.text = _titlesNameArray[indexPath.row];     //给titleLabel设置文本内容
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    //单元格的选中效果为 无
    return cell;
}
#pragma mark - 返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
#pragma mark - 返回头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}
#pragma mark - 自定义头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //从xib加载单元格头视图
    CellHeaderView *cellHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"CellHeaderView" owner:self options:nil] firstObject];
    return cellHeaderView;
}
#pragma mark - 选中单元格响应,跳转到对应子视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {           //转至 掌阅电子书六代
        ZhangYueViewController *zhangYueViewController = [[ZhangYueViewController alloc] init];
        zhangYueViewController.hidesBottomBarWhenPushed = YES;  //隐藏标签栏
        [self.navigationController pushViewController:zhangYueViewController animated:YES];
    } else if (indexPath.row == 1) {    //转至 商城/夺宝
        ShangChengViewController *shangChengViewController = [[ShangChengViewController alloc] init];
        shangChengViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shangChengViewController animated:YES];
    } else if (indexPath.row == 2) {    //转至 活动中心
        HuoDongViewController *huoDongViewController = [[HuoDongViewController alloc] init];
        huoDongViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:huoDongViewController animated:YES];
    } else if (indexPath.row == 3) {    //转至 签到/任务
        QianDaoViewController *qianDaoViewController = [[QianDaoViewController alloc] init];
        qianDaoViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qianDaoViewController animated:YES];
    } else if (indexPath.row == 4) {    //转至 今日免费
        JinRiViewController *jinRiViewController = [[JinRiViewController alloc] init];
        jinRiViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:jinRiViewController animated:YES];
    } else if (indexPath.row == 5) {    //转至 纯三国
        ChunSanViewController *chunSanViewController = [[ChunSanViewController alloc] init];
        chunSanViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chunSanViewController animated:YES];
    } else if (indexPath.row == 6) {    //转至 掌阅众筹
        ZhongChouViewController *zhongChouViewController = [[ZhongChouViewController alloc] init];
        zhongChouViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zhongChouViewController animated:YES];
    } else if (indexPath.row == 7) {    //转至 重置最高赠送
        ChongZhiViewController *chongZhiViewController = [[ChongZhiViewController alloc] init];
        chongZhiViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chongZhiViewController animated:YES];
    }
}





@end
