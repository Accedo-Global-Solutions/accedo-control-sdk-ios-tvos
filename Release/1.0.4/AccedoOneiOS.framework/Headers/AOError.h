//
//  AOError.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

@interface AOError : NSError

+ (instancetype) errorWithUnderlyingError:(NSError *)underlyingError;
+ (instancetype) errorWithMessage:(NSString *)message;
+ (instancetype) errorWithCode:(NSInteger)errorCode;
+ (instancetype) errorWithCode:(NSInteger)errorCode message:(NSString *)umessage underlyingError:(NSError *)underlyingError;
+ (instancetype) errorWithCode:(NSInteger)errorCode message:(NSString *)message underlyingError:(NSError *)underlyingError responseObject:(id)responseObject;

- (instancetype) initWithCode:(NSInteger)errorCode message:(NSString *)message underlyingError:(NSError *)underlyingError;

//object constructed by the `responseSerializer` from the response and response data. Will be `nil` unless the operation `isFinished`, has a `response`, and has `responseData` with non-zero content length. If an error occurs during serialization, it's value will be `nil`
@property (nonatomic, strong) id responseObject;

@end
