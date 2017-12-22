//
//  AOError.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//


#import <Foundation/Foundation.h>

#import "AOError.h"

static NSString *const kErrorDomain = @"tv.accedo.one.AOError";
static NSString *const kErrorMessageUnknown = @"AO Unkonwn Error";

static const NSInteger unknownErrCode = INT_MIN;

@implementation AOError

+ (instancetype) errorWithUnderlyingError:(NSError *)underlyingError
{
    if (underlyingError == nil) return nil;
    
    return [AOError errorWithCode:unknownErrCode message:nil underlyingError:underlyingError];
}

+ (instancetype) errorWithMessage:(NSString *)message
{
    return [AOError errorWithCode:unknownErrCode message:message underlyingError:nil];
}

+ (instancetype) errorWithCode:(NSInteger)errorCode
{
    return [AOError errorWithCode:errorCode message:nil underlyingError:nil];
}

+ (instancetype) errorWithCode:(NSInteger)errorCode message:(NSString *)message underlyingError:(NSError *)underlyingError
{
    AOError *aoError = [[AOError alloc] initWithCode:errorCode message:message underlyingError:underlyingError];

    return aoError;
}

+ (instancetype) errorWithCode:(NSInteger)errorCode message:(NSString *)message underlyingError:(NSError *)underlyingError responseObject:(id) responseObject
{
    AOError *aoError = [[AOError alloc] initWithCode:errorCode message:message underlyingError:underlyingError];

    aoError.responseObject = responseObject;

    return aoError;
}

- (instancetype) initWithCode:(NSInteger)errorCode message:(NSString *)message underlyingError:(NSError *)underlyingError
{
    NSString *errMessage = message ? message : kErrorMessageUnknown;

    NSDictionary *userInfo = underlyingError ? @{NSLocalizedDescriptionKey:errMessage, NSUnderlyingErrorKey:underlyingError} : @{NSLocalizedDescriptionKey:errMessage};

    return [AOError errorWithDomain:kErrorDomain code:errorCode userInfo:userInfo];
}

@end
