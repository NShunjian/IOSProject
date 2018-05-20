//
//  SMSSDK+ContactFriends.h
//  SMS_SDK
//
//  Created by 李愿生 on 15/8/25.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <SMS_SDK/SMSSDK.h>

@interface SMSSDK (ContactFriends)

#pragma mark - 是否启用通讯录好友功能、提交用户资料、请求通讯好友信息

/**
 * @brief          是否允许访问通讯录好友(is Allowed to access to address book)
 
 * @param  state   YES 代表启用 NO 代表不启用 默认为启用(YES,by default,means allow to access to address book)
 */
+ (void) enableAppContactFriends:(BOOL)state;

/**
 提交用户资料(Submit the user information data)

 @param userInfo 用户信息(User information)
 @param result 请求结果回调(Results of the request)
 */
+ (void) submitUserInfo:(SMSSDKUserInfo *)userInfo
                 result:(SMSSubmitUserInfoResultHandler)result;

/**
 向服务端请求获取通讯录好友信息(Get the data of address book which save in the server)

 @param result 请求结果回调(Results of the request)
 */
+ (void) getAllContactFriends:(SMSGetContactsFriendsResultHandler)result;

@end
