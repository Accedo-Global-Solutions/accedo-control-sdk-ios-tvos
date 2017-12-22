//
//  AccedoOneDetect.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

@class AccedoOne;

@interface AccedoOneDetect : NSObject
-(instancetype) initWithService:(AccedoOne *) service;

- (void) logWithLevel:(AOServiceLogLevel)logLevel code:(NSUInteger)code message:(NSString *)message dimensions:(NSDictionary *)dimensions;

@property (nonatomic, assign) AOServiceLogLevel logLevel;

@end

NS_ASSUME_NONNULL_END
