//
//  AOCache.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

#import "AOCacheHandler.h"

@class AOCacheAtom;

@interface AOCache : NSObject<AOTimeBasedCacheHandler>

+ (AOCache *)cacheProvider:(Class)clazz persistenceKey:(NSString *)persistenceKey defaultExpiration:(NSTimeInterval)defaultExpiration;

@end
