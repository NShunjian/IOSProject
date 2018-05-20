//
//  SUPUMeng.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPUMeng.h"
#define USHARE_DEMO_APPKEY @"5861e5daf5ade41326001eab"
@implementation SUPUMeng
+(void)UMSocialShare{
    /* 打开日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:nil];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
       //此方法是为了显示面板上平台顺序
    
        //设置用户自定义的平台
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                                   @(UMSocialPlatformType_WechatTimeLine),
                                                   @(UMSocialPlatformType_WechatFavorite),
                                                   @(UMSocialPlatformType_QQ),
                                                   @(UMSocialPlatformType_Qzone),
                                                   @(UMSocialPlatformType_Sina),
                                                   @(UMSocialPlatformType_TencentWb),
                                                @(UMSocialPlatformType_UserDefine_Begin+1)
                                                   ]];
    

//    __weak typeof(self) weakSelf = self;
    
    //此方法是点击某个平台的回调
    
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//
//        //根据具体情况调用不同的方法
//
////        [weakSelf shareWebPageToPlatformType:platformType];
//
//    }];
    
   
}
@end
