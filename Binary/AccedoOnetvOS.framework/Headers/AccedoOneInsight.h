//
//  AccedoOneInsight.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>
#import "AOServiceComponent.h"

NS_ASSUME_NONNULL_BEGIN


@class AccedoOne;

@interface AccedoOneInsight : NSObject
-(instancetype) initWithService:(AccedoOne *) service;

- (void) applicationStart;
- (void) applicationStartSuccess:(nullable AOSuccessBlock)completionBlock onFailure:(nullable AOErrorBlock)failureBlock;

- (void) applicationStop;
- (void) applicationStop:(BOOL)clearCache;

@end

NS_ASSUME_NONNULL_END
