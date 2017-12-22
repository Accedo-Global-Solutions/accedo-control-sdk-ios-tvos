//
//  AOCacheHelper.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

/**
 *  Helpers used by Service implementations to build Cache handlers and generate cache keys
 *  @see MethodBasedCache
 */
@interface AOCacheHelper : NSObject

+ (NSString *) cacheKeyForMethod:(NSString *)methodName parameters:(NSDictionary*)parameters;
+ (NSString *) cacheKeyForMethod:(NSString *)methodName parameters:(NSDictionary*)parameters pathParameters:(NSDictionary*)pathParams;

+ (NSString *) cacheKeyForURL:(NSURL *)url;
+ (NSString *) cacheKeyForURL:(NSURL *)url parameters:(NSDictionary *)parameters;
+ (NSString *) cacheKeyForURL:(NSURL *)url parameters:(NSDictionary *)parameters pathParameters:(NSDictionary*)pathParams;

+ (NSString *) cacheKeyForRequest:(NSURLRequest *)request;

@end
