#import "Expression.h"


@interface Expression ()

// Private interface goes here.

@end


@implementation Expression

- (NSString *)expressionString
{
    return [NSString stringWithFormat:@"%@ %@ %@ = %@", self.leftSideValue, self.operator, self.rightSideValue, self.result];
}

@end
