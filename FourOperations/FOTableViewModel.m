//
//  FOTableViewModel.m
//  FourOperations
//
//  Created by 和泉田 領一 on 2014/04/19.
//  Copyright (c) 2014年 CAPH. All rights reserved.
//

#import "FOTableViewModel.h"
#import "Expression.h"
#import "FOExpressionsManager.h"

@interface FOTableViewModel ()
@property (nonatomic, strong) FOExpressionsManager *expressionsManager;
@end

@implementation FOTableViewModel
@synthesize shouldReloadDataSignal = _shouldReloadDataSignal;

- (id)initWithExpressionsManager:(FOExpressionsManager *)expressionsManager
{
    self = [super init];
    if (self) {
        _expressionsManager = expressionsManager;
        
        _shouldReloadDataSignal = RACObserve(_expressionsManager, expressions);
    }
    return self;
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
