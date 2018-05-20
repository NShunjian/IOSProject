//
//  BMKLocationReGeocode.h
//  BMKLocationKit
//
//  Created by baidu on 2017/3/2.
//  Copyright © 2017年 baidu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BMKLocationPoi.h"

///BMKLocationReGeocode类。描述跟地址有关的信息.
@interface BMKLocationReGeocode : NSObject

///国家名字属性
@property(nonatomic, copy, readonly) NSString *country;

///国家编码属性
@property(nonatomic, copy, readonly) NSString *countryCode;

///省份名字属性
@property(nonatomic, copy, readonly) NSString *province;

///城市名字属性
@property(nonatomic, copy, readonly) NSString *city;

///区名字属性
@property(nonatomic, copy, readonly) NSString *district;

///街道名字属性
@property(nonatomic, copy, readonly) NSString *street;

///街道号码属性
@property(nonatomic, copy, readonly) NSString *streetNumber;

///城市编码属性
@property(nonatomic, copy, readonly) NSString *cityCode;

///行政区划编码属性
@property(nonatomic, copy, readonly) NSString *adCode;


///位置语义化结果的定位点在什么地方周围的描述信息
@property(nonatomic, copy, readonly) NSString *locationDescribe;


///位置语义化结果的属性，该定位点周围的poi列表信息
@property(nonatomic, retain, readonly) NSArray<BMKLocationPoi *> *poiList;

/**
 *  @brief 通过NSData初始化方法
 */
- (id)initWithReGeocodeString:(NSData *)reGeocodeString;


/**
 *  @brief 通过JSON初始化方法
 */
- (id)initWithJsonString:(NSData *)jsonString withHighAccuracy:(BOOL)highAcc;

@end
