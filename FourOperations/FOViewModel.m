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

- (id)init
{
    self = [super init];
    if (self) {
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

@end
