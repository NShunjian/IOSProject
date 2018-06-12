//
//  NSArray+SafeValue.m
//  QQing
//
//  Created by Ben on 6/10/15.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import "NSArray+SafeValue.h"
#import "NSObject+SafeValueWithJSON.h"
#import "NSArray+ObjectAtIndexWithBoundsCheck.h"

@implementation NSArray (SafeValue)

- (NSString *)safeStringAtIndex:(NSUInteger)index {
    return [[self objectAtIndexIfIndexInBounds:index] safeString];
}

- (NSNumber *)safeNumberAtIndex:(NSUInteger)index {
    return [[self objectAtIndexIfIndexInBounds:index] safeNumber];
    
}

- (NSArray *)safeArrayAtIndex:(NSUInteger)index {
    return [[self objectAtIndexIfIndexInBounds:index] safeArray];
}

- (NSDictionary *)safeDictionaryAtIndex:(NSUInteger)index {
    return [[self objectAtIndexIfIndexInBounds:index] safeDictionary];
}

@end
