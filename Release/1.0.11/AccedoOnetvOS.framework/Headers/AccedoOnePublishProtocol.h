//
//  AccedoOnePublishProtocol.h
//  AccedoOne
//
//  Copyright (c) 2018 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

@class AOError;
@class AOCMSOptionalParams;
@class AOPageResult;

@protocol AccedoOnePublishProtocol <NSObject>

- (void) entryForId:(nonnull NSString*)entryId onComplete:(nullable void (^)(NSDictionary * _Nullable entry, AOError * _Nullable err))completionBlock;
- (void) entryForId:(nonnull NSString*)entryId optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void (^)(NSDictionary * _Nullable entry, AOError * _Nullable err))completionBlock;

- (void) entriesForIds:(nonnull NSArray<__kindof NSString*>*)contentIds onComplete:(nullable void (^)(NSArray * _Nullable entries, AOError * _Nullable err))completionBlock;
- (void) entriesForIds:(nonnull NSArray<__kindof NSString*>*)contentIds optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(NSArray * _Nullable entries, AOError * _Nullable err))completionBlock;

- (void) entriesForAliases:(nonnull NSArray<__kindof NSString*>*)aliases onComplete:(nullable void (^)(NSArray * _Nullable entries, AOError * _Nullable err))completionBlock;
- (void) entriesForAliases:(nonnull NSArray<__kindof NSString*>*)aliases optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(NSArray * _Nullable entries, AOError * _Nullable err))completionBlock;

- (void) entriesForTypeAlias:(nonnull NSString*)alias onComplete:(nullable void (^)(NSArray * _Nullable entries, AOError * _Nullable err))completionBlock;
- (void) entriesForTypeAlias:(nonnull NSString*)alias optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(NSArray * _Nullable entries, AOError * _Nullable err))completionBlock;

- (void) entriesForType:(nonnull NSString *)typeId onComplete:(nullable void (^)(AOPageResult * _Nullable result, AOError * _Nullable err))completionBlock;
- (void) entriesForType:(nonnull NSString *)typeId optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(AOPageResult * _Nullable result, AOError * _Nullable err))completionBlock;

- (void) allEntries:(nullable void (^)(AOPageResult * _Nullable result, AOError * _Nullable err))completionBlock;
- (void) allEntriesForParams:(nonnull AOCMSOptionalParams *)params onComplete:(nullable void (^)(AOPageResult * _Nullable result, AOError * _Nullable err))completionBlock;

- (void) localesOnComplete:(nullable void (^)(NSArray *_Nullable locales, AOError *_Nullable err))completionBlock;

@end
