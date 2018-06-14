//
//  JFLocation.h
//  Football
//
//  Created by 张志峰 on 16/6/7.
//  Copyright © 2016年 zhangzhifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JFLocationDelegate <NSObject>

/// 定位中
- (void)locating;

/**
 当前位置

 @param locationDictionary 位置信息字典
 */
- (void)currentLocation:(NSDictionary *)locationDictionary;

/**
 拒绝定位后回调的代理

 @param message 提示信息
 */
- (void)refuseToUsePositioningSystem:(NSString *)message;

/**
 定位失败回调的代理

 @param message 提示信息
 */
- (void)locateFailure:(NSString *)message;

@end

@interface JFLocation : NSObject

@property (nonatomic, weak) id<JFLocationDelegate> delegate;
@end
