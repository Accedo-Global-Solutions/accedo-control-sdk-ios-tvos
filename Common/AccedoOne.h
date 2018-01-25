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
#import "AOCMSOptionalParams.h"





typedef NS_ENUM(NSUInteger, AccedoOneServiceAvailability)
{
    AccedoOneServiceAvailabilityOnline,
    AccedoOneServiceAvailabilityOffline
};


/**
 * Application Status constants
 */
extern NSString * _Nonnull const AOApplicationStateActive;
extern NSString * _Nonnull const AOApplicationStateMaintenance;


/**
 * AccedoOne is the implementation of Accedo's AccedoOne REST API
 */
@interface AccedoOne : NSObject

#pragma mark - Lifecycle

/**
 * Property injection for AccedoOne.
 * Must be called in order to use the AccedoOne.
 */
- (instancetype _Nonnull ) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid;
- (instancetype _Nonnull ) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid requestTimeout:(NSTimeInterval)requestTimeout;

#pragma mark - Application Status

- (void) applicationStatus:(nullable void (^)(NSString * _Nullable status, NSString * _Nullable message, AOError * _Nullable err))completionBlock;

#pragma mark - Metadata

- (void) allMetadata:(nullable void (^)(NSDictionary * _Nullable allMetadata, AOError * _Nullable err))completionBlock;
- (void) allMetadataForGID:(nullable NSString *)gid onComplete:(nullable void (^)(NSDictionary * _Nullable allMetadata, AOError * _Nullable err))completionBlock;

- (void) metadataForKey:(nonnull NSString *)key onComplete:(nullable void (^)(id _Nullable metadata, AOError * _Nullable error))completionBlock;
- (void) metadataForKey:(nonnull NSString *)key gid:(nullable NSString *)gid onComplete:(nullable void (^)(id _Nullable metadata, AOError * _Nullable error))completionBlock;
- (void) metadataForKeys:(nonnull NSArray<NSString *>*)keys gid:(nullable NSString *)gid onComplete:(nullable void (^)(id _Nullable metadata, AOError * _Nullable error))completionBlock;

#pragma mark - Profile Information

- (void) profileInfo:(nullable void (^)(NSDictionary* _Nullable profileInfo, AOError* _Nullable err))completionBlock;
- (void) profileInfoForGID:(nullable NSString*)gid onComplete:(nullable void (^)(NSDictionary* _Nullable profileInfo, AOError* _Nullable err))completionBlock;

#pragma mark - Assets

- (void) allAssets:(nullable void (^)(NSDictionary * _Nullable assetsMetadata, AOError * _Nullable err))completionBlock;
- (void) assetForKey:(nonnull NSString *)key onComplete:(nullable void (^)(NSData * _Nullable asset, AOError * _Nullable err))completionBlock;

#pragma mark - Content Entry Information (CMS)

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

#pragma mark - Logging (Analytics)

- (void) applicationStart;
- (void) applicationStartSuccess:(nullable AOSuccessBlock)completionBlock onFailure:(nullable AOErrorBlock)failureBlock;

- (void) applicationStop;
- (void) applicationStop:(BOOL)clearCache;

#pragma mark - Logging (Remote)

- (void) logWithLevel:(AOServiceLogLevel)logLevel code:(NSUInteger)code message:(NSString *_Nullable)message dimensions:(NSDictionary * _Nullable)dimensions;

#pragma mark - User Data

- (void) allDataForUser:(nonnull NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void (^)(NSDictionary * _Nullable userData, AOError * _Nullable err))completionBlock;
- (void) storeData:(nonnull NSDictionary *)data forUser:(nonnull NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void(^)(AOError * _Nullable err))completionBlock;
- (void) dataForUser:(nonnull NSString *)userId key:(nonnull NSString *)key scope:(AOUserDataScope)scope onComplete:(nullable void(^)(NSString * _Nullable value, AOError * _Nullable err))completionBlock;
- (void) storeValue:(nonnull NSString *)value key:(nonnull NSString *)key forUser:(nonnull NSString *)userId scope:(AOUserDataScope)scope onComplete:(nullable void(^)(AOError * _Nullable err))completionBlock;

#pragma mark - Locale

-(void) localesOnComplete:(nullable void (^)(NSArray *_Nullable locales, AOError *_Nullable err))completionBlock;

- (void) clearSession:(BOOL) clearCache;
- (void) sendAuthenticatedGETRequest:(nonnull NSString *)requestSuffix
                         queryParams:(NSDictionary* _Nullable)params
                          allowCache:(BOOL)allowCache
                           onSuccess:(AOSuccessBlock _Nullable)successBlock
                        failureBlock:(AOErrorBlock _Nullable)failureBlock;

- (void) sendAuthenticatedPOSTRequest:(nonnull NSString *)requestSuffix
                               params:(id _Nullable)params
                                 body:(NSData *_Nullable)payload
                            onSuccess:(AOSuccessBlock _Nullable)completionBlock
                            onFailure:(AOErrorBlock _Nullable)failureBlock;

#pragma mark - Cache

- (void) addDictionary:(NSDictionary *_Nonnull) dictionary toOfflineAccedoOneConfigWithKey:(NSString *_Nonnull) key;
- (NSDictionary *_Nullable) dictionaryFromOfflineAccedoOneProfileWithKey:(NSString *_Nonnull) key;
- (NSDictionary *_Nullable) dictionaryFromOfflineAccedoOneConfigWithKey:(NSString *_Nonnull) key;
- (NSString *_Nullable) ifModifiedSinceDateForCachedObject:(NSString *_Nonnull)cacheKey cache:(id  <AOCacheHandler> _Nonnull) cache;
- (void) setHeaderValue:(nonnull NSString *) value headerField:(nonnull NSString *) headerField;

@property (nonatomic, assign) AccedoOneServiceAvailability serviceAvailability;
@property (nonatomic, strong, readonly) NSString * _Nonnull accedoOneURL;
@property (assign, readonly) NSTimeInterval requestTimeout;
@end



