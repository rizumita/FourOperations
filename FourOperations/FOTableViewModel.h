//
//  FOTableViewModel.h
//  FourOperations
//
//  Created by 和泉田 領一 on 2014/04/19.
//  Copyright (c) 2014年 CAPH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FOExpressionsManager;

@interface FOTableViewModel : NSObject <UITableViewDataSource>

@property (nonatomic, strong, readonly) RACSignal *shouldReloadDataSignal;

- (id)initWithExpressionsManager:(FOExpressionsManager *)expressionsManager;

@end
