//
//  NSArray+AO.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

#import "NSArray+AO.h"

@implementation NSArray (AO)

- (NSArray *)ao_transform:(id(^)(id))block
{
    NSMutableArray*result=[NSMutableArray array];
    for(id x in self){
        id n = block(x);
        if (n)
        {
            [result addObject:block(x)];
        }
    }
    return result;
}

- (NSArray *)ao_filter:(BOOL(^)(id))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }]];
}

- (NSArray *)ao_arrayByRemovingObject:(id)object {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != %@", object]];
}

@end
