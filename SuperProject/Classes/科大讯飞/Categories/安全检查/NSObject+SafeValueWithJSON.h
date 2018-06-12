//
//  NSObject+SaveValueWithJSON.h
//  QQing
//
//  Created by Ben on 6/10/15.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SafeValueWithJSON)

- (id)safeValueFromJSON;

/**
 @brief 如果此对象是aClass则返回self，否则返回nil，
 */
- (id)safeObjectWithClass:(Class)aClass;

/**
 @brief 如果此对象是NSString则返回self，否则返回nil，
 */
- (NSString *)safeString;

/**
 @brief 如果此对象是NSNumber则返回self，否则返回nil，
 */
- (NSNumber *)safeNumber;

/**
 @brief 如果此对象是NSArray则返回self，否则返回nil，
 */
- (NSArray *)safeArray;

/**
 @brief 如果此对象是NSDictionary则返回self，否则返回nil，
 */
- (NSDictionary *)safeDictionary;

/**
 @brief 如果此对象是NSDate则返回self，否则返回nil，
 */
- (NSDate *)safeDate;

@end
