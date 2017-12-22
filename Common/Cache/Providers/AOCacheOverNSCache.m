//
//  AOCacheWSCacheProvider.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AOCacheOverNSCache.h"

@implementation AOCacheOverNSCache

- (id)createInternalCache:(NSString *)persistenceKey
{
    return [[NSCache alloc] init];
}

@end
