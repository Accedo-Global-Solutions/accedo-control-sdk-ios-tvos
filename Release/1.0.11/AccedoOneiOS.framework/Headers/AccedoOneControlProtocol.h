//
//  AccedoOneControlProtocol.h
//  AccedoOne
//
//  Copyright (c) 2018 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

@class AOError;

@protocol AccedoOneControlProtocol <NSObject>

- (void) applicationStatus:(void (^_Nonnull)(NSString * _Nullable status, NSString * _Nullable message,  AOError * _Nullable err))completionBlock;

- (void) profileInfo:(nullable void (^)(NSDictionary* _Nullable profileInfo, AOError* _Nullable err))completionBlock;
- (void) profileInfoForGID:(nullable NSString*)gid onComplete:(nullable void (^)(NSDictionary* _Nullable profileInfo, AOError* _Nullable err))completionBlock;

- (void) allMetadata:(nullable void (^)(NSDictionary * _Nullable allMetadata, AOError * _Nullable err))completionBlock;
- (void) allMetadataForGID:(nullable NSString *)gid onComplete:(nullable void (^)(NSDictionary * _Nullable allMetadata, AOError * _Nullable err))completionBlock;

- (void) metadataForKey:(nonnull NSString *)key onComplete:(nullable void (^)(id _Nullable metadata, AOError * _Nullable error))completionBlock;
- (void) metadataForKey:(nonnull NSString *)key gid:(nullable NSString *)gid onComplete:(nullable void (^)(id _Nullable metadata, AOError * _Nullable error))completionBlock;
- (void) metadataForKeys:(nonnull NSArray<NSString *>*)keys gid:(nullable NSString *)gid onComplete:(nullable void (^)(id _Nullable metadata, AOError * _Nullable error))completionBlock;

- (void) allAssets:(nullable void (^)(NSDictionary * _Nullable assetsMetadata, AOError *_Nullable err))completionBlock;
- (void) allAssetsForGID:(nullable NSString *)gid onComplete:(nullable void (^)(NSDictionary * _Nullable assetsMetadata, AOError *_Nullable err))completionBlock;

- (void) assetForKey:(nonnull NSString *)key onComplete:(nullable void (^)(NSData * _Nullable asset, AOError * _Nullable err))completionBlock;

@end
