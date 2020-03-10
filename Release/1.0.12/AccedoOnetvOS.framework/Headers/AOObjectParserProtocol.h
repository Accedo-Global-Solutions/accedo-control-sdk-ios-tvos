//
//  AOObjectParserProtocol.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

#import "AOError.h"

typedef void (^AOParseBlock)(id parsedObject, AOError* parseError);


@class AORequestMetadata;

@protocol AOObjectParserProtocol <NSObject>

@required
- (void) parse:(id)serializedData requestMetadata:(AORequestMetadata *)metadata
        result:(AOParseBlock)resultBlock;

@optional
- (void) parse:(id)serializedData requestMetadata:(AORequestMetadata *)metadata
        result:(AOParseBlock)resultBlock
      response:(NSHTTPURLResponse *)httpResponse;

@end
