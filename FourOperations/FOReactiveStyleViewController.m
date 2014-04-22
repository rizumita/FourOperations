//
//  FOReactiveStyleViewController.m
//  FourOperations
//
//  Created by 和泉田 領一 on 2014/04/18.
//  Copyright (c) 2014年 CAPH. All rights reserved.
//

#import "FOReactiveStyleViewController.h"
#import "FOViewModel.h"

@interface FOReactiveStyleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *leftSideTextField;    // 左項値
@property (weak, nonatomic) IBOutlet UISegmentedControl *operators;     // 演算子
@property (weak, nonatomic) IBOutlet UITextField *rightSideTextField;   // 右項値
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;         // 計算ボタン
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;              // 結果ラベル
@property (nonatomic, strong) FOViewModel *viewModel;                   // ViewModel
@end

@implementation FOReactiveStyleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.viewModel = [[FOViewModel alloc] init];

    RAC(self.viewModel, leftSideValue) = self.leftSideTextField.rac_textSignal;
    RAC(self.viewModel, rightSideValue) = self.rightSideTextField.rac_textSignal;
    RAC(self.viewModel, operator) = [self.operators rac_newSelectedSegmentIndexChannelWithNilValue:@(0)];

    self.calculateButton.rac_command = self.viewModel.calculateCommand;
    RAC(self.resultLabel, text) = RACObserve(self.viewModel, resultString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
