//
//  NSString+AO.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

@interface NSString (AO)

extern NSString * const PERCENT_ENCODING_RESERVED_CHARS;

- (NSString *) ao_urlEncode;
- (NSString *) ao_urlDecode;

#pragma mark - Hashing

- (NSString *) ao_md5;
- (NSString *) ao_base64String;
+ (NSString *) ao_uuidString;

#pragma mark - Query

- (NSDictionary *)ao_queryParams;

@end
