//
//  JFAreaDataManager.h
//  JFFootball
//
//  Created by 张志峰 on 2016/11/18.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFAreaDataManager : NSObject

+ (JFAreaDataManager *)shareInstance;

- (void)areaSqliteDBData;


/**
 从shop_area.sqlite获取所有市

 @param cityData 查询返回值，所有市区数组
 */
- (void)cityData:(void (^)(NSMutableArray *dataArray))cityData;


/**
 获取市对应的city_number

 @param city 查询对象（城市名）
 @param cityNumber 查询返回值（city_number）
 */
- (void)cityNumberWithCity:(NSString *)city cityNumber:(void (^)(NSString *cityNumber))cityNumber;

/**
 获取某个市的所有区县

 @param cityNumber 查询对象
 @param areaData 查询返回值,该市的所有区县数组
 */
- (void)areaData:(NSString *)cityNumber areaData:(void (^)(NSMutableArray *areaData))areaData;


/**
 根据city_number获取当前城市名字

 @param cityNumber 城市ID
 @param currentCityName 当前城市名字
 */
- (void)currentCity:(NSString *)cityNumber currentCityName:(void (^)(NSString *name))currentCityName;


/**
 使用搜索框，搜索城市

 @param searchObject 搜索对象
 @param result 搜索回调结果
 */
- (void)searchCityData:(NSString *)searchObject result:(void (^)(NSMutableArray *result))result;
@end
