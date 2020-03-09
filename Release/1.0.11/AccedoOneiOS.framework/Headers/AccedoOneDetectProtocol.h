//
//  AccedoOneDetectProtocol.h
//  AccedoOne
//
//  Copyright (c) 2018 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

/**
 * Log level types used for remote logging
 */
typedef NS_ENUM(NSUInteger, AOServiceLogLevel) {
    AOServiceLogLevelNotInitialized = NSNotFound,
    AOServiceLogLevelOff            = 0,
    AOServiceLogLevelError          = 1,
    AOServiceLogLevelWarn           = 2,
    AOServiceLogLevelInfo           = 3,
    AOServiceLogLevelDebug          = 4
};

@protocol AccedoOneDetectProtocol <NSObject>

- (void) logWithLevel:(AOServiceLogLevel)logLevel code:(NSUInteger)code message:(nonnull  NSString *)message dimensions:(nullable NSDictionary *)dimensions;

@end
