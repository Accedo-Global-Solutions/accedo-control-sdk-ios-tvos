//
//  AccedoOneUserData.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AccedoOne;
@class AOError;
/**
 * Scope for getting/storing UserData from AccedoOne
 */
typedef NS_ENUM(NSUInteger, AOUserDataScope) {
    AOUserDataScopeApplication,
    AOUserDataScopeApplicationGroup
};


@interface AccedoOneUserData : NSObject
-(instancetype) initWithService:(AccedoOne *) service;

- (void) allDataForUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void (^)(NSDictionary *userData, AOError *err))completionBlock;
- (void) storeData:(NSDictionary *)data forUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void(^)(AOError *err))completionBlock;
- (void) dataForUser:(NSString *)userId key:(NSString *)key scope:(AOUserDataScope)scope onComplete:(nullable void(^)(NSString *value, AOError *err))completionBlock;
- (void) storeValue:(NSString *)value key:(NSString *)key forUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void(^)(AOError *err))completionBlock;

@end

NS_ASSUME_NONNULL_END
