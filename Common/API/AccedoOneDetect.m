//
//  AccedoOneDetect.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "AccedoOneDetect.h"
#import "AccedoOne.h"

static NSString *const kPathLogLevel = @"application/log/level";
static NSString *const kPathLogDebug = @"application/log/debug";
static NSString *const kPathLogWarn  = @"application/log/warn";
static NSString *const kPathLogError = @"application/log/error";
static NSString *const kPathLogInfo  = @"application/log/info";

@interface AccedoOneDetect ()
@property (nonatomic, strong) AccedoOne * service;
@end


@implementation AccedoOneDetect

-(instancetype) initWithService:(AccedoOne *) service {
    if (self = [super init]){
        _service = service;
    }
    return self;
}

#pragma mark - AccedoOneDetectProtocol

/**
 *  Remote logging for debug and support purposes. Remote logging will only be fired if the requested log level (logLevel)
 *  is higher or equal to the configured log level in AccedoOne.
 *
 *  @param logLevel   The log level sent by the caller
 *  @param code       The code to be sent to the remote log
 *  @param message    The message to be sent to the remote log
 *  @param dimensions Optional parameter, containing a map of dimensions (pair key/value)
 */
- (void) logWithLevel:(AOServiceLogLevel)logLevel code:(NSUInteger)code message:(NSString *)message dimensions:(NSDictionary *)dimensions {
    
    if (self.logLevel == AOServiceLogLevelNotInitialized) {
        [self getLevel:^(AOServiceLogLevel configuredLogLevel) {
             [self logToRemoteServiceCode:code message:message dimensions:dimensions requestedLogLevel:logLevel];
        } onFailure:^(AOError *error) {
             ELog(@"AO-[error]: AccedoOneService logWithLevel failed with error: %@", error);
        }];
    } else {
        [self logToRemoteServiceCode:code message:message dimensions:dimensions requestedLogLevel:logLevel];
    }
}

#pragma mark - Utils

/**
 *  Log to the remote server if the current log level allows it
 *
 *  @param code              the log code
 *  @param message           message to log
 *  @param dimensions        optional parameter
 *  @param requestedLogLevel message level: it can be debug, warn, error and info. It will be compared with the log level fetched from the remote service to decide if the messsage will be logged to the remote service
 */
- (void) logToRemoteServiceCode:(NSUInteger)code
                        message:(NSString *)message
                     dimensions:(NSDictionary *)dimensions
              requestedLogLevel:(AOServiceLogLevel)requestedLogLevel {

    if ((requestedLogLevel >= self.logLevel) && (self.logLevel != AOServiceLogLevelOff)) {
        //Code and message are mandatory parameters, and code must be 5 digits tops
        NSParameterAssert(code);
        NSParameterAssert(message);
        NSAssert(code<= 99999, @"Log code must be max 5 digits");
        
        NSString *operation = [self logPathForLevel:self.logLevel];
        
        NSDictionary *params;
        
        if (dimensions) {
            params = @{ @"code": @(code), @"message": message, @"dimensions": dimensions };
        } else {
            params = @{ @"code": @(code), @"message": message };
        }
        
        //[self sendAuthenticatedPOSTRequest:operation params:params body:nil onSuccess:nil onFailure:nil];
        [self.service sendAuthenticatedPOSTRequest:operation params:nil body:[AORequestMetadata dictionaryToNSData:params error:nil] onSuccess:nil onFailure:nil];
    }
}

/**
 *  Get log level for the application as configured in AccedoOne.
 */
- (void) getLevel:(void (^)(AOServiceLogLevel configuredLogLevel))completionBlock onFailure:(AOErrorBlock)failureBlock {

    [self.service sendAuthenticatedGETRequest:kPathLogLevel queryParams:nil allowCache:NO onSuccess:^(NSDictionary *response) {
         NSString *remoteLogLevel = [response valueForKey:@"logLevel"];

         self.logLevel = [self stringToLogLevelType:remoteLogLevel];
         
         if (completionBlock) {
             completionBlock(self.logLevel);
         }

    } failureBlock:^(AOError *error) {
         self.logLevel = AOServiceLogLevelOff;
         
         if (failureBlock) {
             failureBlock(error);
         }
     }];
}

- (NSString *) logPathForLevel:(AOServiceLogLevel) logLevel {
    NSString *result = nil;
    
    switch(logLevel) {
        case AOServiceLogLevelOff:
            result = nil;
            break;
        case AOServiceLogLevelDebug:
            result = kPathLogDebug;
            break;
        case AOServiceLogLevelWarn:
            result = kPathLogWarn;
            break;
        case AOServiceLogLevelError:
            result = kPathLogError;
            break;
        case AOServiceLogLevelInfo:
            result = kPathLogInfo;
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected LogLevel."];
    }
    
    return result;
}

- (AOServiceLogLevel) stringToLogLevelType:(NSString *)logLevel {
    AOServiceLogLevel result = AOServiceLogLevelOff;
    
    if ([logLevel isEqualToString:@"debug"]) {
        result = AOServiceLogLevelDebug;
    }
    else if ([logLevel isEqualToString:@"warn"]) {
        result = AOServiceLogLevelWarn;
    }
    else if ([logLevel isEqualToString:@"error"]) {
        result = AOServiceLogLevelError;
    }
    else if ([logLevel isEqualToString:@"info"]) {
        result = AOServiceLogLevelInfo;
    }
    else {
        ELog(@"AO-[error]: AAccedoOneService failed to map logLevel (%@) to a known value (AccedoOneServiceLogLevel). Fallback to:  AccedoOneServiceLogLevelOff", logLevel);
    }

    return result;
}

@end
