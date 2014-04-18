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

@interface FOViewModel : NSObject

@property (nonatomic, copy) NSString *leftSideValue;
@property (nonatomic, copy) NSString *rightSideValue;
@property (nonatomic, strong) NSNumber *operator;
@property (nonatomic, readonly) RACCommand *calculateCommand;

@property (nonatomic, copy) NSString *resultString;

@end
