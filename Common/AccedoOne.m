//
//  AccedoOne.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AccedoOne.h"

#import "AccedoOneDetect.h"
#import "AccedoOneControl.h"
#import "AccedoOnePublish.h"
#import "AccedoOneDetect.h"
#import "AccedoOneUserData.h"
#import "AOCacheOverPINCache.h"
#import "AOFileUtils.h"
#import "AOCacheHelper.h"
#import "AOCache.h"
#import "AOCacheOverNSCache.h"
#import "AORequestMetadata.h"

NSString *const AOApplicationStateActive      = @"Active";
NSString *const AOApplicationStateMaintenance = @"maintenance";

//service parameters...
static int const kRequestTimeout             = 15;     //seconds
static int const kMetadataCacheTimeout       = 3600;   //seconds (1 day)

//AccedoOne API path constants...
static NSString *const kPathSession          = @"session";

//cached configuration...
static NSString *const kLocalConfigFileName  = @"cachedConfiguration.plist";
static NSString *const kLocalConfigFolder    = @"cachedConfiguration";

static NSString *const kLocalProfileFileName  = @"cachedProfile.plist";
static NSString *const kLocalProfileFolder    = @"cachedProfile";

static NSString *const kCacheControllHeader  = @"If-Modified-Since";


@interface AccedoOne()

@property (nonatomic, strong, readwrite) NSString *accedoOneURL;
@property (assign, readwrite) NSTimeInterval requestTimeout;
@property (nonatomic, strong) AOJSONService *jsonService;

@property (nonatomic, strong) id<AOTimeBasedCacheHandler> objectCache; //used to cache response (parsed) objects

@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *sessionKey;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSDate *sessionExpiration;

@property (nonatomic, strong) NSOperationQueue *sessionFetchWaitQueue;

@property (nonatomic, strong) NSMutableDictionary *localConfig;
@property (nonatomic, strong) NSMutableDictionary* localProfile;

@property (nonatomic, strong) AccedoOneInsight   * insight;
@property (nonatomic, strong) AccedoOneDetect    * detect;
@property (nonatomic, strong) AccedoOneControl   * control;
@property (nonatomic, strong) AccedoOnePublish   * publish;
@property (nonatomic, strong) AccedoOneUserData  * userdata;

@property (nonatomic, strong) NSNumber * assetCacheExpirationInterval;
@end


@implementation AccedoOne

#pragma mark - Initialization

- (instancetype) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid {
    return [self initWithURL:url appKey:appKey userID:uuid requestTimeout:kRequestTimeout];
}

- (instancetype) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid requestTimeout:(NSTimeInterval)requestTimeout {
    return [self initWithURL:url appKey:appKey userID:uuid requestTimeout:requestTimeout assetExpirationCacheTimeout:Nil];
}

- (instancetype _Nonnull ) initWithURL:(nonnull NSString *)url appKey:(nonnull NSString *)appKey userID:(nonnull NSString *)uuid requestTimeout:(NSTimeInterval)requestTimeout assetExpirationCacheTimeout: (NSNumber *) assetExpirationCacheTimeout {
    if(self = [super init]) {
        NSParameterAssert(uuid   != nil);
        NSParameterAssert(url    != nil);
        NSParameterAssert(appKey != nil);

        self.detect.logLevel = AOServiceLogLevelNotInitialized;
        self.accedoOneURL    = url;
        self.requestTimeout  = requestTimeout;
        self.appKey          = appKey;
        self.uuid            = uuid;

        self.objectCache     = [AOCache cacheProvider:[AOCacheOverPINCache class] persistenceKey:@"ObjectCache" defaultExpiration:kMetadataCacheTimeout];
        self.jsonService     = [[AOJSONService alloc] initWithURL:self.accedoOneURL requestTimeout:requestTimeout cacheHandler:self.objectCache];

        self.assetCacheExpirationInterval = assetExpirationCacheTimeout;
        [self initializeServiceEnvironment];
    }
    return self;
}


- (void) initializeServiceEnvironment {
    //disable cache on the service (as caching is handled by the the AccedoOneService!)
    [self.jsonService setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    self.sessionKey            = nil;
    self.sessionExpiration     = nil;
    self.sessionFetchWaitQueue = [[NSOperationQueue alloc] init];
    self.sessionFetchWaitQueue.name = @"tv.accedo.one.sessionFetchWaitQueue";
    self.sessionFetchWaitQueue.maxConcurrentOperationCount = 1;
}

#pragma mark - Getters

-(AccedoOneInsight *) insight {
    if (!_insight) {
        _insight = [[AccedoOneInsight alloc] initWithService:self];
    }
    return _insight;
}

-(AccedoOneDetect *) detect {
    if (!_detect) {
        _detect = [[AccedoOneDetect alloc] initWithService:self];
    }
    return _detect;
}

-(AccedoOneControl *) control {
    if (!_control) {
        _control = [[AccedoOneControl alloc] initWithService:self assetCacheExpirationInterval: self.assetCacheExpirationInterval];
    }
    return _control;
}

-(AccedoOnePublish *) publish {
    if (!_publish) {
        _publish = [[AccedoOnePublish alloc] initWithService:self];
    }
    return _publish;
}

-(AccedoOneUserData *) userdata {
    if (!_userdata) {
        _userdata = [[AccedoOneUserData alloc] initWithService:self];
    }
    return _userdata;
}

#pragma mark - AccedoOneControlProtocol

/**
 *  Check application availability
 *
 *  @param completionBlock A block executed on successful completion, passing it the status and message as a NSString
 */
- (void) applicationStatus:(void (^)(NSString *status, NSString *message, AOError *err))completionBlock {
    [self.control applicationStatus:completionBlock];
}

/**
 *  Fetch all avaiable metadata values
 *
 *  @param completionBlock block to be executed on completion, passing a dictionary as a parameter, or error if failure occured
 */
- (void) allMetadata:(void (^)(NSDictionary *allMetadata, AOError *err))completionBlock {
    [self.control allMetadata:completionBlock];
}

- (void) allMetadataForGID:(NSString *)gid onComplete:(nullable void (^)(NSDictionary *allMetadata, AOError *err))completionBlock {
    [self.control allMetadataForGID:gid onComplete:completionBlock];
}

/**
 *  Fetch metadata for provided key.
 *  @note cache / offline mode not available!
 *
 *  @param key metadata key to be fetched.
 *  @param completionBlock block to be executed on completion, passing a dictionary as a parameter, or error if failure occured
 */
- (void) metadataForKey:(NSString *)key onComplete:(void (^)(id metadata, AOError * error))completionBlock {
    [self.control metadataForKey:key onComplete:completionBlock];
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
    [self.control metadataForKey:key gid:gid onComplete:completionBlock];
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
    [self.control metadataForKeys:keys gid:gid onComplete:completionBlock];
}

/**
 *  Fetch profile information
 *
 *  @param completionBlock block to be executed on completion, passing a dictionary as a parameter, or error if failure occured
 */
- (void) profileInfo:(nullable void (^)(NSDictionary* profileInfo, AOError* err))completionBlock {
    [self.control profileInfo:completionBlock];
}

- (void) profileInfoForGID:(nullable NSString*)gid onComplete:(nullable void (^)(NSDictionary* profileInfo, AOError* err))completionBlock {
    [self.control profileInfoForGID:gid onComplete:completionBlock];
}

/**
 *  Get all asset IDs
 *
 *  @param completionBlock block to be executed on success, passing a dictionary containing all assets as a parameter
 */
- (void) allAssets:(void (^)(NSDictionary *assetsMetadata, AOError *err))completionBlock {
    [self.control allAssets:completionBlock];
}

/**
 *  Download an asset with a given key.
 *
 *  @param key the resource key
 *  @param completionBlock block to be executed on response, passing the resource as NSData
 */
- (void) assetForKey:(NSString *)key onComplete:(void (^)(NSData *asset, AOError *err))completionBlock {
    [self.control assetForKey:key onComplete:completionBlock];
}

#pragma mark - AccedoOnePublishProtocol (CMS)

- (void) entryForId:(NSString*)entryId onComplete:(void (^)(NSDictionary *entry, AOError *err))completionBlock {
    [self.publish entryForId:entryId onComplete:completionBlock];
}

- (void) entryForId:(NSString*)entryId optionalParams:(AOCMSOptionalParams *)params onComplete:(void (^)(NSDictionary *entry, AOError *err))completionBlock {
    [self.publish entryForId:entryId optionalParams:params onComplete:completionBlock];
}

- (void) entriesForIds:(NSArray*)contentIds onComplete:(void (^)(NSArray *entries, AOError *err))completionBlock {
    [self.publish entriesForIds:contentIds onComplete:completionBlock];
}

- (void) entriesForIds:(NSArray*)contentIds optionalParams:(AOCMSOptionalParams *)params onComplete:(void(^)(NSArray *entries, AOError *err))completionBlock {
    [self.publish entriesForIds:contentIds optionalParams:params onComplete:completionBlock];
}

- (void) entriesForAliases:(nonnull NSArray<__kindof NSString*>*)aliases onComplete:(nullable void (^)(NSArray *entries, AOError *err))completionBlock {
    [self.publish entriesForAliases:aliases onComplete:completionBlock];
}

- (void) entriesForAliases:(nonnull NSArray<__kindof NSString*>*)aliases optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(NSArray *entries, AOError *err))completionBlock {
    [self.publish entriesForAliases:aliases optionalParams:params onComplete:completionBlock];
}

- (void) entriesForTypeAlias:(nonnull NSString*)alias onComplete:(nullable void (^)(NSArray *entries, AOError *err))completionBlock {
    [self.publish entriesForTypeAlias:alias onComplete:completionBlock];
}

- (void) entriesForTypeAlias:(nonnull NSString*)alias optionalParams:(nullable AOCMSOptionalParams *)params onComplete:(nullable void(^)(NSArray *entries, AOError *err))completionBlock {
    [self.publish entriesForTypeAlias:alias optionalParams:params onComplete:completionBlock];
}

- (void) entriesForType:(NSString *)typeId onComplete:(void (^)(AOPageResult *result, AOError *err))completionBlock {
    [self.publish entriesForType:typeId onComplete:completionBlock];
}

- (void) entriesForType:(NSString *)typeId optionalParams:(AOCMSOptionalParams *)params onComplete:(void(^)(AOPageResult *result, AOError *err))completionBlock {
    [self.publish entriesForType:typeId optionalParams:params onComplete:completionBlock];
}

- (void) allEntries:(void (^)(AOPageResult *result, AOError *err))completionBlock {
    [self.publish allEntries:completionBlock];
}

- (void) allEntriesForParams:(AOCMSOptionalParams *)params onComplete:(void (^)(AOPageResult *result, AOError *err))completionBlock {
    [self.publish allEntriesForParams:params onComplete:completionBlock];
}

-(void) localesOnComplete:(nullable void (^)(NSArray *_Nullable locales, AOError *_Nullable err))completionBlock {
    [self.publish localesOnComplete:completionBlock];
}

#pragma mark - AccedoOneInsightProtocol (Analytics)

/**
 *  Log the application launch (simple)
 */
- (void) applicationStart {
    [self.insight applicationStart];
}

/**
 *  Log the application launch
 */
-(void) applicationStartSuccess:(AOSuccessBlock)completionBlock onFailure:(AOErrorBlock)failureBlock {
    [self.insight applicationStartSuccess:completionBlock onFailure:failureBlock];
}

/**
 *  Log the application termination
 */
-(void) applicationStop {
    [self.insight applicationStop];
}

/**
 *  Log the application termination and optionally clear cache.
 */
- (void) applicationStop:(BOOL)clearCache {
    [self.insight applicationStop: clearCache];
}

#pragma mark - AccedoOneDetectProtocol (Remote logging)

/**
 *  Remote logging for debug and support purposes. Remote logging will only be fired if the requested log level (logLevel)
 *  is higher or equal to the configured log level in AccedoOne.
 *
 *  @param logLevel   The log level sent by the caller
 *  @param code       The code to be sent to the remote log
 *  @param message    The message to be sent to the remote log
 *  @param dimensions Optional parameter, containing a map of dimensions (pair key/value)
 */
- (void) logWithLevel:(AOServiceLogLevel)logLevel code:(NSUInteger)code message:(NSString *)message dimensions:(NSDictionary * )dimensions {
    [self.detect logWithLevel:logLevel code:code message:message dimensions:dimensions];
}

#pragma mark - AccedoOneUserDataProtocol

- (void) allDataForUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(void (^)(NSDictionary *userData, AOError *err))completionBlock {
    [self.userdata allDataForUser:userId scope:scope onComplete:completionBlock];
}

- (void) storeData:(NSDictionary *)data forUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(void(^)(AOError *err))completionBlock {
    [self.userdata storeData:data forUser:userId scope:scope onComplete:completionBlock];
}

- (void) dataForUser:(NSString *)userId key:(NSString *)key scope:(AOUserDataScope)scope onComplete:(void(^)(NSString *value, AOError *err))completionBlock {
    [self.userdata dataForUser:userId key:key scope:scope onComplete:completionBlock];
}

- (void) storeValue:(NSString *)value key:(NSString *)key forUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(void(^)(AOError *err))completionBlock {
    [self.userdata storeValue:value key:key forUser:userId scope:scope onComplete:completionBlock];
}

#pragma mark - Helpers (network requests handling)

/**
 *  Add all network operations to a single task queue. The queue will be locked until the first operation, which will be the sessionkey request is completed. The lock is performed by pausing and resuming an operationqueue. All network operations will be added to that queue until there is a valid session key
 *
 *  @param operation    A block that does not accept parameters and does not return any value, containing the actual request
 *  @param failureBlock En error block
 */
- (void) enqueueOperation:(void (^)(void))operation onFailure:(AOErrorBlock)failureBlock {
    if ([self sessionIsValid]) {
        if (operation) {
            operation();
        }
        return;
    }

    BOOL sessionQueueIsPaused = self.sessionFetchWaitQueue.isSuspended;
    
    if (!sessionQueueIsPaused) {
        [self getSessionWithOperation:operation onFailure:failureBlock];
    } else {
        [self.sessionFetchWaitQueue addOperationWithBlock:operation];
    }
}

/**
 *  Initialize a session. On successful completion, executes a block
 *
 *  @param networkRequest block to be executed on successful completion, after the session has been parsed
 *  @param failureBlock   An error block
 */
- (void) getSessionWithOperation:(void (^)(void))networkRequest onFailure:(AOErrorBlock)failureBlock {
    [self.sessionFetchWaitQueue setSuspended:YES];
    
    AORequestMetadata * request = [AORequestMetadata requestMetadataWithPath:kPathSession queryParams:@{@"appKey": self.appKey, @"uuid":self.uuid}];
    
    [self.jsonService GET:request parser:nil success:^(id responseObject) {
        //A session key was created, update the availability status to online
        self.sessionKey = responseObject[@"sessionKey"];
        [self.jsonService setHeaderValue:self.sessionKey headerField:@"X-Session"];
        
        NSString *sessionExpiryString = [responseObject valueForKey:@"expiration"];
        
        static NSDateFormatter *dateFormatter = nil;
        static dispatch_once_t oncePredicate;
        
        dispatch_once(&oncePredicate, ^{
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd'T'HH:mm:ssZ"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        });
        
        @synchronized(dateFormatter) {
            self.sessionExpiration = [dateFormatter dateFromString:sessionExpiryString];
        }
        
        [self.sessionFetchWaitQueue setSuspended:NO];
        
        if (networkRequest) {
            networkRequest();
        }
    } failure:^(AOError *error) {
         //An attempt to create a session key failed, so the AccedoOneService enters offline mode
         if (failureBlock) {
             failureBlock(error);
         }
         
         [self.sessionFetchWaitQueue setSuspended:NO];
     }];
}

#pragma mark - AccedoOne

- (void) setHeaderValue:(nonnull NSString *) value headerField:(nonnull NSString *) headerField {
    [self.jsonService setHeaderValue:value headerField:headerField];
}

-(void) clearSession:(BOOL) clearCache {
    // clear session
    self.sessionKey = nil;
    self.sessionExpiration = nil;
    
    // clear cache
    if (clearCache) {
        [self.objectCache clearAllObjects];
        [self.control clearCache];
    }
}

/**
 *  Perform a get request that will return a response that can be dealt with as a NSDictionary, with default cache policy.
 *
 *  @param requestSuffix   the request endpoint suffix
 *  @param params          query parameters of the request
 *  @param allowCache      allow cliend-side caching.
 *  @param successBlock    the completion block, that will receive a dictionary as parameter
 *  @param failureBlock    the error handling block
 */
- (void) sendAuthenticatedGETRequest:(NSString *)requestSuffix
                         queryParams:(NSDictionary*)params
                          allowCache:(BOOL)allowCache
                           onSuccess:(AOSuccessBlock)successBlock
                        failureBlock:(AOErrorBlock)failureBlock {

    [self enqueueOperation:^{

        NSString *cacheKey = [AOCacheHelper cacheKeyForMethod:requestSuffix parameters:params];
        AORequestMetadata * request = [AORequestMetadata requestMetadataWithPath:requestSuffix queryParams:params headerParams:nil cacheKey:cacheKey];
        request.cacheExpiration = allowCache ? @(kMetadataCacheTimeout) : nil;
        request.forceSendRequest = YES;
        NSTimeInterval cacheTimeStamp = [self.objectCache creationDateForKey:cacheKey];
        
        //check cache, and add cache-controll header if necessary...
        if (cacheTimeStamp > 0 && allowCache) {
            NSString *ifModifiedSinceDate = [self ifModifiedSinceDateForCachedObject:cacheKey cache:self.objectCache];
            request.headerParameters = @{kCacheControllHeader : ifModifiedSinceDate};
        }

        [self.jsonService GET:request parser:nil success:^(id responseObject) {
            if (successBlock) {
                successBlock(responseObject);
            }
        } failure:^(AOError *error) {
            id cachedObject = [self.objectCache objectForKey:request.cacheKey];
            
            if (error.code == 304 && cachedObject) { //Resource not modified(!): return it from cache!
                if (successBlock) {
                    successBlock(cachedObject);
                }
            } else if (failureBlock) {
                failureBlock(error);
            }
        }];
    } onFailure:^(AOError *error) {
         if (failureBlock) {
             failureBlock(error);
         }
     }];
}

/**
 *  Sends the request to the network operation queue. There, the request will be on hold until we have a valid session handler
 *
 *  @param requestSuffix   NSString with the request suffix
 *  @param completionBlock block to be executed when the request is completed
 *  @param failureBlock block to be executed on error
 */
- (void) sendAuthenticatedPOSTRequest:(NSString *)requestSuffix
                               params:(id)params
                                 body:(NSData *)payload
                            onSuccess:(AOSuccessBlock)completionBlock
                            onFailure:(AOErrorBlock)failureBlock {

    [self enqueueOperation:^{
        AORequestMetadata * request = [AORequestMetadata requestMetadataWithPath:requestSuffix queryParams:params];
        request.body = payload;

        [self.jsonService POST:request parser:nil success:^(id responseObject) {
            if (completionBlock) {
                completionBlock(responseObject);
            }
        } failure:^(AOError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
         }];
    } onFailure:^(AOError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

#pragma mark - Helpers (Offline usage)

- (void) readOfflineAccedoOneConfig {
    NSString *plistPath = [AOFileUtils pathToFileInDocumentsDirectoryWithName:kLocalConfigFileName inFolder:kLocalConfigFolder];
    self.localConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

- (NSDictionary *) dictionaryFromOfflineAccedoOneConfig {
    [self readOfflineAccedoOneConfig];
    return self.localConfig;
}

- (NSDictionary *) dictionaryFromOfflineAccedoOneConfigWithKey:(NSString *) key {
    return [self dictionaryFromOfflineAccedoOneConfig][key];
}

- (void) addDictionary:(NSDictionary *) dictionary toOfflineAccedoOneConfigWithKey:(NSString *) key {

    @synchronized(self.localConfig){
        self.localConfig[key] = dictionary;
    }
    [self flushOfflineAccedoOneConfig];
}

- (void) flushOfflineAccedoOneConfig {
    NSString *folderPath = [AOFileUtils pathToFolderInDocumentsDirectoryWithName:kLocalConfigFolder];
    NSString *filePath = [folderPath stringByAppendingPathComponent:kLocalConfigFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    [self.localConfig writeToFile:filePath atomically:YES];
}

#pragma mark - Helpers (Offline profile information)

- (void) readOfflineAccedoOneProfile {
    NSString *plistPath = [AOFileUtils pathToFileInDocumentsDirectoryWithName:kLocalProfileFileName inFolder:kLocalProfileFolder];
    self.localProfile = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

- (NSDictionary *) dictionaryFromOfflineAccedoOneProfile {
    [self readOfflineAccedoOneProfile];
    return self.localProfile;
}

- (NSDictionary *) dictionaryFromOfflineAccedoOneProfileWithKey:(NSString *) key {
    return [self dictionaryFromOfflineAccedoOneProfile][key];
}

- (void) addDictionary:(NSDictionary *) dictionary toOfflineAccedoOneProfileWithKey:(NSString *) key {
    self.localProfile[key] = dictionary;
    [self flushOfflineAccedoOneProfile];
}

- (void) flushOfflineAccedoOneProfile {
    NSString *folderPath = [AOFileUtils pathToFolderInDocumentsDirectoryWithName:kLocalProfileFolder];
    NSString *filePath = [folderPath stringByAppendingPathComponent:kLocalProfileFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    [self.localProfile writeToFile:filePath atomically:YES];
}

#pragma mark - Helpers (last modified since date)

/**
 *  Private helper to generate the "If-Modified-Since" date string for a particular cached object.
 *
 *  @param cacheKey key for the concerned cached object
 *
 *  @return the formatted "If-Modified-Since" date string
 */
- (NSString *) ifModifiedSinceDateForCachedObject:(NSString *)cacheKey cache:(id <AOCacheHandler>)cache {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
        //[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"US"]];
    });
    
    NSTimeInterval cachedObjectTimeStamp = [cache creationDateForKey:cacheKey];
    NSDate *lastModified = [NSDate dateWithTimeIntervalSince1970:cachedObjectTimeStamp];
    
    return [dateFormatter stringFromDate:lastModified];
}

#pragma mark - Helpers (private helpers)

/**
 *  Check if there is a session key, not expired.
 *
 *  @return BOOL indicating if we need to initialize a session key
 */
- (BOOL) sessionIsValid {
    NSDate *present = [NSDate date];
    return ((self.sessionKey) && (self.sessionExpiration) && ([self.sessionExpiration compare: present] == NSOrderedDescending));
}

- (NSMutableDictionary*) localConfig {
    if (!_localConfig) {
        _localConfig = [[NSMutableDictionary alloc] init];
    }
    return _localConfig;
}

@end
