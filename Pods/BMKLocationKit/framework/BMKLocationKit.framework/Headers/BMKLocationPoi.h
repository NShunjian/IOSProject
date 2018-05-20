//
//  BMKLocationPoi.h
//  BMKLocationKit
//
//  Created by baidu on 2017/3/2.
//  Copyright © 2017年 baidu. All rights reserved.
//


///描述Poi各属性
@interface BMKLocationPoi : NSObject

///BMKLocationPoi的id属性
@property(nonatomic, copy, readonly) NSString *uid;

///BMKLocationPoi的名字属性
@property(nonatomic, copy, readonly) NSString *name;

///BMKLocationPoi的可信度
@property(nonatomic, assign, readonly) float relaiability;


/**
 *  @brief 通过NSDictionary初始化方法一
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;


/**
 *  @brief 通过NSDictionary初始化方法二
 */
- (id)initWithTwoDictionary:(NSDictionary *)dictionary;

@end


