//
//  AOCache.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AOCache.h"
#import "AOCacheAtom.h"
#import "AOCacheOverNSCache.h"
#import "AOCacheOverPINCache.h"

@protocol AOCacheInternal

- (id)createInternalCache:(NSString *)persistenceKey;

- (AOCacheAtom *)cacheAtomForKey:(NSString *)key;

- (void)setCacheAtom:(AOCacheAtom *)atom forKey:(NSString *)key;

- (void)removeCacheAtomForKey:(NSString *)key;

@end


@interface AOCache()

@property (nonatomic, assign) NSTimeInterval defaultExpirationTime;
@property (nonatomic, strong) id internalCache;

@end

@implementation AOCache

+ (AOCache *)cacheProvider:(Class)clazz persistenceKey:(NSString *)persistenceKey defaultExpiration:(NSTimeInterval)defaultExpiration
{
    if ([clazz conformsToProtocol:@protocol(AOCacheHandler)])
    {
        return [[clazz alloc] initWithPersistenceKey:persistenceKey defaultExpirationTime:defaultExpiration];
    }

    return nil;
}

#pragma mark - AOCacheInternal

- (id)createInternalCache:(NSString *)persistenceKey
{
    return [[NSMutableDictionary alloc] init];
}

- (AOCacheAtom *)cacheAtomForKey:(NSString *)key
{
    return [self.internalCache objectForKey:key];
}

- (void)setCacheAtom:(AOCacheAtom *)atom forKey:(NSString *)key
{
    if (atom != nil) {
        [self.internalCache setObject:atom forKey:key];
    } else {
        //WLog(@"AO-[cache]: ]Nil atom was tried to be stored in cache");
    }
}

- (void)removeCacheAtomForKey:(NSString *)key
{
    [self.internalCache removeObjectForKey:key];
}

#pragma mark - AOCacheHandler methods

- (id)initWithPersistenceKey:(NSString *)persistenceKey defaultExpirationTime:(NSTimeInterval)defaultExpirationTime
{
    self = [super init];
    if (self)
    {
        self.internalCache = [self createInternalCache:persistenceKey];
        self.defaultExpirationTime = defaultExpirationTime;
    }
    return self;
}

- (void)setObject:(NSObject<NSCoding> *)anObject forKey:(NSString *)key
{
    [self setObject:anObject forKey:key
      withTimeStamp:[[NSDate date] timeIntervalSince1970] withExpirationInterval:self.defaultExpirationTime];
}

- (void)setObject:(NSObject<NSCoding> *)anObject forKey:(NSString *)key withTimeStamp:(NSTimeInterval)timeStamp
{
    [self setObject:anObject forKey:key withTimeStamp:timeStamp withExpirationInterval:self.defaultExpirationTime];
}

- (void)setObject:(NSObject<NSCoding> *)anObject forKey:(NSString *)key withTimeStamp:(NSTimeInterval)timeStamp withExpirationInterval:(NSTimeInterval)specificExpirationInterval
{
    if (anObject != nil && key != nil)
    {
        AOCacheAtom * current = [self cacheAtomForKey:key];
        
        if ((current) && [(id)current.payload isEqual:anObject])
        {
            current.creationTime = timeStamp;
            current.expirationTime = timeStamp + specificExpirationInterval;
            current.payload = anObject;
        }
        else
        {
            current = [[AOCacheAtom alloc] initWithPayload:anObject creationTime:timeStamp expiresIn:specificExpirationInterval];
        }

        [self setCacheAtom:current forKey:key];
    }
}

- (id<NSCoding>)objectForKey:(NSString *)key
{
    AOCacheAtom * a = [self cacheAtomForKey:key];

    if (a && a.payload == nil)
    {
        //ELog(@"AO-[cache]: Cached object with empty payload in Cache!!!!");
        [self clearObjectForKey:key];
    }

    return a.payload;
}

- (void)clearObjectForKey:(NSString *)key
{
    [self.internalCache removeObjectForKey:key];
}

- (void)clearAllObjects
{
    [self.internalCache removeAllObjects];
}

#pragma mark - AOTimeBasedCacheHandler

- (NSTimeInterval)expirationTimeForCachedItemWithKey:(NSString *)key
{
    AOCacheAtom * a = [self.internalCache objectForKey:key];

    if (a == nil || a.payload == nil)
    {
        [self clearObjectForKey:key];
        return 0;
    }

    return [a expirationTime];
}

- (BOOL)isKeyExpired:(NSString *)key
{
    AOCacheAtom * a = [self.internalCache objectForKey:key];

    if (a == nil || a.payload == nil)
    {
        [self clearObjectForKey:key];
        return NO;
    }

    //TLog(@"AO-[cache]: isKeyExpired? key: %@ | %@ | payload: %@", key, [a hasExpired] ? @"YES" : @"NO", a.payload);

    return [a hasExpired];
}

- (void)reactivateCacheForKey:(NSString *)key
{
    AOCacheAtom * a = [self.internalCache objectForKey:key];
    [a resurrect];
    [self.internalCache setObject:a forKey:key];
}

- (NSTimeInterval)creationDateForKey:(NSString *)key
{
    AOCacheAtom * a = [self.internalCache objectForKey:key];
    return a.creationTime;
}

@end
