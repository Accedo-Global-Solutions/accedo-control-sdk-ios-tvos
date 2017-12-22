//
//  AccedoOnePublish.h
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
@class AOPageResult;
@class AOCMSOptionalParams;

@interface AccedoOnePublish : NSObject
-(instancetype) initWithService:(AccedoOne *) service;

- (void) entryForId:(nonnull NSString*)entryId onComplete:(nullable void (^)(NSDictionary *entry, AOError *err))completionBlock;
- (void) entryForId:(nonnull NSString*)entryId optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void (^)(NSDictionary *entry, AOError *err))completionBlock;

- (void) entriesForIds:(nonnull NSArray<__kindof NSString*>*)contentIds onComplete:(nullable void (^)(NSArray *entries, AOError *err))completionBlock;
- (void) entriesForIds:(nonnull NSArray<__kindof NSString*>*)contentIds optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(NSArray *entries, AOError *err))completionBlock;

- (void) entriesForAliases:(nonnull NSArray<__kindof NSString*>*)aliases onComplete:(nullable void (^)(NSArray *entries, AOError *err))completionBlock;
- (void) entriesForAliases:(nonnull NSArray<__kindof NSString*>*)aliases optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(NSArray *entries, AOError *err))completionBlock;

- (void) entriesForTypeAlias:(nonnull NSString*)alias onComplete:(nullable void (^)(NSArray *entries, AOError *err))completionBlock;
- (void) entriesForTypeAlias:(nonnull NSString*)alias optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(NSArray *entries, AOError *err))completionBlock;

- (void) entriesForType:(nonnull NSString *)typeId onComplete:(nullable void (^)(AOPageResult *result, AOError *err))completionBlock;
- (void) entriesForType:(nonnull NSString *)typeId optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(AOPageResult *result, AOError *err))completionBlock;

- (void) allEntries:(nullable void (^)(AOPageResult *result, AOError *err))completionBlock;
- (void) allEntriesForParams:(nonnull AOCMSOptionalParams *)params onComplete:(nullable void (^)(AOPageResult *result, AOError *err))completionBlock;
-(void) localesOnComplete:(nullable void (^)(NSArray *_Nullable locales, AOError *_Nullable err))completionBlock;
@end

NS_ASSUME_NONNULL_END
