//
//  AOCacheHandlerProtocol.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//
#import <Foundation/Foundation.h>

static const NSUInteger kAODefaultExpirationTime = 3600;


@protocol AOCacheHandler <NSObject>

@required

- (id)initWithPersistenceKey:(NSString *)persistenceKey defaultExpirationTime:(NSTimeInterval)defaultExpirationTime;

#pragma mark - Set/Get

-(void) setObject: (NSObject<NSCoding> *) anObject forKey: (NSString *) key;

-(id<NSCoding>) objectForKey: (NSString *) key;

- (NSTimeInterval) creationDateForKey: (NSString *) key;

#pragma mark - Manual eviction

-(void) clearObjectForKey: (NSString *) key;

-(void) clearAllObjects;

@end



@protocol AOTimeBasedCacheHandler<AOCacheHandler>

-(void) setObject: (id<NSCoding>) anObject forKey: (NSString *) key withTimeStamp: (NSTimeInterval) timeStamp withExpirationInterval: (NSTimeInterval) specificExpirationInterval;

- (NSTimeInterval) expirationTimeForCachedItemWithKey:(NSString *) key;

-(BOOL) isKeyExpired: (NSString *) key;



@end
