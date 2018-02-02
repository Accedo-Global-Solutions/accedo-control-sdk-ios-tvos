//
//  AccedoOneDetect.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>
#import "AccedoOneDetectProtocol.h"

@class AccedoOne;

@interface AccedoOneDetect : NSObject <AccedoOneDetectProtocol>

- (instancetype _Nonnull) initWithService:(nonnull AccedoOne *) service;

@property (nonatomic, assign) AOServiceLogLevel logLevel;

@end
