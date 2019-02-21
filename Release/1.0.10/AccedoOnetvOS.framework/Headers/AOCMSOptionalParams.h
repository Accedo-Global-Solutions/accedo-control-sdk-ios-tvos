//
//  AOCMSOptionalParams.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//
#import <Foundation/Foundation.h>

@interface AOCMSOptionalParams : NSObject

+(AOCMSOptionalParams *_Nonnull) params;

-(NSMutableDictionary *_Nonnull) paramsDictionary;
-(NSString *_Nonnull) stringValue;

#pragma mark - Builders

-(AOCMSOptionalParams *_Nonnull) paramWithPreview:(BOOL)preview;
-(AOCMSOptionalParams *_Nonnull) paramWithDateAt:(NSDate *_Nonnull)at;
-(AOCMSOptionalParams *_Nonnull) paramWithOffset:(NSNumber *_Nonnull)offset;
-(AOCMSOptionalParams *_Nonnull) paramWithPageSize:(NSNumber *_Nonnull)size;
-(AOCMSOptionalParams *_Nonnull) paramWithLocale:(NSString *_Nonnull)locale;
-(AOCMSOptionalParams *_Nonnull) paramWithGID:(NSString *_Nonnull)gid;

/**
 * preview: if set to "true" the response will return the latest values for this Entry whether it is published or not.
 * Default is "false".
 */
@property (nonatomic, readonly) BOOL preview;

/**
 * at: Optional parameter. Used to get Entry preview for specific moment of time in past or future.
 * Value is an ISO formated date time string in UTC. Example: "at=2015-08-18T20:25:40Z". 
 * Can not be used if "preview" is set to "true".
 */
@property (nonatomic, readonly) NSDate * _Nullable at;

/**
 * offset: the offset in the pagination, starting at 0.
 */
@property (nonatomic, readonly) NSNumber * _Nullable offset;

/**
 * size: The number of results per page. Between 1 and 50, default is 20.
 */
@property (nonatomic, readonly) NSNumber * _Nullable size;

/**
 * locale: The Locale Code. This parameter is used to specify which Locale you want the Entry to contain. Omitting this parameter returns the default Locale. Example: en
 */
@property (nonatomic, readonly) NSString * _Nullable locale;

/**
 * gid: An optional global identifier used for whitelisting.
 */
@property (nonatomic, readonly) NSString * _Nullable gid;

@end
