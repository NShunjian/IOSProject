//
//  BMKLocation.h
//  LocationComponent
//
//  Created by baidu on 2017/8/16.
//  Copyright © 2017年 baidu. All rights reserved.
//

#ifndef BMKLocation_h
#define BMKLocation_h

#import <CoreLocation/CoreLocation.h>
#import "BMKLocationReGeocode.h"

/** 
 * BMKLocationProvider 位置数据来源，分iOS系统定位和其他定位服务结果两种，目前仅支持iOS系统定位服务
 *
 */
typedef NS_ENUM(int, BMKLocationProvider) {
    
    BMKLocationProviderIOS = 0,           //!<位置来源于iOS本身定位
    BMKLocationProviderOther          //!<位置来源于其他定位服务
    
};

///描述百度iOS 定位数据
@interface BMKLocation : NSObject

///BMKLocation 位置数据
@property(nonatomic, copy, readonly) CLLocation * _Nullable location;

///BMKLocation 地址数据
@property(nonatomic, copy, readonly) BMKLocationReGeocode * _Nullable rgcData;

///BMKLocation 位置来源
@property(nonatomic, assign) BMKLocationProvider provider;

///BMKLocation 位置ID
@property(nonatomic, retain) NSString * locationID;

/**
 *  @brief 初始化BMKLocation实例
 *  @param loc CLLocation对象
 *  @param rgc BMKLocationReGeocode对象
 *  @return BMKLocation id
 */
- (id)initWithLocation:(CLLocation * _Nullable)loc withRgcData:(BMKLocationReGeocode * _Nullable)rgc;


@end

#endif /* BMKLocation_h */
