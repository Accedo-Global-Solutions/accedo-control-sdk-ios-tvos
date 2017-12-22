//
//  AORequestMetadata.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AORequestMetadata.h"
#import "NSString+AO.h"

@implementation AORequestMetadata

#pragma mark - creation

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
{
    NSParameterAssert(path);

    return [AORequestMetadata requestMetadataWithPath:path queryParams:queryParameters headerParams:nil];
}

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                                cacheKey:(NSString *)cacheKey
{
    NSParameterAssert(path);

    return [AORequestMetadata requestMetadataWithPath:path queryParams:queryParameters headerParams:nil cacheKey:cacheKey];
}

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                            headerParams:(NSDictionary *)headerParameters
{
    NSParameterAssert(path);

    AORequestMetadata * request = [[AORequestMetadata alloc] init];

    request.path             = path;
    request.queryParameters  = queryParameters;
    request.headerParameters = headerParameters;

    return request;
}

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                            headerParams:(NSDictionary *)headerParameters
                                cacheKey:(NSString *)cacheKey
{
    NSParameterAssert(path);
    NSParameterAssert(cacheKey);

    AORequestMetadata * request = [AORequestMetadata new];

    request.path             = path;
    request.queryParameters  = queryParameters;
    request.headerParameters = headerParameters;

    request.cacheKey         = cacheKey;

    return request;
}

- (NSString *)requestPathWithBaseURL:(NSURL *)baseURL
{
    NSString * path = self.path;
    BOOL encoded    = NO;

    if (self.pathParameters != nil)
    {
        NSLog(@"WARNING : pathParameters umdandled");
//        encoded = YES;
//
//        SOCPattern * pattern = [SOCPattern patternWithString:self.path];
//        path = [pattern stringFromObject:self.pathParameters withBlock:^NSString *(NSString *interpolatedString) {
//            return [interpolatedString ao_urlEncode];
//        }];
    }

    NSString * absolutePath = path;

    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"])
    {
        if (!encoded)
        {
            path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
        }

        absolutePath = [[NSURL URLWithString:path relativeToURL:baseURL] absoluteString];
    }
    
    return absolutePath;
}

#pragma mark - public static helpers

//Deprecated! Use dictionaryToNSData.
+ (NSData *) dictionryToNSData:(NSDictionary *)dictionry error:(NSError **)error;
{
    return [NSJSONSerialization dataWithJSONObject:dictionry options:0 error:error];
}

+ (NSData *) dictionaryToNSData:(NSDictionary *)dictionary error:(NSError **)error
{
    return [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:error];
}

@end
