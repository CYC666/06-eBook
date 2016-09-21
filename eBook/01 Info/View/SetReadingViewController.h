//
//  SetReadingViewController.h
//  eBook
//
//  Created by CYC on 16/5/4.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "BaseViewController.h"

@interface SetReadingViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UISwitch *pageFlipSwitch;
@property (weak, nonatomic) IBOutlet UILabel *colorShowLabel;

- (IBAction)grayButton:(id)sender;
- (IBAction)meatButton:(id)sender;
- (IBAction)tenderButton:(id)sender;
- (IBAction)navyButton:(id)sender;
- (IBAction)blueButton:(id)sender;
- (IBAction)purpleButton:(id)sender;
- (IBAction)blackButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *shadeAlphaShowLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegmented;


- (IBAction)step:(UIStepper *)sender;

@end
