//
//  FOViewModel.m
//  FourOperations
//
//  Created by 和泉田 領一 on 2014/04/18.
//  Copyright (c) 2014年 CAPH. All rights reserved.
//

#import "FOViewModel.h"
#import "Expression.h"
#import "FOExpressionsManager.h"

@interface FOViewModel ()
@property (nonatomic, readonly) NSString *operatorString;
@end

@implementation FOViewModel
@synthesize shouldReloadDataSignal = _shouldReloadDataSignal;

- (id)initWithExpressionsManager:(FOExpressionsManager *)expressionsManager
{
    self = [super init];
    if (self) {
        _expressionsManager = expressionsManager;

        _shouldReloadDataSignal = RACObserve(_expressionsManager, expressions);

        @weakify(self);
        [[[[[RACObserve(self, resultString) subscribeOn:[RACScheduler mainThreadScheduler]] filter:^BOOL(NSString *result) {
            return result.length > 0;
        }] performInBackgroundContext:^(NSManagedObjectContext *context) {
            @strongify(self);
            [Expression insert:^(Expression *expression) {
                expression.leftSideValue = self.leftSideValue;
                expression.operator = self.operatorString;
                expression.rightSideValue = self.rightSideValue;
                expression.result = self.resultString;
            }];
        }] saveContext] subscribeNext:^(id x) { }];
    }
    return self;
}

- (RACCommand *)calculateCommand
{
    @weakify(self);
    return [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[RACObserve(self, leftSideValue), RACObserve(self, rightSideValue)] reduce:(id (^)())^id(NSString *leftSideValue, NSString *rightSideValue) {
        return @(leftSideValue.length > 0 && rightSideValue.length > 0);
    }]                             signalBlock:^RACSignal *(id input) {
        @strongify(self);

        NSDecimalNumber *left = [NSDecimalNumber decimalNumberWithString:self.leftSideValue];
        NSDecimalNumber *right = [NSDecimalNumber decimalNumberWithString:self.rightSideValue];

        switch (self.operator.integerValue) {
            case 0:
                self.resultString = [left decimalNumberByAdding:right].stringValue;
                break;
            case 1:
                self.resultString = [left decimalNumberBySubtracting:right].stringValue;
                break;
            case 2:
                self.resultString = [left decimalNumberByMultiplyingBy:right].stringValue;
                break;
            case 3:
                self.resultString = [left decimalNumberByDividingBy:right].stringValue;
                break;
            default:
                self.resultString = @"エラー";
        }

        return [RACSignal empty];
    }];
}

- (NSString *)operatorString
{
    switch (self.operator.integerValue) {
        case 0:
            return @"+";
        case 1:
            return @"-";
        case 2:
            return @"×";
        case 3:
            return @"÷";
        default:
            return @"";
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expressionsManager.numberOfExpressions;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Expression *expression = [self.expressionsManager expressionAtIndex:indexPath.row];
    cell.textLabel.text = expression.expressionString;
}

@end
