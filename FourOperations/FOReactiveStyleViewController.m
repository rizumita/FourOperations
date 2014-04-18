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
@property (weak, nonatomic) IBOutlet UITextField *leftSideTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *operators;
@property (weak, nonatomic) IBOutlet UITextField *rightSideTextField;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) FOViewModel *viewModel;
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
