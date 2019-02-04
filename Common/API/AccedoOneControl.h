//
//  AccedoOneControl.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>
#import "AccedoOneControlProtocol.h"

@class AOError;
@class AccedoOne;

@interface AccedoOneControl : NSObject <AccedoOneControlProtocol>

- (instancetype _Nonnull) initWithService:(AccedoOne *_Nonnull) service assetCacheExpirationInterval: (NSNumber * _Nullable) assetCacheExpirationInterval;
- (void) clearCache;

@end


