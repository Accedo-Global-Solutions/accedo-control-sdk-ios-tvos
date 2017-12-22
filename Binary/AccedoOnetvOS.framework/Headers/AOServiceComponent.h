//
//  AOServiceComponent.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//
#import <Foundation/Foundation.h>

#import "AORequestMetadata.h"
#import "AOPagingMetadata.h"

#import "AOObjectParserProtocol.h"
 
@class AOError;
@class AOService;
@class AORequestHandler;

NS_ASSUME_NONNULL_BEGIN
 
/**
 *  Generic block that will be passed as parameter to remote services. Remote services will execute this block on succesful completion passing the result to the caller
 *
 *  @param response is either the raw response of the service, or if parser was provided, the parsed object
 */
typedef void (^AOSuccessBlock)(id response);


#define SUCCESS_BLOCK(type) \
typedef void (^type##SuccessBlock)(type * response);

/**
 *  Generic block that will be passed as parameter to remote services, to handle errors
 */
typedef void (^AOErrorBlock)(AOError* _Nonnull error);

/**
 * Default timeout (in seconds) for requests
 */
static NSTimeInterval const kAODefaultRequestTimeout = 15;


/**
 * AORequestHandler is always returned to the caller, to give clients possibility to cancel the request
 */
@interface AORequestHandler : NSObject

@property (nonatomic, weak) AOService * service;
@property (nonatomic, weak) AORequestMetadata *requestMetadata;
@property (nonatomic, weak, readonly) NSURLSessionDataTask *task;

//- (void) cancelRequest;

//- (void) own:(id)newOwner;

@end

#define COMPONENT(name, type)\
- (type *)name\
{\
return (type *)[self subComponent:[type class]]; \
}

@interface AOServiceComponent : NSObject

@property (readonly, weak, nonatomic) AOService * aoService;

- (id)initWithService:(nullable AOService *)aoService;

- (AOServiceComponent *)subComponent:(Class)clazz;

#pragma mark - asynchronous request

- (nullable AORequestHandler *) GET:(nonnull AORequestMetadata *) requestMetadata
                     parser:(nullable id<AOObjectParserProtocol>) parser //if no parser provided, raw data returned
                    success:(nullable void (^)(id _Nullable response)) success
                    failure:(nullable void (^)(AOError *error)) failure;

- (AORequestHandler *) POST:(nonnull AORequestMetadata *) requestMetadata
                      parser:(nullable id<AOObjectParserProtocol>) parser //if no parser provided, raw data returned
                     success:(nullable void (^)(id _Nullable response)) success
                     failure:(nullable void (^)(AOError *error)) failure;

- (AORequestHandler *) PUT:(nonnull AORequestMetadata *) requestMetadata
                     parser:(nullable id<AOObjectParserProtocol>) parser //if no parser provided, raw data returned
                    success:(nullable void (^)(id _Nullable response)) success
                    failure:(nullable void (^)(AOError *error)) failure;

- (AORequestHandler *) DELETE:(nonnull AORequestMetadata *) requestMetadata
                        parser:(nullable id<AOObjectParserProtocol>) parser //if no parser provided, raw data returned
                       success:(nullable void (^)(id _Nullable response)) success
                       failure:(nullable void (^)(AOError *error)) failure;

- (AORequestHandler *) GETPAGE:(nonnull AOPagingMetadata *) pageMetadata
                         parser:(nullable id<AOObjectParserProtocol>) parser //if no parser provided, raw data returned
                        success:(nullable void (^)(AOPageResult * _Nullable page)) success
                        failure:(nullable void (^)(AOError *error)) failure;

@end

NS_ASSUME_NONNULL_END
