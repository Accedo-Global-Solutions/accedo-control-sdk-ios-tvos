//
//  AccedoOneInsight.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AccedoOneInsight.h"
#import "AccedoOne.h"

static NSString *const kPathAnalytics        = @"event/log";

@interface AccedoOneInsight ()
@property (nonatomic, strong) AccedoOne * service;

@end

@implementation AccedoOneInsight

-(instancetype) initWithService:(AccedoOne *) service {
    if (self = [super init]){
        _service = service;
    }
    return self;
}


/**
 *  Log the application launch (simple)
 */
- (void) applicationStart {
    [self applicationStartSuccess:nil onFailure:nil];
}

/**
 *  Log the application launch
 */
-(void) applicationStartSuccess:(AOSuccessBlock)completionBlock onFailure:(AOErrorBlock)failureBlock {
    
    //[self sendAuthenticatedPOSTRequest:kPathAnalytics params:@{ @"eventType": @"START" } body:nil onSuccess:nil onFailure:nil];
    [self.service sendAuthenticatedPOSTRequest:kPathAnalytics params:nil body:[AORequestMetadata dictionaryToNSData:@{@"eventType": @"START"} error:nil] onSuccess:completionBlock onFailure:failureBlock];
}

/**
 *  Log the application termination
 */
-(void) applicationStop {
    [self applicationStop:YES];
}

/**
 *  Log the application termination and optionally clear cache.
 */
- (void) applicationStop:(BOOL)clearCache {
    
    //[self sendAuthenticatedPOSTRequest:kPathAnalytics params:@{ @"eventType": @"QUIT" } body:nil onSuccess:nil onFailure:nil];
    [self.service sendAuthenticatedPOSTRequest:kPathAnalytics params:nil body:[AORequestMetadata dictionaryToNSData:@{@"eventType": @"QUIT"} error:nil] onSuccess:nil onFailure:nil];
    
   
}



@end
