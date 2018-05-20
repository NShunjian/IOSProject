//
//  MyLocation.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/8/16.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <CoreLocation/CLLocation.h>
#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>


@class CLLocation;
@class CLHeading;
@interface MyLocation : BMKUserLocation

-(id)initWithLocation:(CLLocation *)loc withHeading:(CLHeading *)head;

@end
