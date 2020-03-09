//
//  AccedoOneControl.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AccedoOneControl.h"
#import "AccedoOne.h"
#import "AOCacheHelper.h"
#import "AOCache.h"
#import "AOCacheOverPINCache.h"

static NSString *const kPathStatus          = @"status";
static NSString *const kPathGetProfileInfo  = @"profile";
static NSString *const kPathGetMetadata     = @"metadata";
static NSString *const kPathAsset           = @"asset";
static NSString *const kCacheControllHeader = @"If-Modified-Since";

static int const kAssetCacheTimeout         = 604800; //seconds (1 week)

@interface AccedoOneControl ()
@property (nonatomic, strong) AccedoOne * service;
@property (nonatomic, strong) AOService *httpService;
@property (strong) NSNumber * assetCacheExpirationInterval;
@property (nonatomic, strong) id<AOTimeBasedCacheHandler> assetCache; //used to cache assets (images, resource files, etc..)
@end


@implementation AccedoOneControl

-(instancetype) initWithService:(AccedoOne *) service assetCacheExpirationInterval: (NSNumber *) assetCacheExpirationInterval{
    if (self = [super init]) {
        _service = service;

        self.assetCacheExpirationInterval = assetCacheExpirationInterval;
        self.assetCache = [AOCache cacheProvider:[AOCacheOverPINCache class] persistenceKey:@"AssetCache" defaultExpiration:self.assetCacheExpirationInterval ? [self.assetCacheExpirationInterval doubleValue] : kAssetCacheTimeout];
        self.httpService = [[AOService alloc] initWithURL:service.accedoOneURL requestTimeout:service.requestTimeout cacheHandler:self.assetCache];
        [self.httpService setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    }
    return self;
}

#pragma mark - AccedoOneControlProtocol

/**
 *  Check application availability
 *
 *  @param completionBlock A block executed on successful completion, passing it the status and message as a NSString
 */
- (void) applicationStatus:(void (^)(NSString *status, NSString *message, AOError *err))completionBlock {

    [self.service sendAuthenticatedGETRequest:kPathStatus queryParams:nil allowCache:NO onSuccess:^(NSDictionary *response) {
         if (completionBlock) {
             NSString *status  = response[@"status"];
             NSString *message = response[@"message"];
             
             completionBlock(status, message, nil);
         }
     } failureBlock:^(AOError *error) {
         if (completionBlock) {
             completionBlock(nil, nil, error);
         }
     }];
}

/**
 *  Fetch profile information
 *
 *  @param completionBlock block to be executed on completion, passing a dictionary as a parameter, or error if failure occured
 */
- (void) profileInfo:(nullable void (^)(NSDictionary* profileInfo, AOError* err))completionBlock; {
    [self profileInfoForGID:nil onComplete:completionBlock];
}

- (void) profileInfoForGID:(nullable NSString*)gid onComplete:(nullable void (^)(NSDictionary* profileInfo, AOError* err))completionBlock {

    NSDictionary* params = gid ? @{@"gid" : gid} : nil;
    NSString* offlineKey = gid ? [NSString stringWithFormat:@"%@?gid=%@", kPathGetProfileInfo, gid] : kPathGetProfileInfo;

    [self.service sendAuthenticatedGETRequest:kPathGetProfileInfo queryParams:params allowCache:YES onSuccess:^(NSDictionary *response) {
        [self.service addDictionary:response toOfflineAccedoOneConfigWithKey:offlineKey];

        if (completionBlock) {
            completionBlock(response, nil);
        }
    } failureBlock:^(AOError *error) {
        if (completionBlock) {
            NSDictionary* cached = [self.service dictionaryFromOfflineAccedoOneProfileWithKey:offlineKey];
            completionBlock(cached, cached ? nil : error);
        }
    }];

}

/**
 *  Fetch all avaiable metadata values
 *
 *  @param completionBlock block to be executed on completion, passing a dictionary as a parameter, or error if failure occured
 */
- (void) allMetadata:(void (^)(NSDictionary *allMetadata, AOError *err))completionBlock {
    [self allMetadataForGID:nil onComplete:completionBlock];
}

- (void) allMetadataForGID:(NSString *)gid onComplete:(nullable void (^)(NSDictionary *allMetadata, AOError *err))completionBlock {
    
    NSDictionary * params = gid ? @{@"gid" : gid} : nil;
    NSString * offlineKey = gid ? [NSString stringWithFormat:@"%@?gid=%@", kPathGetMetadata, gid] : kPathGetMetadata;
    

    [self.service sendAuthenticatedGETRequest:kPathGetMetadata queryParams:params allowCache:YES onSuccess:^(NSDictionary *response) {
        [self.service addDictionary:response toOfflineAccedoOneConfigWithKey:offlineKey];

        if (completionBlock) {
            completionBlock(response, nil);
        }
    } failureBlock:^(AOError *error) {
        NSDictionary * cachedMetadata = [self.service dictionaryFromOfflineAccedoOneConfigWithKey:offlineKey];
        if (completionBlock) {
            completionBlock(cachedMetadata , cachedMetadata ? nil : error);
        }
    }];

}

/**
 *  Fetch metadata for provided key.
 *  @note cache / offline mode not available!
 *
 *  @param key metadata key to be fetched.
 *  @param completionBlock block to be executed on completion, passing a dictionary as a parameter, or error if failure occured
 */
- (void) metadataForKey:(NSString *)key onComplete:(void (^)(id metadata, AOError * error))completionBlock {
    [self metadataForKeys:@[key] gid:nil onComplete:completionBlock];
}

/**
 *  Fetch metadata for provided key.
 *  @note cache / offline mode not available!
 *
 *  @param key metadata key to be fetched.
 *  @param gid GID for possible whitelist matching (optional).
 *  @param completionBlock block to be executed on completion, passing a dictionary as a parameter, or error if failure occured
 */
- (void) metadataForKey:(NSString *)key gid:(NSString *)gid onComplete:(nullable void (^)(id metadata, AOError * error))completionBlock {
    [self metadataForKeys:@[key] gid:gid onComplete:completionBlock];
}

/**
 *  Fetch metadatas for provided keys.
 *  @note cache / offline mode not available!
 *
 *  @param keys array of metadata keys to be fetched.
 *  @param gid GID for possible whitelist matching (optional).
 *  @param completionBlock block to be executed on completion, passing a dictionary as a parameter, or error if failure occured
 */
- (void) metadataForKeys:(NSArray<NSString *>*)keys gid:(NSString *)gid onComplete:(nullable void (^)(id metadata, AOError * error))completionBlock {
    
    NSDictionary * params = gid ? @{@"gid" : gid} : nil;
    NSString * path = [NSString stringWithFormat:@"%@/%@", kPathGetMetadata, [keys componentsJoinedByString:@","]];
    
    [self.service sendAuthenticatedGETRequest:path queryParams:params allowCache:YES onSuccess:^(NSDictionary *response) {
        [self.service addDictionary:response toOfflineAccedoOneConfigWithKey:path];
        
        if (completionBlock) {
            completionBlock(response, nil);
        }
    } failureBlock:^(AOError *error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
}

/**
 *  Get all asset IDs
 *
 *  @param completionBlock block to be executed on success, passing a dictionary containing all assets as a parameter
 */
- (void) allAssets:(void (^)(NSDictionary *assetsMetadata, AOError *err))completionBlock {
    [self.service sendAuthenticatedGETRequest:kPathAsset queryParams:nil allowCache:YES onSuccess:^(NSDictionary *response) {
        [self.service addDictionary:response toOfflineAccedoOneConfigWithKey:kPathAsset];

        if (completionBlock) {
            completionBlock(response, nil);
        }
    } failureBlock:^(AOError *error) {
        if (completionBlock) {
            NSDictionary * cachedResource = [self.service dictionaryFromOfflineAccedoOneConfigWithKey:kPathAsset];
            completionBlock(cachedResource,cachedResource ? nil :  error);
        }
    }];
}

- (void) allAssetsForGID:(nullable NSString *)gid onComplete:(nullable void (^)(NSDictionary * _Nullable assetsMetadata, AOError *_Nullable err))completionBlock {
    NSDictionary * params = gid ? @{@"gid" : gid} : nil;
    [self.service sendAuthenticatedGETRequest:kPathAsset queryParams:params allowCache:YES onSuccess:^(NSDictionary *response) {
        [self.service addDictionary:response toOfflineAccedoOneConfigWithKey:kPathAsset];

        if (completionBlock) {
            completionBlock(response, nil);
        }
    } failureBlock:^(AOError *error) {
        if (completionBlock) {
            NSDictionary * cachedResource = [self.service dictionaryFromOfflineAccedoOneConfigWithKey:kPathAsset];
            completionBlock(cachedResource,cachedResource ? nil :  error);
        }
    }];
}


/**
 *  Download an asset with a given key.
 *
 *  @param key the resource key
 *  @param completionBlock block to be executed on response, passing the resource as NSData
 */
- (void) assetForKey:(NSString *)key onComplete:(void (^)(NSData *asset, AOError *err))completionBlock {

    if (!key) {
        if (completionBlock) completionBlock(nil, [AOError errorWithMessage:@"AccedoOneService: key cannot be null!"]);
        return;
    }
    
    [self allAssets:^(NSDictionary *allAssets, AOError *err) {

        if (allAssets) {

            NSString *assetPath = allAssets[key];
             
             if (!assetPath) {
                 if (completionBlock) completionBlock(nil, [AOError errorWithMessage:@"AccedoOneService: no asset (url) for provided key!"]);
                 return;
             }


             AORequestMetadata * request = [AORequestMetadata requestMetadataWithPath:assetPath queryParams:nil headerParams:nil cacheKey:key];
             request.cacheExpiration = self.assetCacheExpirationInterval ? self.assetCacheExpirationInterval : @(kAssetCacheTimeout);
             request.forceSendRequest = YES;
             
             NSTimeInterval cacheTimeStamp = [self.assetCache creationDateForKey:key];
             
             //check cache, and add cache-controll header if necessary...
             if (cacheTimeStamp > 0) { //do not add "If-Modified-Since" if object not in cache (to avoid getting HTTP 304)
                 NSString *ifModifiedSinceDate = [self.service ifModifiedSinceDateForCachedObject:key cache:self.assetCache];
                 request.headerParameters = @{kCacheControllHeader : ifModifiedSinceDate};
             }
             
             [self.httpService GET:request parser:nil success:^(id responseObject) {
                 if (completionBlock) {
                     completionBlock(responseObject, nil);
                 }
             } failure:^(AOError *error) {
                 id cachedObject = [self.assetCache objectForKey:key];
                 
                 if (error.code == 304 && cachedObject) { //Resource not modified(!): return it from cache!
                     if (completionBlock) {
                         completionBlock(cachedObject, nil);
                     }
                 } else {
                     if (completionBlock) {
                         completionBlock(nil, error);
                     }
                 }
             }];
         } else {
             NSData * cachedResource = (NSData *)[self.assetCache objectForKey:key];
             
             if (completionBlock) {
                 completionBlock(cachedResource, cachedResource ? nil : [AOError errorWithMessage:@"Resource not in cache!"]);
             }
         }
     }];
}

#pragma mark - Cache Util

- (void) clearCache {
    [self.assetCache clearAllObjects];
}

@end
