//
//  AccedoOneControl.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AOError;
@class AccedoOne;

@interface AccedoOneControl : NSObject
-(instancetype) initWithService:(AccedoOne *) service;
- (void) applicationStatus:(void (^)(NSString *status, NSString *message, AOError *err))completionBlock;
- (void) profileInfo:(nullable void (^)(NSDictionary* profileInfo, AOError* err))completionBlock;
- (void) profileInfoForGID:(nullable NSString*)gid onComplete:(nullable void (^)(NSDictionary* profileInfo, AOError* err))completionBlock;
- (void) allMetadata:(nullable void (^)(NSDictionary *allMetadata, AOError *err))completionBlock;
- (void) allMetadataForGID:(nullable NSString *)gid onComplete:(nullable void (^)(NSDictionary *allMetadata, AOError *err))completionBlock;

- (void) metadataForKey:(nonnull NSString *)key onComplete:(nullable void (^)(id metadata, AOError * error))completionBlock;
- (void) metadataForKey:(nonnull NSString *)key gid:(nullable NSString *)gid onComplete:(nullable void (^)(id metadata, AOError * error))completionBlock;
- (void) metadataForKeys:(nonnull NSArray<NSString *>*)keys gid:(nullable NSString *)gid onComplete:(nullable void (^)(id metadata, AOError * error))completionBlock;

- (void) allAssets:(nullable void (^)(NSDictionary *assetsMetadata, AOError *err))completionBlock;
- (void) assetForKey:(NSString *)key onComplete:(nullable void (^)(NSData *asset, AOError *err))completionBlock;
- (void) clearCache;
@end

NS_ASSUME_NONNULL_END
