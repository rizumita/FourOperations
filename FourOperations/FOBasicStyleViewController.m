//
// Created by rizumita on 2014/04/18.
//


#import "FOBasicStyleViewController.h"

@interface FOBasicStyleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *leftSideTextField;    // 左項値
@property (weak, nonatomic) IBOutlet UISegmentedControl *operators;     // 演算子
@property (weak, nonatomic) IBOutlet UITextField *rightSideTextField;   // 右項値
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;         // 計算ボタン
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;              // 結果ラベル

- (IBAction)textFieldDidChange:(id)sender;
- (IBAction)calculate:(id)sender;
@end

@implementation FOBasicStyleViewController
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(id)sender {
    self.calculateButton.enabled = self.leftSideTextField.text.length > 0 && self.rightSideTextField.text.length > 0;
}

- (IBAction)calculate:(id)sender
{
    NSDecimalNumber *left = [NSDecimalNumber decimalNumberWithString:self.leftSideTextField.text];
    NSDecimalNumber *right = [NSDecimalNumber decimalNumberWithString:self.rightSideTextField.text];

    switch (self.operators.selectedSegmentIndex) {
        case 0:
            self.resultLabel.text = [left decimalNumberByAdding:right].stringValue;
            break;
        case 1:
            self.resultLabel.text = [left decimalNumberBySubtracting:right].stringValue;
            break;
        case 2:
            self.resultLabel.text = [left decimalNumberByMultiplyingBy:right].stringValue;
            break;
        case 3:
            self.resultLabel.text = [left decimalNumberByDividingBy:right].stringValue;
            break;
        default:
            self.resultLabel.text = @"エラー";
    }
}

@end