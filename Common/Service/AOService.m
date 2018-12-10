//
//  AOService.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//
#import "AOService.h"
//#import "AFNetworkingDependencies.h"
#import "AFNetworking.h"

#import "NSArray+AO.h"



#import "AOPagingMetadata.h"


#import "AOService+CacheController.h"

#import "AOAsynchBlockOperation.h"

static const BOOL       kLogShouldTruncate    = YES;
static const NSUInteger kLogMaxResponseLength = 120;
static const NSUInteger kLogMaxErrorLength    = 112;

#pragma mark - AORequestHandler

@interface AORequestHandler()

@property (nonatomic, weak, readwrite) NSURLSessionDataTask *task;
@property (nonatomic, weak) id owner;

@end


@implementation AORequestHandler

- (instancetype) initWithTask:(NSURLSessionDataTask *)task metadata:(AORequestMetadata *)metadata
{
    self = [super init];
    
    if (self)
    {
        _task            = task;
        _requestMetadata = metadata;
    }

    return self;
}

- (void) cancelRequest
{
    if (self.requestMetadata.cacheKey)
    {
        [self.service notifyCallersForKey:self.requestMetadata.cacheKey result:nil error:[AOError errorWithDomain:@"AOService" code:NSURLErrorCancelled userInfo:nil]];
    }

    [self.task cancel];
}

//#pragma mark - Handle component
//
//+ (id<NSCopying>)groupKeyForOwner:(id)owner
//{
//    return [owner description];
//}
//
//- (void)own:(id)newOwner
//{
//    if (self.owner)
//    {
//        [[AORequestManager sharedInstance] removeRequest:self fromGroup:[AORequestHandler groupKeyForOwner:self.owner]];
//    }
//
//    self.owner = newOwner;
//
//    [[AORequestManager sharedInstance] addRequest:self toGroup:[AORequestHandler groupKeyForOwner:self.owner]];
//}

@end


#pragma mark - AOService

@interface AOService()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, assign) NSTimeInterval requestTimeout;

@property (nonatomic, strong, readwrite) NSMutableDictionary *fetchQueues;

- (void) initializeSerializers;

@end


@implementation AOService

#pragma mark - Initialization

- (instancetype) initWithURL:(NSString *)baseURL
{
    NSParameterAssert(baseURL != nil);

    return [self initWithURL:baseURL requestTimeout:kAODefaultRequestTimeout];
}

- (instancetype) initWithURL:(NSString *)baseURL requestTimeout:(NSTimeInterval)timeoutInterval
{
    NSParameterAssert(baseURL != nil);

    return [self initWithURL:baseURL requestTimeout:timeoutInterval cacheHandler:nil];
}

- (instancetype) initWithURL:(NSString *) baseURL requestTimeout:(NSTimeInterval) timeoutInterval cacheHandler:(id<AOCacheHandler>) cacheHandler
{
    NSParameterAssert(baseURL != nil);

    self = [super init];

    if (self)
    {
        NSURL *URL      = baseURL ? [NSURL URLWithString:baseURL] : nil;

        _manager        = [[AFHTTPSessionManager alloc] initWithBaseURL:URL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

        _requestTimeout = timeoutInterval;
        _cacheHandler   = cacheHandler;
        _fetchQueues    = [NSMutableDictionary dictionary];

        [self initializeSerializers];
    }

    return self;
}

- (void)setCacheHandler:(id<AOCacheHandler>)cacheHandler
{
    _cacheHandler = cacheHandler;
}

- (void) initializeSerializers
{
    //TODO: request serializer
    
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.cachePolicy               = NSURLRequestReloadIgnoringLocalCacheData; //NSURLRequestUseProtocolCachePolicy
    requestSerializer.timeoutInterval           = _requestTimeout;
    requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"POST", @"PUT", @"DELETE", nil];
    
     
    [self setHeaderValue:@"*/*" headerField:@"Accept"];
    
    [self.manager setRequestSerializer:requestSerializer];
    [self.manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
}

- (void)setMaxConcurrent:(NSInteger)maxConcurrent
{
    [[self.manager operationQueue] setMaxConcurrentOperationCount:maxConcurrent];
}

#pragma mark - Service parameter handling

- (NSURL *) baseURL
{
    return self.manager.baseURL;
}

- (void)updateBaseURL:(NSURL *)newBaseUrl
{
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:newBaseUrl];

    [self initializeSerializers];
}

- (void) setCachePolicy:(NSURLRequestCachePolicy)cachePolicy
{
    self.manager.requestSerializer.cachePolicy = cachePolicy;
}

- (void) setRequestTimeout:(NSTimeInterval)requestTimeout
{
    _requestTimeout = requestTimeout; //seconds!
}

- (void) setHeaderValue:(NSString *)value headerField:(NSString *)headerField
{
    [self.manager.requestSerializer setValue:value forHTTPHeaderField:headerField];
}

- (void) setContentType:(NSString *)contentType
{
    
    if (self.manager.responseSerializer.acceptableContentTypes)
    {
        self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:contentType];
    }
    else
    {
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:contentType, nil];
    }
    
}

- (void) setHTTPUsername:(NSString *)username andPassword:(NSString *)password
{
    [self.manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
}

-(void) addAcceptableContentType:(nonnull NSString *)contentType {
    self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:contentType];
}

- (AOService *) aoService
{
    return self;
}

-(void) cancelAllRequests
{
    [self.manager.operationQueue cancelAllOperations];
}

#pragma mark - asynchronous execution

- (AORequestHandler *) GET:(AORequestMetadata *) requestMetadata
                     parser:(id<AOObjectParserProtocol>) parser
                    success:(void (^)(id response)) success
                    failure:(void (^)(AOError *error)) failure
{
    BOOL shouldSendRequest = YES;

    CacheState cacheState  = CacheStateUnknown;
    id cachedObject        = nil;

    if (requestMetadata.cacheKey)
    {
        AOCacheDTO * cacheDTO = [AOCacheDTO new];
        cacheDTO.cacheKey      = requestMetadata.cacheKey;
        cacheDTO.success       = success;
        cacheDTO.failure       = failure;

        cachedObject           = [self.cacheHandler objectForKey:requestMetadata.cacheKey]; //retrieve cached response...

        cacheState             = [self registerCacheQuery:cacheDTO cachedObject:cachedObject];
        shouldSendRequest      = [self shouldSendRequest:requestMetadata forCacheState:cacheState]; //check cached response state...
    }

    if (shouldSendRequest)
    {
        if (requestMetadata.cacheKey && !requestMetadata.forceSendRequest) //prevent forced-and-subsequent requests being queued...
        {
            //create a queue for received cacheKey...
            [self enqueueCallerForKey:requestMetadata.cacheKey];
        }

        return [self asynchronouslyPerformMethod:@"GET" requestMetadata:requestMetadata parser:parser success:success failure:failure];
    }
    else if (!(cacheState & CacheStateLoading))
    {
        if (success) {
            // keep the flow consistent with "shouldSendRequest == YES" branch - e.g. go background -> callback on on main
            // it is important to give time to the scheduler, to execute additional operations queued up on main.
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(cachedObject);
                });
            });
        }
    }

    return nil;
}

- (AORequestHandler *) POST:(AORequestMetadata *) requestMetadata
                      parser:(id<AOObjectParserProtocol>) parser
                     success:(void (^)(id responseObject)) success
                     failure:(void (^)(AOError *error)) failure
{
    return [self asynchronouslyPerformMethod:@"POST" requestMetadata:requestMetadata parser:parser success:success failure:failure];
}

- (AORequestHandler *) PUT:(AORequestMetadata *)requestMetadata
                     parser:(id<AOObjectParserProtocol>)parser
                    success:(void (^)(id response))success
                    failure:(void (^)(AOError *error))failure
{
    return [self asynchronouslyPerformMethod:@"PUT" requestMetadata:requestMetadata parser:parser success:success failure:failure];
}

- (AORequestHandler *) DELETE:(AORequestMetadata *)requestMetadata
                        parser:(id<AOObjectParserProtocol>)parser
                       success:(void (^)(id response))success
                       failure:(void (^)(AOError *error))failure
{
    return [self asynchronouslyPerformMethod:@"DELETE" requestMetadata:requestMetadata parser:parser success:success failure:failure];
}

- (AORequestHandler *) GETPAGE:(AOPagingMetadata *)pageMetadata
                         parser:(id<AOObjectParserProtocol>)parser
                        success:(void (^)(AOPageResult * pageResult))success
                        failure:(void (^)(AOError *error))failure
{
    return [self GET:pageMetadata parser:parser success:success failure:failure];
}

#pragma mark - request helpers

- (BOOL) shouldSendRequest:(AORequestMetadata *)requestMetadata forCacheState:(CacheState)cacheState
{
    if (requestMetadata.forceSendRequest)
    {
        return YES;
    }
    else
    {
        //order does matter!
        if (cacheState & CacheStateLoading) {
            return NO;
        }
        else if (cacheState & CacheStateExpired)
        {
            return YES;
        }
        else if (cacheState & CacheStateAvailable)
        {
            return NO;
        }
    }

    return YES;
}

- (NSMutableURLRequest *) requestWithMethod:(NSString *)method requestMetadata:(AORequestMetadata *)requestMetadata
{
    NSString * url = [requestMetadata requestPathWithBaseURL:self.baseURL]; //encoded URL...

    NSMutableURLRequest * request = [self.manager.requestSerializer requestWithMethod:method URLString:url parameters:requestMetadata.queryParameters error:nil];

    [request setTimeoutInterval:self.requestTimeout];
    //[request setCachePolicy:self.manager.requestSerializer.cachePolicy];

    if (requestMetadata.body)
    {
        [request setHTTPBody:requestMetadata.body];
    }

    [requestMetadata.headerParameters enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop)
    {
        if (![request valueForHTTPHeaderField:field])
        {
            [request setValue:value forHTTPHeaderField:field];
        }
    }];

    return request;
}

- (AORequestHandler *) asynchronouslyPerformMethod:(NSString *) method
                                    requestMetadata:(AORequestMetadata *) requestMetadata
                                             parser:(id<AOObjectParserProtocol>) parser
                                            success:(void (^)(id response)) success
                                            failure:(void (^)(AOError *error)) failure
{
    NSMutableURLRequest * request = [self requestWithMethod:method requestMetadata:requestMetadata];

    if (requestMetadata.requestTransformer) {
        requestMetadata.requestTransformer(request);
    }

    __weak AOService *weakSelf = self;

    NSURLSessionDataTask *task = nil;

    task = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
        {
            if (! error)
            {
#ifdef DEBUG
                //DLog(@"AO-[service]\n%@ REQUEST: %@\nHEADERS: %@\nRESPONSE-[ok]: %@", method, request.URL.absoluteString, [request allHTTPHeaderFields], [responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]] ? [self truncatedString:[responseObject description] maxLength:kLogMaxResponseLength] : @"BINARY-FORMAT: LOG SKIPPED!" );
#endif
                AOParseBlock parseBlock = ^void(id parsedObject, AOError* parseError) {
                    if (requestMetadata.cacheKey) {
                        [weakSelf cacheResult:parsedObject forRequest:requestMetadata];
                    }

                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (requestMetadata.cacheKey) {
                            [weakSelf notifyCallersForKey:requestMetadata.cacheKey result:parsedObject error:parseError];
                        }

                        if (parseError) {
                            if (failure) {
                                failure(parseError);
                            }
                        } else if (success) {
                            success(parsedObject);
                        }
                    });
                };
                
                if (parser) {
                    if ([parser respondsToSelector:@selector(parse:requestMetadata:result:response:)]) {
                        [parser parse:responseObject requestMetadata:requestMetadata result:parseBlock response:(NSHTTPURLResponse*)response];
                    } else {
                        [parser parse:responseObject requestMetadata:requestMetadata result:parseBlock];
                    }
                } else {
                    parseBlock(responseObject, nil);
                }
            }
            else //error...
            {
#ifdef DEBUG
                //DLog(@"AO-[service]\n%@ REQUEST: %@\nHEADERS: %@\nRESPONSE-[fail]: %@", method, request.URL.absoluteString, [request allHTTPHeaderFields], [self truncatedString:[error description] maxLength:kLogMaxErrorLength]);
#endif
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSInteger statusCode = httpResponse.statusCode;
                
                AOError * aoError = [AOError errorWithCode:statusCode message:[error description] underlyingError:error responseObject:responseObject];

                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failure && task.state != NSURLSessionTaskStateCanceling) {
                        failure(aoError);
                    }

                    if (requestMetadata.cacheKey) {
                        [weakSelf notifyCallersForKey:requestMetadata.cacheKey result:nil error:aoError];
                    }
                });
            }
        }); //dispatch end...
    }]; //dataTaskWithRequest end...

    [task resume];

    AORequestHandler * reqHandler = [[AORequestHandler alloc] initWithTask:task metadata:requestMetadata];
    reqHandler.service = self;

    return reqHandler;
}

#pragma mark - Cookie handling

- (BOOL)cookieIsOurs:(NSHTTPCookie *)cookie
{
    return [cookie.domain isEqual:self.baseURL.host];
}

- (NSHTTPCookieStorage *)cookieStorage
{
    return [NSHTTPCookieStorage sharedHTTPCookieStorage];
}

- (NSArray *)cookies
{
    NSArray * cookies = [[self cookieStorage] cookies];

    return [cookies ao_filter:^BOOL(NSHTTPCookie * cookie)
    {
        return [self cookieIsOurs:cookie];
    }];
}

/*! Duplicates the received cookie, but rewrites the 'domain' property to the
 *  base URL of this WebServiceAdapter.
 */
- (void)addCookie:(NSHTTPCookie *)cookie previousOwner:(AOService *)prevOwner
{
    NSMutableDictionary * props = [cookie.properties mutableCopy];
    
    props[NSHTTPCookieDomain] = self.baseURL.host;
    props[NSHTTPCookieSecure] = [@"https" isEqual:self.baseURL.scheme] ? @"TRUE": @"FALSE";
    
    NSString * prevPath = @"";
    
    if (prevOwner)
    {
        NSURL *prevBaseURL = prevOwner.baseURL;
        prevPath = prevBaseURL.path;
    }
    
    NSString * currentPath = props[NSHTTPCookiePath];
    NSString * newPath = [currentPath stringByReplacingCharactersInRange:NSMakeRange(0, [prevPath length]) withString:self.baseURL.path];
    props[NSHTTPCookiePath] = newPath;
    
    NSHTTPCookie * ownCookie = [NSHTTPCookie cookieWithProperties:props];
    [[self cookieStorage] setCookie:ownCookie];
}

- (void)removeCookie:(NSHTTPCookie *)cookie
{
    [[self cookieStorage] deleteCookie:cookie];
}

- (void)clearCookies
{
    for (NSHTTPCookie * cookie in [self cookies])
    {
        [self.cookieStorage deleteCookie:cookie];
    }
}

#pragma mark - Helpers (Log)

-(NSString *) truncatedString:(NSString *)string maxLength:(NSUInteger)max
{
    if (kLogShouldTruncate) {
        return [NSString stringWithFormat:@"%@ [...]", [string substringToIndex:MIN([string length], max)]];
    }

    return string;
}

@end


#pragma mark - AOJSONService implementation

@interface AOJSONResponseSerializer : AFJSONResponseSerializer @end

@implementation AOJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id responseObject = [super responseObjectForResponse:response data:data error:error];
    
    if (! responseObject)
    {
        responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return responseObject;
}

@end


@implementation AOJSONService

- (void) initializeSerializers
{
    
    AFJSONRequestSerializer * requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.cachePolicy               = NSURLRequestReloadIgnoringLocalCacheData; //NSURLRequestUseProtocolCachePolicy
    requestSerializer.timeoutInterval           = self.requestTimeout;
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"POST", @"PUT", @"DELETE", nil];

    AOJSONResponseSerializer * responseSerializer = [AOJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes      = [NSSet setWithObjects:@"application/json", nil];

    [self.manager setRequestSerializer:requestSerializer];
    [self.manager setResponseSerializer:responseSerializer];
    
}

- (void)setQueryStringSerializationWithBlock:(NSString *(^)(NSURLRequest *, id, NSError *__autoreleasing *))block
{
    [self.manager.requestSerializer setQueryStringSerializationWithBlock:block];
}

@end

#pragma mark - AOXMLService implementation

@implementation AOXMLService

- (void) initializeSerializers
{
    
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.cachePolicy               = NSURLRequestReloadIgnoringLocalCacheData; //NSURLRequestUseProtocolCachePolicy
    requestSerializer.timeoutInterval           = self.requestTimeout;
    [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];

    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes     = [NSSet setWithObjects:@"application/xml", @"text/xml", nil];

    [self.manager setRequestSerializer:requestSerializer];
    [self.manager setResponseSerializer:responseSerializer];
 
}

- (void)setQueryStringSerializationWithBlock:(NSString *(^)(NSURLRequest *, id, NSError *__autoreleasing *))block
{
    [self.manager.requestSerializer setQueryStringSerializationWithBlock:block];
}

@end
