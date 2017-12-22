//
//  AOCacheAtom.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AOCacheAtom.h"

@implementation AOCacheAtom

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.payload = [aDecoder decodeObjectForKey:@"payload"];
        self.creationTime = [[aDecoder decodeObjectForKey:@"creationTime"] doubleValue];
        self.expirationTime = [[aDecoder decodeObjectForKey:@"expirationTime"] doubleValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.payload forKey:@"payload"];
    [aCoder encodeObject:@(self.creationTime) forKey:@"creationTime"];
    [aCoder encodeObject:@(self.expirationTime) forKey:@"expirationTime"];
}

- (instancetype)initWithPayload:(NSObject<NSCoding> *)payload creationTime:(NSTimeInterval)created expiresIn:(NSTimeInterval)timeToLive
{
    self = [super init];
    if (self)
    {
        _payload = payload;
        _creationTime = created;
        _expirationTime = created + timeToLive;
    }
    return self;
}

- (BOOL)hasExpired
{
    NSDate *now = [NSDate date];
    return [now compare:[NSDate dateWithTimeIntervalSince1970:self.expirationTime]] == NSOrderedDescending;
}

- (void)resurrect
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    self.expirationTime -= self.creationTime;
    self.expirationTime += now;
    self.creationTime = now;
}

- (NSString *) description
{
    return [ NSString stringWithFormat: @"Value: %@, timeStamp: %f, expirtationTime: %f", _payload, _creationTime, _expirationTime ];
}

@end
