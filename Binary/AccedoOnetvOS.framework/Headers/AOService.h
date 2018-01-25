//
//  AOService.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

#import "AOServiceComponent.h"
#import "AOCacheHandler.h"



/**
 * AOService is a generic HTTP service to serve as a base fo all Service implementations
 *
 * NOTES:
 * - default cache policy is set to NSURLRequestReloadIgnoringLocalCacheData
 * - default request timeout is 15 seconds.
 */
@interface AOService : AOServiceComponent

@property (nonatomic, strong, nullable) id<AOCacheHandler> cacheHandler;
@property (nonatomic, readonly) NSMutableDictionary * _Nonnull fetchQueues;

#pragma mark - Instantiation

- (instancetype _Nonnull) initWithURL:(nonnull NSString *) baseURL;
- (instancetype _Nonnull) initWithURL:(nonnull NSString *) baseURL requestTimeout:(NSTimeInterval) timeoutInterval;
- (instancetype _Nonnull) initWithURL:(nonnull NSString *) baseURL requestTimeout:(NSTimeInterval) timeoutInterval cacheHandler:(nullable id<AOCacheHandler>) cacheHandler;

#pragma mark - Service parameter handling

- (nonnull NSURL *) baseURL;

- (void) updateBaseURL:(nonnull NSURL *)newBaseUrl;
- (void) setCachePolicy:(NSURLRequestCachePolicy) cachePolicy;
- (void) setRequestTimeout:(NSTimeInterval) requestTimeout; //seconds

/** @brief service-wide header/value for all future requests. */
- (void) setHeaderValue:(nonnull NSString *) value headerField:(nonnull NSString *) headerField;
- (void) setContentType:(nonnull NSString *) contentType;
- (void) setHTTPUsername:(nonnull NSString *)username andPassword:(nonnull NSString *)password;

- (void) addAcceptableContentType:(nonnull NSString *)contentType; //add additional content type to the response serializer..

- (void)setMaxConcurrent:(NSInteger)maxConcurrent;

- (void) cancelAllRequests;

#pragma mark - Cookie handling

- (nonnull NSHTTPCookieStorage *) cookieStorage;
- (nullable NSArray *) cookies;
- (void) addCookie:(nonnull NSHTTPCookie *)cookie previousOwner:(nullable AOService *)prevOwner;
- (void) removeCookie:(nonnull NSHTTPCookie *)cookie;
- (void) clearCookies;

@end


/**
 * AOJSONService is a generic JSON service to serve as a base fo all JSON based service implementations
 */
@interface AOJSONService : AOService

//Entry to override queryParameters serialization (optional)
- (void)setQueryStringSerializationWithBlock:(NSString *_Nullable(^_Nullable)(NSURLRequest * _Nullable request, id _Nullable obj, NSError * _Nullable  __autoreleasing * _Nullable error))block;

@end


/**
 * AOXMLService is a generic HTTP service to serve as a base fo all XML based service implementations
 */
@interface AOXMLService  : AOService

//Entry to override queryParameters serialization (optional)
- (void)setQueryStringSerializationWithBlock:(nullable NSString *_Nullable(^)(NSURLRequest * _Nullable request, id _Nullable obj, NSError * _Nullable __autoreleasing * _Nullable error))block;

@end


