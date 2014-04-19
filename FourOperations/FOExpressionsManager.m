//
// Created by rizumita on 2014/04/19.
//


#import "FOExpressionsManager.h"
#import "Expression.h"


@implementation FOExpressionsManager
{

}

- (id)init
{
    self = [super init];
    if (self) {
        [[[Expression findAll] fetch] subscribeNext:^(id x) {
            self.expressions = x;
        }];
        RAC(self, expressions) = [[Expression findAll] fetchWithTrigger:[NSManagedObjectContext currentContext].rcd_merged];
    }
    return self;
}

- (NSInteger)numberOfExpressions
{
    return self.expressions.count;
}

- (Expression *)expressionAtIndex:(NSInteger)index
{
    return self.expressions[(NSUInteger)index];
}

@end