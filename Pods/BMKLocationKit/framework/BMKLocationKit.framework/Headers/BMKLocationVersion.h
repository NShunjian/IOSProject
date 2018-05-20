//
//  BMKLocationVersion.h
//  LocationComponent
//
//  Created by wzy on 15/9/9.
//  Copyright © 2015年 baidu. All rights reserved.
//

#ifndef BMKLocationVersion_h
#define BMKLocationVersion_h

#import <UIKit/UIKit.h>

/**
 *获取当前地图API location组件 的版本号
 *当前location组件版本 : 1.1.0
 *@return  返回当前API location组件 的版本号
 */
UIKIT_EXTERN NSString* BMKGetMapApiLocationComponentVersion();

/**
 *获取当前地图API location组件 的float版本号
 *当前location组件版本 : 1.1
 *@return  返回当前API location组件 的float版本号
 */
UIKIT_EXTERN float BMKGetMapApiLocationComponentFloatVersion();



#endif /* BMKLocationVersion_h */
