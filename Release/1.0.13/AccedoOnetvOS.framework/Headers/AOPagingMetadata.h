//
//  AOPagingMetadata,h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AORequestMetadata.h"

@class AOPageData;

/**
 * AOPagingMetadata extends AORequestMetadata with information needed for a paged call
 */
@interface AOPagingMetadata : AORequestMetadata

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters;

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                                cacheKey:(NSString *)cacheKey;

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                            headerParams:(NSDictionary *)headerParameters;

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                            headerParams:(NSDictionary *)headerParameters
                                cacheKey:(NSString *)cacheKey;

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                            headerParams:(NSDictionary *)headerParameters
                                cacheKey:(NSString *)cacheKey
                                pageData:(AOPageData *)pageData;

@property (nonatomic, strong) AOPageData *pageData;

@end


/**
 * AOPageData object passed by the clients to the service, encapsulating the page offset, page size and sort information required to build a paged request with PagingMetadata
 */
@interface AOPageData : NSObject <NSCopying>

+ (instancetype) pageDataWithOffset:(NSUInteger) pageOffset pageSize:(NSUInteger) pageSize;

@property (nonatomic, assign) NSUInteger pageOffset;
@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSString * sortField;
@property (nonatomic, assign) BOOL sortOrderAscending;

@end


/**
 * AOPageResult object returned to the client/caller encapsulating the results of the paged call. In case parser was provided, the result will contained a parser page with parsed objects
 */
@interface AOPageResult : NSObject

+ (instancetype) pageResultWithContent:(NSArray* )content
                              pageData:(AOPageData *)pageData
                            totalCount:(NSUInteger)totalCount;

- (BOOL) hasNextPage;
- (BOOL) hasPreviousPage;

/**
 * Will return the AOPageData object to be used as input for the next paged call.
 *
 * NOTE: will return nil, in case no more pages are available!
 */
- (AOPageData *) nextPage;

@property (nonatomic, assign, readonly) NSUInteger pageOffset;
@property (nonatomic, assign, readonly) NSUInteger pageSize;

@property (nonatomic, assign) NSUInteger totalCount;
@property (nonatomic, strong) NSArray* content;

@end
