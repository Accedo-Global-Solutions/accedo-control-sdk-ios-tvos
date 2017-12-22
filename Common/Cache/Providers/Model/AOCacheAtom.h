//
//  AOCacheAtom.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

/**
 *  An object to be used internally by the cache
 *  It decorates the values passed to the cache, adding an expiration flag.
 *  The expiration flag will be set to YES after the expiration interval has been completed.
 */
@interface AOCacheAtom : NSObject<NSCoding>

@property (strong, nonatomic) NSObject<NSCoding> * payload;

@property (assign, nonatomic) NSTimeInterval creationTime;

@property (assign, nonatomic) NSTimeInterval expirationTime;

/**
 *  Designated initializer
 *
 *  @param payload    the actual object added to the cache
 *  @param created    the timestamp when the object is cached
 *  @param timeToLive the object expiration time
 *
 *  @return an instance of CachedObject set up with an actual object, an initial timestamp and an expiration interval
 */
- (instancetype)initWithPayload:(id<NSCoding>)payload
                   creationTime:(NSTimeInterval)created
                      expiresIn:(NSTimeInterval)timeToLive;

- (BOOL)hasExpired;

- (void)resurrect;

@end
