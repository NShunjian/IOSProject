//
//  SMS_SDKResultHanderDef.h
//  SMS_SDKDemo
//
//  Created by 掌淘科技 on 14-7-11.
//  Copyright (c) 2014年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SMSSDKUserInfo;

typedef NS_ENUM(NSUInteger, SMSGetCodeMethod)
{
    SMSGetCodeMethodSMS = 0,  //文本短信方式
    SMSGetCodeMethodVoice = 1 //语音方式
};

/**
 *  @brief 验证码获取回调
 *  @param error 当error为空时表示成功
 */
typedef void (^SMSGetCodeResultHandler) (NSError *error);

/**
 * @from  v2.0.7
 * @brief 验证码验证回调
 * @param error 当error为空时表示成功
 */
typedef void (^SMSCommitCodeResultHandler) (NSError *error);

/**
 国家区号获取回调

 @param error error 当error为空时表示成功
 @param zonesArray 返回的区号数组
 */
typedef void (^SMSGetZoneResultHandler)(NSError *error,NSArray *zonesArray);

/**
 通讯录好友获取回调

 @param error 当error为空时表示成功
 @param friendsArray 好友信息数组
 */
typedef void (^SMSGetContactsFriendsResultHandler)(NSError *error,NSArray *friendsArray);

/**
 * @brief 提交用户信息回调
 * @from v1.1.1
 * @param error 当error为空时表示成功
 */
typedef void (^SMSSubmitUserInfoResultHandler) (NSError *error);





