//
//  AOPagingMetadata.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AOPagingMetadata.h"

@implementation AOPagingMetadata

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
{
    NSParameterAssert(path);
    
    return [AOPagingMetadata requestMetadataWithPath:path queryParams:queryParameters headerParams:nil];
}

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                                cacheKey:(NSString *)cacheKey
{
    NSParameterAssert(path);
    
    return [AOPagingMetadata requestMetadataWithPath:path queryParams:queryParameters headerParams:nil cacheKey:cacheKey];
}

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                            headerParams:(NSDictionary *)headerParameters
{
    NSParameterAssert(path);
    
    AOPagingMetadata * request = [AOPagingMetadata new];

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
    return [AOPagingMetadata requestMetadataWithPath:path queryParams:queryParameters headerParams:headerParameters cacheKey:cacheKey pageData:nil];
}

+ (instancetype) requestMetadataWithPath:(NSString *)path
                             queryParams:(NSDictionary *)queryParameters
                            headerParams:(NSDictionary *)headerParameters
                                cacheKey:(NSString *)cacheKey
                                pageData:(AOPageData *)pageData
{
    NSParameterAssert(path);
    NSParameterAssert(cacheKey);
    
    AOPagingMetadata * request = [AOPagingMetadata new];
    
    request.path             = path;
    request.queryParameters  = queryParameters;
    request.headerParameters = headerParameters;
    
    request.cacheKey         = cacheKey;
    request.pageData         = pageData;
    
    return request;
}

@end



@implementation AOPageData

+ (instancetype) pageDataWithOffset:(NSUInteger) pageOffset pageSize:(NSUInteger) pageSize
{
    AOPageData * pageData = [[AOPageData alloc] init];

    pageData.pageOffset = pageOffset;
    pageData.pageSize   = pageSize;

    return pageData;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    AOPageData *pageData = [[self class] allocWithZone:zone];

    pageData.pageOffset = self.pageOffset;
    pageData.pageSize   = self.pageSize;
    pageData.sortField  = self.sortField;
    pageData.sortOrderAscending = self.sortOrderAscending;

    return pageData;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.pageOffset      forKey:@"pageOffset"];
    [coder encodeInteger:self.pageSize        forKey:@"pageSize"];
    [coder encodeObject:self.sortField        forKey:@"sortField"];
    [coder encodeBool:self.sortOrderAscending forKey:@"sortOrderAscending"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];

    if (self) {
        _pageOffset         = [coder decodeIntegerForKey:@"pageOffset"];
        _pageSize           = [coder decodeIntegerForKey:@"pageSize"];
        _sortField          = [coder decodeObjectForKey:@"sortField"];
        _sortOrderAscending = [coder decodeBoolForKey:@"sortOrderAscending"];
    }

    return self;
}

@end



@interface AOPageResult()
@property (nonatomic, strong) AOPageData *pageData;
@end


@implementation AOPageResult

+ (instancetype) pageResultWithContent:(NSArray* )content
                              pageData:(AOPageData *)pageData
                            totalCount:(NSUInteger)totalCount
{
    AOPageResult * page = [[AOPageResult alloc] init];

    page.content    = content;
    page.totalCount = totalCount;

    page.pageData   = pageData;

    return page;
}

- (BOOL) hasNextPage
{
    if (!self.pageData) //should never happen (only in case no PageData provided by the service caller)
    {
        return NO;
    }

    if ([self.content count] < self.pageSize)
    {
        return NO;
    }
    
    return self.totalCount > MAX(self.pageOffset, 1) * self.pageSize;
}

- (BOOL) hasPreviousPage
{
    return self.pageOffset > 0;
}

- (NSUInteger) pageSize
{
    return self.pageData.pageSize;
}

- (NSUInteger) pageOffset
{
    return self.pageData.pageOffset;
}

- (AOPageData *) nextPage
{
    AOPageData * nextPageData = nil;

    if ([self hasNextPage])
    {
        nextPageData = [self.pageData copy];
        nextPageData.pageOffset += 1;
    }

    return nextPageData;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.pageData forKey:@"pageData"];
    [coder encodeInteger:self.totalCount forKey:@"totalCount"];
    [coder encodeObject:self.content forKey:@"content"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];

    if (self)
    {
        _pageData   = [coder decodeObjectForKey:@"pageData"];
        _totalCount = [coder decodeIntegerForKey:@"totalCount"];
        _content    = [coder decodeObjectForKey:@"content"];
    }

    return self;
}

@end
