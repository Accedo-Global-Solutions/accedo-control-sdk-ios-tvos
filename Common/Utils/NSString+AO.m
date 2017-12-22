//
//  NSString+AO.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



static NSString * const kAFCharactersToBeEscapedInQueryString = @"?&=;+!@#$()',* ";

@implementation NSString (AO)

NSString * const PERCENT_ENCODING_RESERVED_CHARS = @"!*'();:@+$,/?%#[]=&";

-(NSString *)ao_urlEncode
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString *)ao_urlDecode
{
    
    float osVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (osVersion < 7.0)
    {
        NSString *decodedString = (NSString *)CFBridgingRelease(
            CFURLCreateStringByReplacingPercentEscapes(NULL,
                                                    (__bridge CFStringRef)self,
                                                    NULL));
        
        return decodedString;
    } else {
        NSString * decodedString = [self stringByRemovingPercentEncoding];
        
        return decodedString;
    }
}

- (NSString *)ao_md5 {
	const char *cString = [self UTF8String];
	unsigned char result[16];
	CC_MD5(cString, (unsigned int)strlen(cString), result);

    return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

- (NSString *)ao_base64String
{
    NSData *theData = [self dataUsingEncoding: NSASCIIStringEncoding];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        return [theData base64EncodedStringWithOptions:0];
    }
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;

    for (i = 0; i < length; i += 3)
    {
        NSInteger value = 0;
        NSInteger j;

        for (j = i; j < (i + 3); j++)
        {
            value <<= 8;
            
            if (j < length)
            {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


+ (NSString *) ao_uuidString
{
	CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuid);
	NSString *uuidNSString = [NSString stringWithString:(__bridge NSString *)uuidString];
	CFRelease(uuidString);
	CFRelease(uuid);

    return uuidNSString;
}

- (NSDictionary *)ao_queryParams
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSArray *queryComponents = [self componentsSeparatedByString:@"&"];
    for (NSString *component in queryComponents) {
        if ([component length] == 0) continue;

        NSRange equalsLocation = [component rangeOfString:@"="];
        if (equalsLocation.location == NSNotFound) {
            // There's no equals, so associate the key with NSNull
            parameters[[component ao_urlDecode]] = [NSNull null];
        } else {
            NSString *key = [[component substringToIndex:equalsLocation.location] ao_urlDecode];
            NSString *value = [[component substringFromIndex:equalsLocation.location + 1] ao_urlDecode];
            parameters[key] = value;
        }
    }
    return [NSDictionary dictionaryWithDictionary:parameters];
}

@end
