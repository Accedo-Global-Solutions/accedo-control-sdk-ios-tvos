//
//  NSArray+AO.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import <Foundation/Foundation.h>

@interface NSArray (AO)

- (NSArray *)ao_transform:(id(^)(id))block;

- (NSArray *)ao_filter:(BOOL(^)(id))block;

- (NSArray *)ao_arrayByRemovingObject:(id)object;

@end
