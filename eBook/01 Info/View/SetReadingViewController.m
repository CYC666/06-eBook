//
//  SetReadingViewController.m
//  eBook
//
//  Created by CYC on 16/5/4.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "SetReadingViewController.h"
#import "SelfExample.h"

@interface SetReadingViewController ()<UIPickerViewDataSource, UIPickerViewDelegate> {

    NSArray *_data; //pickerView的数据

}

@end

@implementation SetReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SelfExample *selfExample = [SelfExample shareInstance];
    //创建pickerView来调节字体大小
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(315, 395, 40, 50)];
    [self.view addSubview:pickerView];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    _data = @[@"10",@"12",@"14",@"16",@"18",@"20"];
    //设置遮罩层透明度显示值
    NSString *string = [NSString stringWithFormat:@"%.1f",selfExample.shadeAlphaValue];
    self.shadeAlphaShowLabel.text = string;
    if (selfExample.isGrayColor == YES) {
        self.colorShowLabel.text = @"灰";
    }
    if (selfExample.isMeatColor == YES) {
        self.colorShowLabel.text = @"肉";
    }
    if (selfExample.isTenderColor == YES) {
        self.colorShowLabel.text = @"嫩";
    }
    if (selfExample.isNavyColor == YES) {
        self.colorShowLabel.text = @"青";
    }
    if (selfExample.isBlueColor == YES) {
        self.colorShowLabel.text = @"蓝";
    }
    if (selfExample.isPurpleColor == YES) {
        self.colorShowLabel.text = @"紫";
    }
    if (selfExample.isBlackColor == YES) {
        self.colorShowLabel.text = @"黑";
    }
    //当开启夜间模式，背景颜色移除
    if (!selfExample.isGrayColor && !selfExample.isMeatColor && !selfExample.isTenderColor && !selfExample.isNavyColor && !selfExample.isBlueColor && !selfExample.isPurpleColor && !selfExample.isBlackColor) {
        self.colorShowLabel.text = @"";
    }
    if (selfExample.isPageCurl == YES) {    //根据翻页效果设置初始的开关状态,默认是关闭的
        [self.pageFlipSwitch setOn:YES];
    } else {
        [self.pageFlipSwitch setOn:NO];
    }
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(timerAction:)
                                   userInfo:nil
                                    repeats:YES];
    //字体颜色改变
    if (selfExample.isWhite == YES) {
        self.colorSegmented.selectedSegmentIndex = 1;
    } else {
        self.colorSegmented.selectedSegmentIndex = 0;
    }
    [self.colorSegmented addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    //字体样式
    UISegmentedControl *fontSegmented = [[UISegmentedControl alloc] initWithItems:@[@"默认",@"行书",@"宋体",@"娃娃篆"]];
    fontSegmented.frame = CGRectMake(115, 501, 200, 30);
    if ([selfExample.fontStyle isEqualToString:@"经典行书简"]) {
        fontSegmented.selectedSegmentIndex = 1;
    } else if ([selfExample.fontStyle isEqualToString:@"MF KeSong(Noncommercial)"]) {
        fontSegmented.selectedSegmentIndex = 2;
    } else if ([selfExample.fontStyle isEqualToString:@"迷你简娃娃篆"]) {
        fontSegmented.selectedSegmentIndex = 3;
    } else {
        fontSegmented.selectedSegmentIndex = 0;
    }
    [fontSegmented addTarget:self action:@selector(fontSegmentedAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:fontSegmented];
}
#pragma mark - fontSegmented响应
- (void)fontSegmentedAction:(UISegmentedControl *)sender {
    SelfExample *selfExample = [SelfExample shareInstance];
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            selfExample.fontStyle = @"默认";
            break;
        case 1:
            selfExample.fontStyle = @"经典行书简";
            break;
        case 2:
            selfExample.fontStyle = @"MF KeSong(Noncommercial)";
            break;
        case 3:
            selfExample.fontStyle = @"迷你简娃娃篆";
            break;
        default:
            break;
    }
}
#pragma mark - colorSegmented响应
- (void)segmentedAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    SelfExample *selfExample = [SelfExample shareInstance];
    switch (index) {
        case 0:
            selfExample.isWhite = NO;
            break;
        case 1:
            selfExample.isWhite = YES;
            break;
        default:
            break;
    }
}
#pragma mark - pivkerView的代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _data.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _data[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.sizeValue = [_data[row] integerValue];  //改变字体大小
}
#pragma mark - 定时器检测，开关打开就设定翻页模式为仿真
- (void)timerAction:(NSTimer *)timer {
    if (self.pageFlipSwitch.on == YES) {
        SelfExample *selfExample = [SelfExample shareInstance];
        selfExample.isPageCurl = YES;
    } else {
        SelfExample *selfExample = [SelfExample shareInstance];
        selfExample.isPageCurl = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)grayButton:(id)sender {
    self.colorShowLabel.text = @"灰";
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.isGrayColor = YES;
    selfExample.isMeatColor = NO;
    selfExample.isTenderColor = NO;
    selfExample.isNavyColor = NO;
    selfExample.isBlueColor = NO;
    selfExample.isPurpleColor = NO;
    selfExample.isBlackColor = NO;
}

- (IBAction)meatButton:(id)sender {
    self.colorShowLabel.text = @"肉";
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.isGrayColor = NO;
    selfExample.isMeatColor = YES;
    selfExample.isTenderColor = NO;
    selfExample.isNavyColor = NO;
    selfExample.isBlueColor = NO;
    selfExample.isPurpleColor = NO;
    selfExample.isBlackColor = NO;
}

- (IBAction)tenderButton:(id)sender {
    self.colorShowLabel.text = @"嫩";
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.isGrayColor = NO;
    selfExample.isMeatColor = NO;
    selfExample.isTenderColor = YES;
    selfExample.isNavyColor = NO;
    selfExample.isBlueColor = NO;
    selfExample.isPurpleColor = NO;
    selfExample.isBlackColor = NO;
}

- (IBAction)navyButton:(id)sender {
    self.colorShowLabel.text = @"青";
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.isGrayColor = NO;
    selfExample.isMeatColor = NO;
    selfExample.isTenderColor = NO;
    selfExample.isNavyColor = YES;
    selfExample.isBlueColor = NO;
    selfExample.isPurpleColor = NO;
    selfExample.isBlackColor = NO;
}

- (IBAction)blueButton:(id)sender {
    self.colorShowLabel.text = @"蓝";
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.isGrayColor = NO;
    selfExample.isMeatColor = NO;
    selfExample.isTenderColor = NO;
    selfExample.isNavyColor = NO;
    selfExample.isBlueColor = YES;
    selfExample.isPurpleColor = NO;
    selfExample.isBlackColor = NO;
}

- (IBAction)purpleButton:(id)sender {
    self.colorShowLabel.text = @"紫";
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.isGrayColor = NO;
    selfExample.isMeatColor = NO;
    selfExample.isTenderColor = NO;
    selfExample.isNavyColor = NO;
    selfExample.isBlueColor = NO;
    selfExample.isPurpleColor = YES;
    selfExample.isBlackColor = NO;
}

- (IBAction)blackButton:(id)sender {
    self.colorShowLabel.text = @"黑";
    SelfExample *selfExample = [SelfExample shareInstance];
    selfExample.isGrayColor = NO;
    selfExample.isMeatColor = NO;
    selfExample.isTenderColor = NO;
    selfExample.isNavyColor = NO;
    selfExample.isBlueColor = NO;
    selfExample.isPurpleColor = NO;
    selfExample.isBlackColor = YES;
}

- (IBAction)step:(UIStepper *)sender {
    if (sender.value >= 0 && sender.value <= 10) {
        NSString *string = [NSString stringWithFormat:@"%.1f", sender.value*0.1];
        self.shadeAlphaShowLabel.text = string;
        SelfExample *selfExample = [SelfExample shareInstance];
        selfExample.shadeAlphaValue = sender.value*0.1;
    }
}





@end
