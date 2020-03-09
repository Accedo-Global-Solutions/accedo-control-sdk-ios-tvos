//
//  AccedoOnePublish.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>
#import "AccedoOnePublishProtocol.h"

@class AccedoOne;
@class AOError;
@class AOPageResult;
@class AOCMSOptionalParams;

@interface AccedoOnePublish : NSObject <AccedoOnePublishProtocol>

- (instancetype _Nonnull) initWithService:(AccedoOne *_Nonnull) service;

@end
