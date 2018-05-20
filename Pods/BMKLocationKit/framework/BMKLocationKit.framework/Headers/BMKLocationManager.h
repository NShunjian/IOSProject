//
//  BMKLocationManager.h
//  BMKLocationKit
//
//  Created by baidu on 2017/3/2.
//  Copyright © 2017年 baidu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BMKLocationReGeocode.h"
#import "BMKLocation.h"

/** BMKLocationCoordinateType 枚举坐标系类型
 *
 */
typedef NS_ENUM(NSUInteger, BMKLocationCoordinateType)
{
    BMKLocationCoordinateTypeBMK09LL = 0,        ///<BMK09LL
    BMKLocationCoordinateTypeBMK09MC,           ///<BMK09MC
    BMKLocationCoordinateTypeWGS84,        ///<WGS84
    BMKLocationCoordinateTypeGCJ02          ///<GCJ02
};

/** BMKLocationNetworkState 枚举识别网络状态类型
 *
 */
typedef NS_ENUM(int, BMKLocationNetworkState) {
    BMKLocationNetworkStateUnknown = 0,    ///<网络状态未知
    BMKLocationNetworkStateWifi,           ///<网络状态wifi
    BMKLocationNetworkStateWifiHotSpot,          ///<网络状态连接WIFI移动热点
    BMKLocationNetworkStateMobile2G,          ///<网络状态移动2G
    BMKLocationNetworkStateMobile3G,          ///<网络状态移动3G
    BMKLocationNetworkStateMobile4G        ///<网络状态移动4G
    
};


///BMKLocation errorDomain

FOUNDATION_EXPORT NSErrorDomain const BMKLocationErrorDomain;

///BMKLocation errorCode
typedef NS_ENUM(NSInteger, BMKLocationErrorCode)
{
    BMKLocationErrorUnknown = 1,               ///<未知错误
    BMKLocationErrorLocateFailed = 2,          ///<定位错误
    BMKLocationErrorReGeocodeFailed  = 3,      ///<逆地理错误
    BMKLocationErrorTimeOut = 4,               ///<超时
    BMKLocationErrorCanceled = 5,              ///<取消
    BMKLocationErrorCannotFindHost = 6,        ///<找不到主机
    BMKLocationErrorBadURL = 7,                ///<URL异常
    BMKLocationErrorNotConnectedToInternet = 8,///<连接异常
    BMKLocationErrorCannotConnectToHost = 9,   ///<服务器连接失败
    BMKLocationErrorHeadingFailed = 10,        ///<获取方向失败
    BMKLocationErrorFailureAuth  = 11,         ///<鉴权失败
};


/**
 *  @brief 单次定位返回Block
 *  @param location 定位信息，数据包括CLLocation 位置数据，BMKLocationReGeocode 地址信息，参考BMKLocation。
 *  @param state 移动热点状态
 *  @param error 错误信息，参考 BMKLocationErrorCode
 */
typedef void (^BMKLocatingCompletionBlock)(BMKLocation * _Nullable location, BMKLocationNetworkState state , NSError * _Nullable error);



@protocol BMKLocationManagerDelegate;

#pragma mark - BMKLocationManager


///BMKLocationManager类。初始化之前请设置 BMKLocationAuth 中的APIKey，否则将无法正常使用服务.
@interface BMKLocationManager : NSObject

///实现了 BMKLocationManagerDelegate 协议的类指针。
@property (nonatomic, weak, nullable) id<BMKLocationManagerDelegate> delegate;

///设定定位的最小更新距离。默认为 kCLDistanceFilterNone。
@property(nonatomic, assign) CLLocationDistance distanceFilter;

///设定定位精度。默认为 kCLLocationAccuracyBest。
@property(nonatomic, assign) CLLocationAccuracy desiredAccuracy;

///设定定位类型。默认为 CLActivityTypeAutomotiveNavigation。
@property(nonatomic, assign) CLActivityType activityType;

///设定定位坐标系类型。默认为 BMKLocationCoordinateTypeGCJ02。
@property(nonatomic, assign) BMKLocationCoordinateType coordinateType;

///指定定位是否会被系统自动暂停。默认为NO。
@property(nonatomic, assign) BOOL pausesLocationUpdatesAutomatically;


///是否允许后台定位。默认为NO。只在iOS 9.0及之后起作用。设置为YES的时候必须保证 Background Modes 中的 Location updates 处于选中状态，否则会抛出异常。由于iOS系统限制，需要在定位未开始之前或定位停止之后，修改该属性的值才会有效果。
@property(nonatomic, assign) BOOL allowsBackgroundLocationUpdates;

///指定单次定位超时时间,默认为10s。最小值是2s。注意单次定位请求前设置。注意: 单次定位超时时间从确定了定位权限(非kCLAuthorizationStatusNotDetermined状态)后开始计算。
@property(nonatomic, assign) NSInteger locationTimeout;

///指定单次定位逆地理超时时间,默认为10s。最小值是2s。注意单次定位请求前设置。
@property(nonatomic, assign) NSInteger reGeocodeTimeout;

///连续定位是否返回逆地理信息，默认YES。
@property (nonatomic, assign) BOOL locatingWithReGeocode;



/**
 *  @brief 单次定位。如果当前正在连续定位，调用此方法将会失败，返回NO。\n该方法将会根据设定的 desiredAccuracy 去获取定位信息。如果获取的定位信息精确度低于 desiredAccuracy ，将会持续的等待定位信息，直到超时后通过completionBlock返回精度最高的定位信息。\n可以通过 stopUpdatingLocation 方法去取消正在进行的单次定位请求。
 *  @param withReGeocode 是否带有逆地理信息(获取逆地理信息需要联网)
 *  @param withNetWorkState 是否带有移动热点识别状态(需要联网)
 *  @param completionBlock 单次定位完成后的Block
 *  @return 是否成功添加单次定位Request
 */
- (BOOL)requestLocationWithReGeocode:(BOOL)withReGeocode withNetworkState:(BOOL)withNetWorkState completionBlock:(BMKLocatingCompletionBlock _Nonnull)completionBlock;

/**
 *  @brief 开始连续定位。调用此方法会cancel掉所有的单次定位请求。
 */
- (void)startUpdatingLocation;

/**
 *  @brief 停止连续定位。调用此方法会cancel掉所有的单次定位请求，可以用来取消单次定位。
 */
- (void)stopUpdatingLocation;

/**
 * @brief 请求网络状态结果回调。
 */
- (void)requestNetworkState;


/**
 * @brief 该方法返回设备是否支持设备朝向事件回调。
 * @return 是否支持设备朝向事件回调
 */
+ (BOOL)headingAvailable;

/**
 * @brief 该方法为BMKLocationManager开始设备朝向事件回调。
 */
- (void)startUpdatingHeading;

/**
 * @brief 该方法为BMKLocationManager停止设备朝向事件回调。
 */
- (void)stopUpdatingHeading;


/**
 *  @brief 转换为百度经纬度的坐标
 *  @param coordinate 待转换的经纬度
 *  @param srctype    待转换坐标系类型
 *  @param destype    目标百度坐标系类型（bd09ll,bd09mc）
 *  @return 目标百度坐标系经纬度
 */
+ (CLLocationCoordinate2D) BMKLocationCoordinateConvert:(CLLocationCoordinate2D) coordinate SrcType:(BMKLocationCoordinateType)srctype DesType:(BMKLocationCoordinateType)destype;

/**
 *  @brief 判断目标经纬度是否在大陆以及港、澳地区。
 *  @param coordinate 待判断的目标经纬度
 *  @param coortype 待判断经纬度的坐标系类型
 *  @return 是否在大陆以及港、澳地区
 */
+ (BOOL) BMKLocationDataAvailableForCoordinate:(CLLocationCoordinate2D)coordinate withCoorType:(BMKLocationCoordinateType)coortype;


@end

#pragma mark - BMKLocationManagerDelegate


///BMKLocationManagerDelegate 协议定义了发生错误时的错误回调方法，连续定位的回调方法等。
@protocol BMKLocationManagerDelegate <NSObject>

@optional

/**
 *  @brief 当定位发生错误时，会调用代理的此方法。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error;


/**
 *  @brief 连续定位回调函数。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param location 定位结果，参考BMKLocation。
 *  @param error 错误信息。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error;

/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;


/**
 * @brief 该方法为BMKLocationManager提示需要设备校正回调方法。
 * @param manager 提供该定位结果的BMKLocationManager类的实例。
 */
- (BOOL)BMKLocationManagerShouldDisplayHeadingCalibration:(BMKLocationManager * _Nonnull)manager;

/**
 * @brief 该方法为BMKLocationManager提供设备朝向的回调方法。
 * @param manager 提供该定位结果的BMKLocationManager类的实例
 * @param heading 设备的朝向结果
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
          didUpdateHeading:(CLHeading * _Nullable)heading;

/**
 * @brief 该方法为BMKLocationManager所在App系统网络状态改变的回调事件。
 * @param manager 提供该定位结果的BMKLocationManager类的实例
 * @param state 当前网络状态
 * @param error 错误信息
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
     didUpdateNetworkState:(BMKLocationNetworkState)state orError:(NSError * _Nullable)error;


@end


