//
//  AccedoOneUserDataProtocol.h
//  AccedoOne
//
//  Copyright (c) 2018 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

@class AOError;

/**
 * Scope for getting/storing UserData from AccedoOne
 */
typedef NS_ENUM(NSUInteger, AOUserDataScope) {
    AOUserDataScopeApplication,
    AOUserDataScopeApplicationGroup
};

@protocol AccedoOneUserDataProtocol <NSObject>

- (void) allDataForUser:(nonnull NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void (^)(NSDictionary * _Nullable userData, AOError * _Nullable err))completionBlock;
- (void) storeData:(nonnull NSDictionary *)data forUser:(nonnull NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void(^)(AOError * _Nullable err))completionBlock;
- (void) dataForUser:(nonnull NSString *)userId key:(nonnull NSString *)key scope:(AOUserDataScope)scope onComplete:(nullable void(^)(NSString * _Nullable value, AOError * _Nullable err))completionBlock;
- (void) storeValue:(nonnull NSString *)value key:(nonnull NSString *)key forUser:(nonnull NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void(^)(AOError * _Nullable err))completionBlock;

@end
