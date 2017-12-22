//
//  AOServiceComponent.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AOServiceComponent.h"
#import "AOService.h"

@interface AOServiceComponent()

@property (nonatomic, weak) AOService * aoService;
@property (nonatomic, strong) NSMutableDictionary *subComponents;

@end


@implementation AOServiceComponent

- (id)initWithService:(AOService *)aoService
{
    self = [super init];

    if (self)
    {
        self.subComponents = [NSMutableDictionary dictionary];
        self.aoService    = aoService;
    }

    return self;
}

- (id)init
{
    return [self initWithService:nil];
}

- (AOServiceComponent *)subComponent:(Class)clazz
{
    @synchronized(clazz)
    {
        if (self.subComponents[(id<NSCopying>)clazz] == nil)
        {
            AOServiceComponent * instance = [[clazz alloc] initWithService:self.aoService];
            self.subComponents[(id<NSCopying>)clazz] = instance;
        }
        
        return self.subComponents[(id<NSCopying>)clazz];
    }
}

#pragma mark - asynchronous service endpoint handlers

- (AORequestHandler *) GET:(AORequestMetadata *) requestMetadata
                     parser:(id<AOObjectParserProtocol>) parser
                    success:(void (^)(id response)) success
                    failure:(void (^)(AOError *error)) failure
{
    return [self.aoService GET:requestMetadata parser:parser success:success failure:failure];
}

- (AORequestHandler *) POST:(AORequestMetadata *) requestMetadata
                      parser:(id<AOObjectParserProtocol>) parser
                     success:(void (^)(id response)) success
                     failure:(void (^)(AOError *error)) failure
{
    return [self.aoService POST:requestMetadata parser:parser success:success failure:failure];
}

- (AORequestHandler *) PUT:(AORequestMetadata *) requestMetadata
                     parser:(id<AOObjectParserProtocol>) parser
                    success:(void (^)(id response)) success
                    failure:(void (^)(AOError *error)) failure
{
    return [self.aoService PUT:requestMetadata parser:parser success:success failure:failure];
}

- (AORequestHandler *) DELETE:(AORequestMetadata *) requestMetadata
                        parser:(id<AOObjectParserProtocol>) parser
                       success:(void (^)(id response)) success
                       failure:(void (^)(AOError *error)) failure
{
    return [self.aoService DELETE:requestMetadata parser:parser success:success failure:failure];
}

- (AORequestHandler *) GETPAGE:(AOPagingMetadata *) pageMetadata
                         parser:(id<AOObjectParserProtocol>) parser
                        success:(void (^)(AOPageResult * page)) success
                        failure:(void (^)(AOError *error)) failure
{
    return [self.aoService GETPAGE:pageMetadata parser:parser success:success failure:failure];
}



@end
