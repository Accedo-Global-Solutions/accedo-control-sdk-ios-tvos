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




@class AccedoOne;

@interface AccedoOneInsight : NSObject
-(instancetype _Nonnull ) initWithService:(AccedoOne *_Nonnull) service;

- (void) applicationStart;
- (void) applicationStartSuccess:(nullable AOSuccessBlock)completionBlock onFailure:(nullable AOErrorBlock)failureBlock;

- (void) applicationStop;
- (void) applicationStop:(BOOL)clearCache;

@end


