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

#import "AccedoOneControl.h"
#import "AccedoOneDetect.h"
#import "AccedoOneInsight.h"
#import "AccedoOnePublish.h"
#import "AccedoOneUserData.h"

#import "AccedoOneCacheProtocol.h"
#import "AOCMSOptionalParams.h"


/**
 * Application Status constants
 */
extern NSString * _Nonnull const AOApplicationStateActive;
extern NSString * _Nonnull const AOApplicationStateMaintenance;

/**
 * AccedoOne is the implementation of Accedo's AccedoOne REST API
 */
@interface AccedoOne : NSObject <AccedoOneControlProtocol, AccedoOneDetectProtocol, AccedoOneInsightProtocol, AccedoOnePublishProtocol, AccedoOneUserDataProtocol, AccedoOneCacheProtocol>

#pragma mark - Lifecycle

/**
 * Property injection for AccedoOne.
 * Must be called in order to use the AccedoOne.
 */
- (instancetype _Nonnull ) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid;
- (instancetype _Nonnull ) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid requestTimeout:(NSTimeInterval)requestTimeout;
- (instancetype _Nonnull ) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid requestTimeout:(NSTimeInterval)requestTimeout assetExpirationCacheTimeout: (nullable NSNumber *) assetExpirationCacheTimeout;

#pragma mark - AccedoOne

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

- (void) setHeaderValue:(nonnull NSString *)value headerField:(nonnull NSString *)headerField;

- (void) clearSession:(BOOL)clearCache;

#pragma mark - Properties

@property (nonatomic, strong, readonly) NSString * _Nonnull accedoOneURL;
@property (nonatomic, assign, readonly) NSTimeInterval requestTimeout;
@property (nonatomic, assign, readonly) NSString * _Nullable sessionKey;


@end



