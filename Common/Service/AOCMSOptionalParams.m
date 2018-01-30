//
//  AOCMSOptionalParams.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//
#import "AOCMSOptionalParams.h"

@interface AOCMSOptionalParams()

@property (nonatomic, assign, readwrite) BOOL preview;
@property (nonatomic, strong, readwrite) NSDate *at;
@property (nonatomic, strong, readwrite) NSNumber *offset;
@property (nonatomic, strong, readwrite) NSNumber *size;
@property (nonatomic, strong, readwrite) NSString *locale;
@property (nonatomic, strong, readwrite) NSString *gid;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end



@implementation AOCMSOptionalParams

-(id) init {
    self = [super init];
    return self;
}

#pragma mark - AccedoOneCMSParams

+(AOCMSOptionalParams *) params {
    AOCMSOptionalParams *params = [AOCMSOptionalParams new];
    return params;
}

-(NSMutableDictionary *) paramsDictionary {
    NSMutableDictionary * dict = [NSMutableDictionary new];

    if (self.preview) {
        dict[@"preview"] = @"true";
    }
    
    if (self.at) {
        dict[@"at"] = [self atDateToString];
    }

    if (self.size != nil) {
        dict[@"size"] = [self.size stringValue];
    }

    if (self.offset != nil) {
        dict[@"offset"] = [self.offset stringValue];
    }

    if (self.locale) {
        dict[@"locale"] = self.locale;
    }

    return dict;
}

-(NSString *) stringValue {
    NSMutableDictionary *pDict = [self paramsDictionary];
    return pDict.allKeys.count <= 0 ? @"-" : [pDict description];
}

#pragma mark - Builders

-(AOCMSOptionalParams *) paramWithPreview:(BOOL)preview {
    if (preview && self.at) {
        [NSException raise:NSGenericException format:@"CMSOptionalParams: 'at' parameter can not be used if 'preview' is set to 'YES'"];
    }
    self.preview = preview;
    return self;
}

-(AOCMSOptionalParams *) paramWithDateAt:(NSDate *)at {
    if (self.preview && at) {
        [NSException raise:NSGenericException format:@"CMSOptionalParams: 'at' parameter can not be used if 'preview' is set to 'YES'"];
    }
    self.at = at;
    return self;
}

-(AOCMSOptionalParams *) paramWithOffset:(NSNumber *)offset {
    if ([offset longValue] < 0) {
        [NSException raise:NSGenericException format:@"CMSOptionalParams: 'offset' parameter can not be a negative value"];
    }
    self.offset = offset;
    return self;
}

-(AOCMSOptionalParams *) paramWithPageSize:(NSNumber *)size {
    if ([size longValue] <= 0) {
        [NSException raise:NSGenericException format:@"CMSOptionalParams: 'size' parameter can not be smaller than '1'"];
    }
    self.size = size;
    return self;
}

-(AOCMSOptionalParams *) paramWithLocale:(NSString *)locale {
    if ([locale length] <= 0) {
        [NSException raise:NSGenericException format:@"CMSOptionalParams: 'locale' parameter can not be Nil"];
    }
    self.locale = locale;
    return self;
}

-(AOCMSOptionalParams *) paramWithGID:(NSString *)gid {
    if ([gid length] <= 0) {
        [NSException raise:NSGenericException format:@"CMSOptionalParams: 'gid' parameter can not be Nil"];
    }
    self.gid = gid;
    return self;
}

#pragma mark - Getter

-(NSDateFormatter *) dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        
        [_dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        //[_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
        //[_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        //[_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss:SSS"];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];

        [_dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [_dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    }

    return _dateFormatter;
}

-(NSString *) atDateToString {
    return self.at ? [self.dateFormatter stringFromDate:self.at] : nil;
}

@end
