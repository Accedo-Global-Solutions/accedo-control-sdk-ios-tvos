//
//  AOAsynchBlockOperation.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//


#import "AOAsynchBlockOperation.h"

static NSString *const kIsExecutingKey  = @"isExecuting";
static NSString *const kIsFinishedKey   = @"isFinished";

@interface AOAsynchBlockOperation()
@property (nonatomic, copy) AOOperationBlock operationBlock;
@end


@implementation AOAsynchBlockOperation

- (instancetype)init {
    if (self = [super init]) {
        _isExecuting = NO;
        _isFinished = NO;
    }
    return self;
}

+(instancetype) operationWithBlock:(AOOperationBlock)block {
    AOAsynchBlockOperation *op = [[AOAsynchBlockOperation alloc] init];
    [op addOperationBlock:block];
    return op;
}

- (void) addOperationBlock:(AOOperationBlock)block {
    self.operationBlock = block;
}

- (void) markAsFinished {
    [self finish];
}

- (BOOL)isConcurrent { //will be deprecated, use isAsynchronous instead...
    return YES;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void) start {
    [self willChangeValueForKey: kIsExecutingKey];
    _isExecuting = YES;
    [self didChangeValueForKey: kIsExecutingKey];

    if (self.operationBlock)
    {
        self.operationBlock();
    }
}

- (void) finish {
    [self willChangeValueForKey: kIsExecutingKey];
    [self willChangeValueForKey: kIsFinishedKey];

    _isExecuting = NO;
    _isFinished = YES;

    [self didChangeValueForKey: kIsExecutingKey];
    [self didChangeValueForKey: kIsFinishedKey];
}

@end
