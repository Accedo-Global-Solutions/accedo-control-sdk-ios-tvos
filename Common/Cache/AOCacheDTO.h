//
//  CacheStateHandler.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

#import "AOService.h"

/**
 * When a query is made to the cache, the result will be one of the states in the CacheState` enum. 
 * Appropriate action is taken depending on the current state.
 */
typedef NS_ENUM(NSUInteger, CacheState)
{
    /**
     * Neutral flag, if this is the value, we can say nothing.
     * This value indicates weirdness.
     */
    CacheStateUnknown   = 0,

    /**
     * The requested key is found in the cache and non-expired.
     */
    CacheStateAvailable = 1,

    /**
     * The request key is found in the cache, but is expired. A refetching will be initiated.
     *
     * @warning In this case, the success blocks are called twice. First with the expired model (on a better than nothing basis).
     */
    CacheStateExpired   = 1<<1,

    /**
     * The requested key is not available in the cache, and is loading.
     *
     * The request is put on hold, until response arrives, or ongoing request fails. 
     * Appropriate blocks are called when we're done loading.
     */
    CacheStateLoading   = 1<<2,

    /**
     * The requested key is not available in the cache, and last fetch attempt failed.
     *
     * The retry responsibility is passed to the user of the `WSResource`.
     */
    CacheStateFailed    = 1<<3,

    /**
     * The corresponding operation was cancelled. We need to fail.
     */
    CacheStateCancelled = 1<<4
};

/*! Creates a reusable block, which will get called all the time the cache state of an object changes.
 *  Possible outcomes:
 *
 *  1. The object was not available, but fetching it failed the last time we tried.
 *  In this case the sequence is abandoned, and the failure block is called for the request.
 *§
 *  2. The object is available in the cache, but it was expired.
 *
 *  In this case we call the success block with the old data, but we also go to the backend
 *  for an update.
 *
 *  3. The object is available in the cache, and it's not expired.
 *
 *  In this case we invoke the success block, and return.
 *
 *  4. The object is not available in the cache, and no one is currently fetching it.
 *
 *  In this case we initiate a call to the backend ourselves.
 *
 *  5. The object is not available in the cache, but someone else is already fetching it.
 *
 *  In this case we stand back doing nothing, and wait until we get invoked again when loading finished.
 */
@interface AOCacheDTO : NSObject

@property (nonatomic, copy) AOSuccessBlock success;
@property (nonatomic, copy) AOErrorBlock failure;

@property (nonatomic, strong) NSString * cacheKey;

@end
