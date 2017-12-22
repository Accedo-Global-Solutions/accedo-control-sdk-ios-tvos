//
//  AOCacheOverPINCache.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AOCacheOverPINCache.h"

#import "PINCache.h"

@implementation AOCacheOverPINCache

- (id)createInternalCache:(NSString *)persistenceKey
{
    return [[PINCache alloc] initWithName:persistenceKey];
}

@end
