//
//  FOViewModel.h
//  FourOperations
//
//  Created by 和泉田 領一 on 2014/04/18.
//  Copyright (c) 2014年 CAPH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

@class FOExpressionsManager;

@interface FOViewModel : NSObject <UITableViewDataSource>

@property (nonatomic, copy) NSString *leftSideValue;
@property (nonatomic, copy) NSString *rightSideValue;
@property (nonatomic, strong) NSNumber *operator;
@property (nonatomic, readonly) RACCommand *calculateCommand;

@property (nonatomic, copy) NSString *resultString;

@property (nonatomic, strong) FOExpressionsManager *expressionsManager;
@property (nonatomic, strong, readonly) id shouldReloadDataSignal;

- (id)initWithExpressionsManager:(FOExpressionsManager *)expressionsManager;
@end
