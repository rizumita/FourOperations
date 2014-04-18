//
// Created by rizumita on 2014/04/19.
//


#import <Foundation/Foundation.h>

@class Expression;

@interface FOExpressionsManager : NSObject
@property (nonatomic, readonly) NSInteger numberOfExpressions;

@property (nonatomic, strong) NSArray *expressions;

- (Expression *)expressionAtIndex:(NSInteger)index;
@end