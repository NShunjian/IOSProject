//
//  SMS_SDK.h
//  SMS_SDKDemo
//
//  Created by 刘 靖煌 on 14-8-28.
//  Copyright (c) 2014年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SMS_SDK/SMSSDKResultHandlerDef.h>
#import <SMS_SDK/SMSSDKUserInfo.h>

/**
 * @brief 核心类（Core class）v2.1.5
 */
@interface SMSSDK : NSObject

#pragma mark - 支持获取验证码和提交验证码 (get the verification code and commit verifacation code)
/**
 *  @from                    v1.1.1
 *  @brief                   获取验证码(Get verification code)
 *
 *  @param method            获取验证码的方法(The method of getting verificationCode)
 *  @param phoneNumber       电话号码(The phone number)
 *  @param zone              区域号，不要加"+"号(Area code)
 *  @param result            请求结果回调(Results of the request)
 */
+ (void) getVerificationCodeByMethod:(SMSGetCodeMethod)method
                         phoneNumber:(NSString *)phoneNumber
                                zone:(NSString *)zone
                              result:(SMSGetCodeResultHandler)result __deprecated_msg("deprecated from v3.1.0");

/**
 *  @from                    v3.1.0
 *  @brief                   获取验证码(Get verification code)
 *
 *  @param method            获取验证码的方法(The method of getting verificationCode)
 *  @param phoneNumber       电话号码(The phone number)
 *  @param zone              区域号，不要加"+"号(Area code)
 *  @param tmpCode           模板id(template id)
 *  @param result            请求结果回调(Results of the request)
 */
+ (void) getVerificationCodeByMethod:(SMSGetCodeMethod)method
                         phoneNumber:(NSString *)phoneNumber
                                zone:(NSString *)zone
                            template:(NSString *)tmpCode
                              result:(SMSGetCodeResultHandler)result;


/**
 * @from                    v1.1.1
 * @brief                   提交验证码(Commit the verification code)
 *
 * @param code              验证码(Verification code)
 * @param phoneNumber       电话号码(The phone number)
 * @param zone              区域号，不要加"+"号(Area code)
 * @param result            请求结果回调(Results of the request)
 */
+ (void) commitVerificationCode:(NSString *)code
                    phoneNumber:(NSString *)phoneNumber
                           zone:(NSString *)zone
                         result:(SMSCommitCodeResultHandler)result;
/**
 * @from                    v2.0.1
 * @return                  返回SDK版本号(Return the version number of this SDK)
 */
+ (NSString *) sdkVersion;

/**
 * @from         v1.1.1
 * @brief        获取区号(Get the Area code of the country)
 *
 * @param result 请求结果回调(Results of the request)
 */
+ (void) getCountryZone:(SMSGetZoneResultHandler)result;

@end
