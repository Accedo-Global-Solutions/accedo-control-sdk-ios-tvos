//
//  CacheController.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>
#import "AOService.h"
#import "AOCacheDTO.h"

@class AOServiceComponent;
 

/**
 * AOService(CacheController) category is responsible for managing cache related actions.
 * It registers and
 *
 */
@interface AOService(CacheController)

#pragma mark - Cache state

- (CacheState) registerCacheQuery:(AOCacheDTO *)cacheHandler cachedObject:(id)cachedObject;

/**
 * enqueueCallerForKey will create a queue (list) for the given key
 */
- (void) enqueueCallerForKey:(NSString *)key;

/**
 * notifyCallersForKey notifes all callers in the queue by invoking either the success or failure block (depending on "result" and "error")
 */
- (void) notifyCallersForKey:(NSString *)key result:(id)result error:(AOError *)error;

/**
 * cacheResult will invoke the cacheHandler->setObject and persist the result parameter.
 */
- (void) cacheResult:(id)result forRequest:(AORequestMetadata *)request;

#pragma mark - Cache eviction

- (void) invalidateCacheForKey:(NSString *)key;
- (void) invalidateAllCache;

- (void) invokeBlockOnMainThread:(void(^)(void))block;
- (void) invokeBlockOnMainThread:(void(^)(void))block sync:(BOOL)sync;

@end
