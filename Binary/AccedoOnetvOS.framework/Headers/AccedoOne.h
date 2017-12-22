//
//  AccedoOne.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

#import "AOService.h"
#import "AccedoOneInsight.h"
#import "AccedoOneDetect.h"
#import "AccedoOneUserData.h"

@class AOCMSOptionalParams;

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, AccedoOneServiceAvailability)
{
    AccedoOneServiceAvailabilityOnline,
    AccedoOneServiceAvailabilityOffline
};


/**
 * Application Status constants
 */
extern NSString * const AOApplicationStateActive;
extern NSString * const AOApplicationStateMaintenance;


/**
 * AccedoOne is the implementation of Accedo's AccedoOne REST API
 */
@interface AccedoOne : NSObject

#pragma mark - Lifecycle

/**
 * Property injection for AccedoOne.
 * Must be called in order to use the AccedoOne.
 */
- (instancetype) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid;
- (instancetype) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid requestTimeout:(NSTimeInterval)requestTimeout;

#pragma mark - Application Status

- (void) applicationStatus:(nullable void (^)(NSString *status, NSString *message, AOError *err))completionBlock;

#pragma mark - Metadata

- (void) allMetadata:(nullable void (^)(NSDictionary *allMetadata, AOError *err))completionBlock;
- (void) allMetadataForGID:(nullable NSString *)gid onComplete:(nullable void (^)(NSDictionary *allMetadata, AOError *err))completionBlock;

- (void) metadataForKey:(nonnull NSString *)key onComplete:(nullable void (^)(id metadata, AOError * error))completionBlock;
- (void) metadataForKey:(nonnull NSString *)key gid:(nullable NSString *)gid onComplete:(nullable void (^)(id metadata, AOError * error))completionBlock;
- (void) metadataForKeys:(nonnull NSArray<NSString *>*)keys gid:(nullable NSString *)gid onComplete:(nullable void (^)(id metadata, AOError * error))completionBlock;

#pragma mark - Profile Information

- (void) profileInfo:(nullable void (^)(NSDictionary* profileInfo, AOError* err))completionBlock;
- (void) profileInfoForGID:(nullable NSString*)gid onComplete:(nullable void (^)(NSDictionary* profileInfo, AOError* err))completionBlock;

#pragma mark - Assets

- (void) allAssets:(nullable void (^)(NSDictionary *assetsMetadata, AOError *err))completionBlock;
- (void) assetForKey:(NSString *)key onComplete:(nullable void (^)(NSData *asset, AOError *err))completionBlock;

#pragma mark - Content Entry Information (CMS)

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

#pragma mark - Logging (Analytics)

- (void) applicationStart;
- (void) applicationStartSuccess:(nullable AOSuccessBlock)completionBlock onFailure:(nullable AOErrorBlock)failureBlock;

- (void) applicationStop;
- (void) applicationStop:(BOOL)clearCache;

#pragma mark - Logging (Remote)

- (void) logWithLevel:(AOServiceLogLevel)logLevel code:(NSUInteger)code message:(NSString *)message dimensions:(NSDictionary * _Nullable)dimensions;

#pragma mark - User Data

- (void) allDataForUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void (^)(NSDictionary *userData, AOError *err))completionBlock;
- (void) storeData:(NSDictionary *)data forUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void(^)(AOError *err))completionBlock;
- (void) dataForUser:(NSString *)userId key:(NSString *)key scope:(AOUserDataScope)scope onComplete:(nullable void(^)(NSString *value, AOError *err))completionBlock;
- (void) storeValue:(NSString *)value key:(NSString *)key forUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void(^)(AOError *err))completionBlock;

#pragma mark - Locale

-(void) localesOnComplete:(nullable void (^)(NSArray *_Nullable locales, AOError *_Nullable err))completionBlock;

- (void) clearSession:(BOOL) clearCache;
- (void) sendAuthenticatedGETRequest:(NSString *)requestSuffix
                         queryParams:(NSDictionary* _Nullable)params
                          allowCache:(BOOL)allowCache
                           onSuccess:(AOSuccessBlock _Nullable)successBlock
                        failureBlock:(AOErrorBlock _Nullable)failureBlock;

- (void) sendAuthenticatedPOSTRequest:(NSString *)requestSuffix
                               params:(id _Nullable)params
                                 body:(NSData *)payload
                            onSuccess:(AOSuccessBlock _Nullable)completionBlock
                            onFailure:(AOErrorBlock _Nullable)failureBlock;

- (void) addDictionary:(NSDictionary *) dictionary toOfflineAccedoOneConfigWithKey:(NSString *) key;
- (NSDictionary *) dictionaryFromOfflineAccedoOneProfileWithKey:(NSString *) key;
- (NSDictionary *) dictionaryFromOfflineAccedoOneConfigWithKey:(NSString *) key;
- (NSString *) ifModifiedSinceDateForCachedObject:(NSString *)cacheKey cache:(id <AOCacheHandler>)cache;
- (void) setHeaderValue:(nonnull NSString *) value headerField:(nonnull NSString *) headerField;;
@property (nonatomic, assign) AccedoOneServiceAvailability serviceAvailability;
@property (nonatomic, strong, readonly) NSString *accedoOneURL;
@property (assign, readonly) NSTimeInterval requestTimeout;
@end

NS_ASSUME_NONNULL_END

