//
//  commonConstDef.h
//  QQingCommon
//
//  Created by 李杰 on 1/22/15.
//
//

#ifndef QQing_commonConstDef_h
#define QQing_commonConstDef_h

#define kLastLaunchAppVersion @"kLastLaunchAppVersion"

#define kCurrentDeviceTokenKey @"kCurrentDeviceTokenKey"

#define kNotificationMakePhoneInIM         @"NotificationMakePhoneInIM"           //打电话之前发通知，收起键盘

#define kCMBPayReturnUrl    @"https://www.baidu.com"

#define kAppStudentUrlScheme       @"com.qingqing.student"
#define kAppTeacherUrlScheme       @"com.qingqing.teacher"
#define kAppAssistantUrlScheme     @"com.qingqing.assistant"

static const NSInteger kCustomHuanXingApnsTitleMaxLength = 30;

static NSString *kTXCloudAppID = @"10028515";

typedef NS_ENUM(NSUInteger,MakePhoneCallType) {
    kMakePhoneCallType_WithStudentQQID,
    kMakePhoneCallType_WithTeacherQQID,
    kMakePhoneCallType_WithAssistantQQID,
    kMakePhoneCallType_WithPhoneNumber,
};

#endif
