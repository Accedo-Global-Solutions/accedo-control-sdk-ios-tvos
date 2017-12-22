//
//  CacheController.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AOService+CacheController.h"



@implementation AOService(CacheController)

#pragma mark - AOService(CacheController)

- (CacheState)registerCacheQuery:(AOCacheDTO *)cacheDTO cachedObject:(id)cachedObject;
{
    // If nothing to invoke in the end, we simply return.
    if (!cacheDTO) return CacheStateUnknown;

    BOOL expired = NO;

    if ([self.cacheHandler conformsToProtocol:@protocol(AOTimeBasedCacheHandler)] && cachedObject)
    {
        expired = [(id<AOTimeBasedCacheHandler>)self.cacheHandler isKeyExpired:cacheDTO.cacheKey];
    }

    BOOL loading = NO;

    NSMutableArray * queue = [self queueForKey:cacheDTO.cacheKey addIfNew:NO];

    if (queue)
    {
        // Someone is already waiting for the cache state to be determined. We just add ourselves as well to the existing callback queue.
        TLog(@"AO-[cache]: Already fetching: Enqueue for callback");
        [queue addObject:cacheDTO];
        loading = YES;
    }

    CacheState state = CacheStateUnknown;
    
    NSString * logState = @"CacheStateUnknown";
    
    if (expired)
    {
        state |= CacheStateExpired;
        logState = @"CacheStateExpired";
    }
    if (loading)
    {
        state |= CacheStateLoading;
        logState = @"CacheStateLoading";
    }
    if (cachedObject != nil)
    {
        state |= CacheStateAvailable;
        logState = @"CacheStateAvailable";
    }

    TLog(@"AO-[cache]: Cache state for key:%@ => %@", cacheDTO.cacheKey, logState);

    return state;
}

- (void)enqueueCallerForKey:(NSString *)key
{
    [self queueForKey:key addIfNew:YES];
}

- (void)invalidateCacheForKey:(NSString *)key
{
    [self.cacheHandler clearObjectForKey:key];
}

- (void)invalidateAllCache
{
    [self.cacheHandler clearAllObjects];
}

#pragma mark - Fetching queue handling

/*! Returns the queue of blocks to invoke for an object with a given key.
 *  When multiple components request the same object, they'll get enqueued
 *  to be called once the state of the data is determined.
 *
 *  Until the outcome of a cache query operation is uncertain (e.g. because we're
 *  in the middle of fetching the resource), the callbacks are sitting in this queue.
 *
 *  If the parameter 'addIfNew' is true, a new queue will be created if not existing already.
 *  Otherwise nil is returned in this case.
 */
- (NSMutableArray *)queueForKey:(NSString *)key addIfNew:(BOOL)addIfNew
{
    NSMutableArray * queue = nil;

    @synchronized(self)
    {
        queue = [self.fetchQueues valueForKey:key];
    }

    if (queue == nil && addIfNew)
    {
        queue = [NSMutableArray new];

        @synchronized(self)
        {
            self.fetchQueues[key] = queue;
        }
    }

    return queue;
}

#pragma mark - Caller notification helpers

-(void) cacheResult:(id)result forRequest:(AORequestMetadata *)request
{
    if (result)
    {
        if ([self.cacheHandler conformsToProtocol:@protocol(AOTimeBasedCacheHandler)] /*&& request.cacheExpiration*/)
        {
            NSTimeInterval expiration = request.cacheExpiration ? [request.cacheExpiration doubleValue] : kAODefaultExpirationTime;

            [(id<AOTimeBasedCacheHandler>)self.cacheHandler setObject:result forKey:request.cacheKey withTimeStamp:[[NSDate date] timeIntervalSince1970] withExpirationInterval:expiration];
        }
        else
        {
            [self.cacheHandler setObject:result forKey:request.cacheKey];
        }
    }
}

- (void) notifyCallersForKey:(NSString *)key result:(id)result error:(AOError *)error
{
    NSArray *blocksToCall = [self popBlocksToCallForKey:key];

    for (AOCacheDTO * block in blocksToCall)
    {
        if (error && block.failure)
        {
            block.failure(error);
        }
        else if (result && block.success)
        {
            block.success(result);
        }
    }
}

#pragma mark - Ready block invokers

- (void)invokeBlockOnMainThread:(void(^)(void))block
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)invokeBlockOnMainThread:(void(^)(void))block sync:(BOOL)sync
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        if (sync)
        {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), block);
        }
    }
}

#pragma mark - Data Structure manipulation

- (NSArray *)popBlocksToCallForKey:(NSString *)key
{
    NSArray * blocksToCall = [self blocksToCallForKey:key];
    
    [self removeKeyFromQueue:key];
    
    return blocksToCall;
}

- (NSArray *)blocksToCallForKey:(NSString *)key
{
    NSArray * blocksToCall = nil;
    NSMutableArray * queue = [self queueForKey:key addIfNew:NO];

    if (queue.count > 0)
    {
        blocksToCall = queue;
    }
    
    return blocksToCall;
}

- (void)removeKeyFromQueue:(NSString *)key
{
    if (key == nil) return;
    @synchronized(self)
    {
        [self.fetchQueues removeObjectForKey:key];
    }
}

@end
