//
//  AOAsynchBlockOperation,h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

typedef void (^AOOperationBlock)(void);

/*! @brief An asynchronous operation that waits until it's being marked as finished, upon completion of the block. */
@interface AOAsynchBlockOperation : NSOperation

@property (nonatomic, assign, readonly) BOOL isExecuting;
@property (nonatomic, assign, readonly) BOOL isFinished;

-(void) addOperationBlock:(AOOperationBlock)block;
-(void) markAsFinished;

@end
