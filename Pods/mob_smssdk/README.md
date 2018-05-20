# SMSSDK-for-iOS

SMSSDK is the most popular social SDK for apps and mobile games ! We've already supported over 1000 country or zone in global world  until now. And also it’s easily to use in your app.now, I will tell you the steps liking this:

If you use cocoaPods ,now ,it's easily to import SMSSDK liking this:

##cocoapods import：

> * main module(necessary)

> * pod "SMSSDK"

Yeah, you are right,it's over using cocoaPods to import SMSSDK. The next is to import the file's header and use the API of the SMSSDK what you wanted.

## Now,tell you the steps of importing SMSSDK manually.

## Step1: Download the SDK from here :[Download SMSSDK_iOS](http://www.mob.com/#/downloadDetail/SMS/ios)

When you download the SDK, you will get something liking this:
![](http://upload-images.jianshu.io/upload_images/4131265-e6a95e82b977bd69.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

It’s contain the three parties:

> * SMSSDK. Including static libraries and local files.When used directly to this folder into the project.
> * SMSSDKDemo. Showing the SDK foundation.
> * SMSSDKUI. If you want to use it, drag SMSSDKUI.xcodeproj to your project directly.

## Step2：Import the SDK

Drag  this folder into the project:
![](http://upload-images.jianshu.io/upload_images/4131265-d1c81101c46f7707.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Step3: Add libraries 

Required:

> *  libz.dylib
> * libstdc++.dylib

Show you like this：
![](http://upload-images.jianshu.io/upload_images/4131265-6644e7b04dfd6235.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Step4: config ur appKey and appSerect in the project's infoplist

![image](http://upload-images.jianshu.io/upload_images/4131265-a57b525679f8810d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## Step5: Using API 

In the SMSSDK file ,it contains all the API in the SDK, and here,you can use anyone that you wanted liking this:


- **Get verificationCode**


```
[SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"13800138000" zone:@"86" result:^(NSError *error) {

if (!error)
{
// 请求成功
}
else
{
// error
}
}];
```


- **commit**


```
[SMSSDK commitVerificationCode:@"1234" phoneNumber:@"13800138000" zone:@"86" result:^(NSError *error) {

if (!error)
{
// 验证成功
}
else
{
// error
}
}];
```

## If you want to see the chinese document,please [click here](http://wiki.mob.com/sdk-sms-ios-3-0/) !
