//
//  SUPUMengHelper.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMessage.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import <UMMobClick/MobClick.h>

@interface SUPUMengHelper : NSObject
/*!
 * 启动友盟统计功能
 */
+ (void)UMAnalyticStart;


/**
 初始化第三方登录和分享
 */
+ (void)UMSocialStart;


/**
 初始化推送
 
 */
+ (void)UMPushStart:(NSDictionary *)launchOptions;


/**
 自定义分享
 
 @param title 分享的标题
 @param subTitle 内容
 @param thumbImage 缩略图
 @param shareURL 分享的url
 */
+ (void)shareTitle:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(NSString *)thumbImage shareURL:(NSString *)shareURL;


#pragma mark - UM第三方登录
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType completion:(void(^)(UMSocialUserInfoResponse *result, NSError *error))completion;



#pragma mark - UM统计

/// 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)beginLogPageView:(__unsafe_unretained Class)pageView;

/// 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)endLogPageView:(__unsafe_unretained Class)pageView;


/*!
 * 自定义名称
 */
/// 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
+(void)beginLogPageViewName:(NSString *)pageViewName;

/// 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
+(void)endLogPageViewName:(NSString *)pageViewName;









/**
 @ 页面统计 - 进入
 @param name  界面名称
 */
+ (void)umengEnterViewWithName:(NSString *)name;



/**
 @ 页面统计 - 退出
 @param name  界面名称
 */
+ (void)umengOutViewWithName:(NSString *)name;



/**
 @ 计数事件统计
 @param eventId   事件Id
 */
+ (void)umengEventCountWithId:(NSString *)eventId;



/**
 @ 计算事件统计
 @param eventId     事件Id
 @param attributes  统计内容
 @param number      统计的数
 */
+ (void)umengEventCalculatWithId:(NSString *)eventId
                      attributes:(NSDictionary *)attributes
                          number:(id)number;



/**
 ScrollView 已滚动/浏览的百分比
 
 @param eventId     事件Id
 @param attributes  内容
 @param scrollview  滚动视图
 @param isVertical  竖直方向YES、 水平方向NO
 */
+ (void)umengEventScrollViewWithId:(NSString *)eventId
                        attributes:(NSDictionary *)attributes
                        scrollview:(UIScrollView *)scrollview
                        isVertical:(BOOL)isVertical;





@end
