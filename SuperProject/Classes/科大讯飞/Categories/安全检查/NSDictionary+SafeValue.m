//
//  NSDictionary+SafeValue.m
//  QQing
//
//  Created by Ben on 6/10/15.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import "NSDictionary+SafeValue.h"
#import "NSObject+SafeValueWithJSON.h"

@implementation NSDictionary (SafeValue)

- (NSString *)safeStringForKey:(id)aKey {
    return [[self objectForKey:aKey] safeString];
}

- (NSNumber *)safeNumberForKey:(id)aKey {
    return [[self objectForKey:aKey] safeNumber];
}

- (NSArray *)safeArrayForKey:(id)aKey {
    return [[self objectForKey:aKey] safeArray];
}

- (NSDictionary *)safeDictionaryForKey:(id)aKey {
    return [[self objectForKey:aKey] safeDictionary];
}

@end
