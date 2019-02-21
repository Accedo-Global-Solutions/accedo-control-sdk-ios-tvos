//
//  AORequestMetadata.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

@interface AORequestMetadata : NSObject

#pragma mark - creation

+ (instancetype) requestMetadataWithPath:(NSString *) path
                             queryParams:(NSDictionary *) queryParameters;

+ (instancetype) requestMetadataWithPath:(NSString *) path
                             queryParams:(NSDictionary *) queryParameters
                                cacheKey:(NSString *) cacheKey;

+ (instancetype) requestMetadataWithPath:(NSString *) path
                             queryParams:(NSDictionary *) queryParameters
                            headerParams:(NSDictionary *) headerParameters;

+ (instancetype) requestMetadataWithPath:(NSString *) path
                             queryParams:(NSDictionary *) queryParameters
                            headerParams:(NSDictionary *) headerParameters
                                cacheKey:(NSString *) cacheKey;

#pragma mark - public static helpers

+ (NSData *) dictionryToNSData:(NSDictionary *)dictionry error:(NSError **)error __deprecated_msg("Use `dictionaryToNSData:error:`");;
+ (NSData *) dictionaryToNSData:(NSDictionary *)dictionary error:(NSError **)error;

#pragma mark - prpoerties

@property (nonatomic, strong) NSString     *path;
@property (nonatomic, strong) NSDictionary *pathParameters;
@property (nonatomic, strong) NSDictionary *queryParameters;
@property (nonatomic, strong) NSDictionary *headerParameters;
@property (nonatomic, strong) NSData       *body;

@property (nonatomic, strong) NSString     *cacheKey;
@property (nonatomic, strong) NSNumber     *cacheExpiration; //optional: if not set, default cache expiration will be used.

@property (nonatomic, strong) NSString     *identifier; //unique identifier of the request (if caller wants to identify this later)
@property (nonatomic, strong) NSDictionary *metaInfo;   //used in case the caller wants to pass extra information to the parser

- (NSString *)requestPathWithBaseURL:(NSURL *)baseURL;

@property (nonatomic, copy) void(^requestTransformer)(NSMutableURLRequest *);

@property (nonatomic, assign) BOOL         forceSendRequest; //set this to true, to force request sending, regardless of cache status...

@end
