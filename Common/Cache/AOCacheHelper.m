//
//  AOCacheHelper.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AOCacheHelper.h"

@implementation AOCacheHelper

+ (NSString *) cacheKeyForMethod:(NSString *) methodName parameters:(NSDictionary*) parameters {
    return [AOCacheHelper cacheKeyForMethod:methodName parameters:parameters pathParameters:nil];
}

+ (NSString *) cacheKeyForMethod:(NSString *) methodName parameters:(NSDictionary*) parameters pathParameters:(NSDictionary*)pathParams {
    NSArray *allKeys1 = [[parameters allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSArray *allKeys2 = [[pathParams allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

    NSMutableString *returnValue = nil;
    NSRange range = [methodName rangeOfString:@"?"];
    if ( range.location!=NSNotFound ){
        returnValue = [NSMutableString stringWithString:[methodName substringToIndex:range.location]];
    }else {
        returnValue = [NSMutableString stringWithString:methodName];
    }

    for(NSString *key in allKeys1) {
        [returnValue appendFormat:@"-%@:%@", key, parameters[key]];
    }
    for(NSString *key in allKeys2) {
        [returnValue appendFormat:@"-%@:%@", key, pathParams[key]];
    }
    
    return [[returnValue dataUsingEncoding: NSUTF8StringEncoding] base64EncodedStringWithOptions: kNilOptions];
}

+ (NSString *)cacheKeyForURL:(NSURL *) url {
    return [AOCacheHelper cacheKeyForMethod:url.absoluteString parameters:nil pathParameters:nil];
}

+ (NSString *) cacheKeyForURL:(NSURL *) url parameters:(NSDictionary *) parameters {
    return [AOCacheHelper cacheKeyForMethod:url.absoluteString parameters:parameters pathParameters:nil];
}

+ (NSString *) cacheKeyForURL:(NSURL *) url parameters:(NSDictionary *) parameters pathParameters:(NSDictionary*)pathParams {
    return [AOCacheHelper cacheKeyForMethod:url.absoluteString parameters:parameters pathParameters:pathParams];
}

+ (NSString *) cacheKeyForRequest:(NSURLRequest *) request {
    return [AOCacheHelper cacheKeyForURL:request.URL];
}

@end
