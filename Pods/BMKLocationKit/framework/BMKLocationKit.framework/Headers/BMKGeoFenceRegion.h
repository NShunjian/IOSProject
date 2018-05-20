//
//  BMKGeoFenceRegion.h
//  BMKLocationKit
//
//  Created by baidu on 2017/3/2.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BMKLocationManager.h"

///BMKGeoFence Region State
typedef NS_ENUM(NSInteger, BMKGeoFenceRegionStatus)
{
    BMKGeoFenceRegionStatusUnknown  = 0,       ///< 未知
    BMKGeoFenceRegionStatusInside   = 1,       ///< 在范围内
    BMKGeoFenceRegionStatusOutside  = 1 << 1,       ///< 在范围外
    BMKGeoFenceRegionStatusStayed   = 1 << 2,       ///< 停留(在范围内超过10分钟)
};

#pragma mark - BMKGeoFenceRegion


///地理围栏基类，不可直接使用
@interface BMKGeoFenceRegion : NSObject<NSCopying>


///BMKGeoFenceRegion的唯一标识符
@property (nonatomic, copy, readonly) NSString *identifier;


///用户自定义ID，可为nil。
@property (nonatomic, copy, readonly) NSString *customID;


///坐标点和围栏的关系，比如用户的位置和围栏的关系
@property (nonatomic, assign) BMKGeoFenceRegionStatus fenceStatus;

///设定围栏坐标系类型。默认为 BMKLocationCoordinateTypeGCJ02。
@property(nonatomic, readonly) BMKLocationCoordinateType coordinateType;

///上次发生状态变化的时间
@property(nonatomic, assign)NSTimeInterval lastEventTime;


/**
 *  @brief 判断位置与围栏状态
 *  @param CLLocationCoordinate2D 坐标值
 *  @return 返回BMKGeoFenceRegionStatus状态
 */
-(BMKGeoFenceRegionStatus)judgeStatusWithCoor:(CLLocationCoordinate2D)coor;

@end


#pragma mark - BMKLocationCircleRegion


///圆形地理围栏
@interface BMKGeoFenceCircleRegion : BMKGeoFenceRegion


///中心点的经纬度坐标
@property (nonatomic, readonly) CLLocationCoordinate2D center;


///半径，单位：米
@property (nonatomic, readonly) CLLocationDistance radius;

/**
 *  @brief 构造圆形围栏
 *  @param customid 用户自定义ID
 *  @param identityid 识别id
 *  @param center 中心坐标
 *  @param radius 围栏半径
 *  @param type 坐标系类型
 *  @return BMKGeoFenceCircleRegion id
 */
- (id)initWithCustomID:(NSString *)customid identityID:(NSString *)identityid center:(CLLocationCoordinate2D)center radius:(CLLocationDistance)radius coor:(BMKLocationCoordinateType)type;



@end


#pragma mark -BMKGeoFencePolygonRegion


///多边形地理围栏
@interface BMKGeoFencePolygonRegion : BMKGeoFenceRegion


///经纬度坐标点数据
@property (nonatomic, readonly) CLLocationCoordinate2D *coordinates;


///经纬度坐标点的个数
@property (nonatomic, readonly) NSInteger count;


/**
 *  @brief 构造多边形围栏
 *  @param customid 用户自定义ID
 *  @param identityid 识别id
 *  @param coor 多边形顶点
 *  @param count 顶点个数
 *  @param type 坐标系类型
 *  @return BMKGeoFencePolygonRegion id
 */
- (id)initWithCustomID:(NSString *)customid identityID:(NSString *)identityid coor:(CLLocationCoordinate2D *)coor count:(NSInteger)count coor:(BMKLocationCoordinateType)type;

@end

