//
//  AccedoOneUserData.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AccedoOneUserData.h"
#import "AccedoOne.h"

static NSString *const kPathUserDataApp      = @"user";
static NSString *const kPathUserDataAppGroup = @"group";

@interface AccedoOneUserData ()
@property (nonatomic, strong) AccedoOne * service;
@end

@implementation AccedoOneUserData

-(instancetype) initWithService:(AccedoOne *) service {
    if (self = [super init]){
        _service = service;
    }
    return self;
}

- (void) allDataForUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(void (^)(NSDictionary *userData, AOError *err))completionBlock {
    
    NSString *requestPath = [[self pathForScope:scope] stringByAppendingPathComponent: userId];
    
    [self.service sendAuthenticatedGETRequest:requestPath queryParams:nil allowCache:NO onSuccess:^(NSDictionary *response)
     {
         if (completionBlock) {
             completionBlock(response, nil);
         }
     }
                         failureBlock:^(AOError *error)
     {
         if (completionBlock) {
             completionBlock(nil, error);
         }
     }];
}

- (void) storeData:(NSDictionary *)data forUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(void(^)(AOError *err))completionBlock {
    
    NSString *requestPath = [[self pathForScope:scope] stringByAppendingPathComponent: userId];
    
    NSData * body = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    
    [self.service setHeaderValue:@"application/json; charset=utf-8" headerField:@"Content-Type"];
    
    [self.service sendAuthenticatedPOSTRequest:requestPath params:nil body:body onSuccess:^(id response)
     {
         if (completionBlock) {
             completionBlock(nil);
         }
     }
                             onFailure:^(AOError *error)
     {
         if (completionBlock) {
             completionBlock(error);
         }
     }];
}

- (void) dataForUser:(NSString *)userId key:(NSString *)key scope:(AOUserDataScope)scope onComplete:(void(^)(NSString *value, AOError *err))completionBlock {
    
    NSString *requestPath = [NSString pathWithComponents: @[[self pathForScope:scope], userId, key]];
    
    [self.service sendAuthenticatedGETRequest:requestPath queryParams:nil allowCache:NO onSuccess:^(id response)
     {
         if (completionBlock) {
             completionBlock(response, nil);
         }
     }
                         failureBlock:^(AOError *error)
     {
         if (error.code == 200 && error.responseObject) //hack solution, as response is not a JSON but a plain string...
         {
             if (completionBlock) {
                 completionBlock(error.responseObject, nil);
             }
         }
         else
         {
             if (completionBlock) {
                 completionBlock(nil, error);
             }
         }
     }];
}

- (void) storeValue:(NSString *)value key:(NSString *)key forUser:(NSString *)userId scope:(AOUserDataScope)scope onComplete:(void(^)(AOError *err))completionBlock {
    
    NSString *requestPath = [NSString pathWithComponents: @[[self pathForScope:scope], userId, key]];
    NSData * body = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.service setHeaderValue:@"text/plain; charset=utf-8" headerField:@"Content-Type"];
    
    [self.service sendAuthenticatedPOSTRequest:requestPath params:nil body:body onSuccess:^(id response)
     {
         if (completionBlock) {
             completionBlock(nil);
         }
     }
                             onFailure:^(AOError *error)
     {
         if (completionBlock) {
             completionBlock(error);
         }
     }];
}

#pragma mark - Helpers (User Data)

- (NSString *) pathForScope:(AOUserDataScope)scope {
    switch (scope) {
        case AOUserDataScopeApplication:      return kPathUserDataApp;
        case AOUserDataScopeApplicationGroup: return kPathUserDataAppGroup;
        default: return nil;
    }
}



@end
