//
//  SUPAppDelegate.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPAppDelegate.h"
#import "SUPTabBarController.h"
#import "SUPIntroductoryPagesHelper.h"
#import "AdvertiseHelper.h"
#import "YYFPSLabel.h"
#import "SUPGuidePushView.h"
#import "SUPLoginViewController.h"
#import "WJYAlertView.h"
#import "SUPUMengHelper.h"
#import "SUPUMeng.h"
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <SMS_SDK/SMSSDK+ContactFriends.h>
#import "SYSafeCategory.h"
#import "CYLPlusButtonSubclass.h"
#import "SWRevealViewController.h"
#import "LeftViewController.h"
#import "BaseAnimationController.h"
#import "RightViewController.h"
#import "Definition.h"
#import "YFMarqueeViewController.h"
@interface SUPAppDelegate ()<UITabBarControllerDelegate,CYLTabBarControllerDelegate>
@property(nonatomic, strong)BMKMapManager* mapManager;
@property(nonatomic,strong) MMDrawerController * drawerController;
@property(nonatomic, strong)CYLTabBarController *tabBarController;
@end

@implementation SUPAppDelegate
- (UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
    }
    return _window;
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError
{
    NSLog(@"location auth onGetPermissionState %ld",(long)iError);
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self map];
   
    
    //短信验证
    [SMSSDK enableAppContactFriends:YES];
     [self Hkustxunfei];
    //publicButton
//    [CYLPlusButtonSubclass registerPlusButton];
    
    [self setupLoginViewController];
   
    if (![GVUserDefaults standardUserDefaults].isLanuchedApp) {
        // 欢迎视图
        [SUPIntroductoryPagesHelper showIntroductoryPageView:@[@"intro_0.jpg", @"intro_1.jpg", @"intro_2.jpg", @"intro_3.jpg"]];
    }
    
    NSArray <NSString *> *imagesURLS = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189872684&di=03f9df0b71bb536223236235515cf227&imgtype=0&src=http%3A%2F%2Fatt1.dzwww.com%2Fforum%2F201405%2F29%2F1033545qqmieznviecgdmm.gif", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189851096&di=224fad7f17468c2cc080221dd78a4abf&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201505%2F12%2F20150512124019_GPjEJ.gif"];
    // 启动广告
    [AdvertiseHelper showAdvertiserView:imagesURLS];
    
    //iOS查看屏幕帧数工具   刷新率
     [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    
    //导向页
     [SUPGuidePushView showGuideView];
    
    // 友盟统计
    [SUPUMengHelper UMAnalyticStart];
    [SUPUMeng UMSocialShare];//要放在地下调用, 不然setPreDefinePlatforms这个方法会崩
    
    // 友盟社交化
     [SUPUMengHelper UMSocialStart];
    
    // 友盟推送
    [SUPUMengHelper UMPushStart:launchOptions];
    
    //键盘统一收回处理
    [self configureBoardManager];
    
    //统一处理一些为数组、集合等对nil插入会引起闪退
    [SYSafeCategory callSafeCategory];
    
    //清空未读标识removeAllPendingNotificationRequests
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    if (launchOptions) {
        
        [WJYAlertView showOneButtonWithTitle:@"有launchOptions!!" Message:launchOptions.description ButtonType:WJYAlertViewButtonTypeCancel ButtonTitle:@"知道了" Click:^{
            NSLog(@"是的有  launchOptions");
        }];

    }
    
    
    return YES;
}

#pragma mark -科大讯飞

-(void)Hkustxunfei{
    
    //Set log level
    [IFlySetting setLogFile:LVL_ALL];
    
    //Set whether to output log messages in Xcode console
    [IFlySetting showLogcat:YES];
    
    //Set the local storage path of SDK
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //Set APPID
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
    [IFlySpeechUtility createUtility:initString];

}

//登录页面
-(void)setupLoginViewController{
    
    [CYLPlusButtonSubclass registerPlusButton];
    
    SUPLoginViewController *login = [[SUPLoginViewController alloc]init];
    self.window.rootViewController = login;
    [self.window makeKeyAndVisible];

}

//进入主页
-(void)setUpHomeViewController{
   
    //左侧菜单栏
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    SUPNavigationController *lefNav = [[SUPNavigationController alloc]initWithRootViewController:leftViewController];
    //右侧菜单栏
    RightViewController *rightViewController = [[RightViewController alloc] init];
    
    
//    // 设置主窗口,并设置根控制器
//    [CYLPlusButtonSubclass registerPlusButton];
//    SUPTabBarController *tabBarControllerConfig = [[SUPTabBarController alloc] init];
//    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    //放在代理下面 不会有tabbar标记    这个要放开self.window.rootViewController = tabBarController; //这种可以实现tabbar 按钮的动画
//    SUPNavigationController *nav = [[SUPNavigationController alloc]initWithRootViewController:_tabBarController];

    SUPTabBarController *tabBarControllerConfig = [[SUPTabBarController alloc] init];
    _tabBarController = tabBarControllerConfig.tabBarController;
    _tabBarController.delegate = self;
    self.nav = [[SUPNavigationController alloc]initWithRootViewController:_tabBarController];
    
    
    //SWRevealViewController 这是一种侧滑
//    [self swRevealViewController:leftViewController right:rightViewController tabbar:tabBarController];
    
    //MMDrawerController  这是一种侧滑
    [self mmDrawerController:lefNav right:rightViewController tabbar:_tabBarController navController:self.nav];
    [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    
    

    
//   =======================================================================
    // 检查更新
//    [[SUPRequestManager sharedManager] GET:[SUPShunJianBaseUrl stringByAppendingPathComponent:@"jsons/updateapp.json"] parameters:nil completion:^(SUPBaseResponse *response) {
//        [self checkVersion:response];
//    }];
    
}

//SWRevealViewController 这是一种侧滑
-(void)swRevealViewController:(UIViewController*)leftViewController right:(UIViewController*)rightViewController tabbar:(CYLTabBarController*)tabBarController{
        //首页
//    BaseAnimationController *centerView1Controller = [[BaseAnimationController alloc] init];
    
    SWRevealViewController *revealViewController = [[SWRevealViewController alloc] initWithRearViewController:leftViewController frontViewController:tabBarController];
    
    revealViewController.rightViewController = rightViewController;
    
    //浮动层离左边距的宽度
    revealViewController.rearViewRevealWidth = 230;
    //revealViewController.rightViewRevealWidth = 230;
    
    //是否让浮动层弹回原位
    //mainRevealController.bounceBackOnOverdraw = NO;
    [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    self.window.rootViewController = revealViewController;
    [self.window makeKeyAndVisible];
}

//MMDrawerController  这是一种侧滑
-(void)mmDrawerController:(UIViewController*)leftViewController right:(UIViewController*)rightViewController tabbar:(CYLTabBarController*)tabBarController navController:(SUPNavigationController*)nav{
    self.drawerController =[[MMDrawerController alloc]initWithCenterViewController:nav leftDrawerViewController:leftViewController rightDrawerViewController:rightViewController];
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = 320.0;
    //    self.drawerController.maximumRightDrawerWidth = 80;
    [self.drawerController setShowsShadow:YES];
    
//    self.window.rootViewController = tabBarController; //这种可以实现tabbar 按钮的动画
    self.window.rootViewController = self.drawerController;
    
    [self.window makeKeyAndVisible];
    
    [self customizeInterfaceWithTabBarController:tabBarController];
    
}

- (void)customizeInterfaceWithTabBarController:(CYLTabBarController *)tabBarController {
    
    [tabBarController hideTabBadgeBackgroundSeparator];
    
    //添加小红点
    UIViewController *viewController = tabBarController.viewControllers[0];
    SUPLog(@"tabBarController = %@",viewController.tabBarItem);
    SUPLog(@"tabBarController == %@",viewController.tabBarItem.cyl_tabButton);
    UIView *tabBadgePointView0 = [UIView cyl_tabBadgePointViewWithClolor:RANDOM_COLOR radius:4.5];
    [viewController.tabBarItem.cyl_tabButton cyl_setTabBadgePointView:tabBadgePointView0];
    [viewController cyl_showTabBadgePoint];
    
    UIView *tabBadgePointView1 = [UIView cyl_tabBadgePointViewWithClolor:RANDOM_COLOR radius:4.5];
    @try {
        [tabBarController.viewControllers[1] cyl_setTabBadgePointView:tabBadgePointView1];
        [tabBarController.viewControllers[1] cyl_showTabBadgePoint];
        
        UIView *tabBadgePointView2 = [UIView cyl_tabBadgePointViewWithClolor:RANDOM_COLOR radius:4.5];
        [tabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView2];
        [tabBarController.viewControllers[2] cyl_showTabBadgePoint];
        
        [tabBarController.viewControllers[3] cyl_showTabBadgePoint];
        
        //添加提示动画，引导用户点击
        [self addScaleAnimationOnView:tabBarController.viewControllers[3].cyl_tabButton.cyl_tabImageView repeatCount:20];
    } @catch (NSException *exception) {}
}


#pragma mark -地图

-(void)map{
    //  这个百度地图对应 SUPBaiduMapViewController.h  这个类/////////////////////////
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
        NSLog(@"经纬度类型设置成功");
    } else {
        NSLog(@"经纬度类型设置失败");
    }
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"xYCkm8cw58M4ynpYB24xlT2LcVMdeBHD" authDelegate:self];
    BOOL ret = [_mapManager start:@"xYCkm8cw58M4ynpYB24xlT2LcVMdeBHD" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //////////////////////////////////////////////////////////////////////////////////
    
    /*  这个只是在启动时定位 与上面的是同样的只是写法不一样 */
    //地图定位初始化
    [MPLocationManager installMapSDK];
    //百度地图定位
    [[MPLocationManager shareInstance] startBMKLocationWithReg:^(BMKUserLocation *loction, NSError *error) {
        if (error) {
            SUPLog(@"定位失败,失败原因：%@",error);
        }
        else
        {
            SUPLog(@"定位信息：%f,%f",loction.location.coordinate.latitude,loction.location.coordinate.longitude);
            
            CLGeocoder *geocoder=[[CLGeocoder alloc]init];
            [geocoder reverseGeocodeLocation:loction.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                
                //处理手机语言 获得城市的名称（中文）
                NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
                NSString *currentLanguage = [userDefaultLanguages objectAtIndex:0];
                //如果不是中文 则强制先转成中文 获得后再转成默认语言
                if (![currentLanguage isEqualToString:@"zh-Hans"]&&![currentLanguage isEqualToString:@"zh-Hans-CN"]) {
                    //IOS9前后区分
                    if (isIOS9) {
                        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-Hans-CN", nil] forKey:@"AppleLanguages"];
                    }
                    else
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-Hans", nil] forKey:@"AppleLanguages"];
                    }
                }
                
                //转换地理信息
                if (placemarks.count>0) {
                    CLPlacemark *placemark=[placemarks objectAtIndex:0];
                    //获取城市
                    NSString *city = placemark.locality;
                    if (!city) {
                        //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                        city = placemark.administrativeArea;
                    }
                    
                    NSLog(@"百度当前城市：[%@]",city);
                    
                    // 城市名传出去后,立即 Device 语言 还原为默认的语言
                    [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
                }
            }];
        }
    }];
    
    //系统自带定位
    //    [[MPLocationManager shareInstance]  startSystemLocationWithRes:^(CLLocation *loction, NSError *error) {
    //        DDLogError(@"系统自带定位信息：%f,%f",loction.coordinate.latitude,loction.coordinate.longitude);
    //    }];
    
    
    /*   //////////////////////////////////////                 */
    
}

#pragma mark -应用跳转
//Universal link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    if (userActivity.webpageURL) {
        
        NSLog(@"%@", userActivity.webpageURL);
        
        [UIAlertController mj_showAlertWithTitle:@"web跳转应用" message:userActivity.webpageURL.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.addActionDefaultTitle(@"确认");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
        }];
    }
    
    return YES;
    
    //如果使用了Universal link ，此方法必写
    //    return [MWApi continueUserActivity:userActivity];
    
}

//iOS9+scheme跳转
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary *)options
{
    //必写
    //        [MWApi routeMLink:url];
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    
    if (!result) {
        // 其他如支付等SDK的回调
        
    }
    
    if (url) {
        NSLog(@"%@", url);
        [UIAlertController mj_showAlertWithTitle:@"iOS9+scheme跳转应用" message:url.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.addActionDefaultTitle(@"确认");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
        }];
        
    }
    
    
    return result;
}

// 支持所有iOS9以下系统,scheme 跳转
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //必写
    //    [MWApi routeMLink:url];
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
    if (!result) {
        // 其他如支付等SDK的回调
    }
    if (url) {
        
        NSLog(@"%@", url);
        
        NSLog(@"%@", url);
        [UIAlertController mj_showAlertWithTitle:@"iOS9以下系统scheme跳转应用" message:url.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.addActionDefaultTitle(@"确认");
        } actionsBlock:nil];
        
    }
    
    return result;
}


#pragma mark - deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * string =[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                         stringByReplacingOccurrencesOfString: @">" withString: @""]
                        stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"%@", string);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    NSLog(@"注册远程通知失败: %@", error);
    // 将下面C函数的函数地址当做参数
    //    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}



#pragma mark - 通知
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

    NSDictionary * userInfo = notification.request.content.userInfo;

    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于前台时的远程推送接受
            //关闭U-Push自带的弹出框
            [UMessage setAutoAlert:NO];
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];

            [UIAlertController mj_showAlertWithTitle:@"2_iOS10新增：处理前台收到通知的代理方法" message:userInfo.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {

                alertMaker.addActionDefaultTitle(@"确认");
            } actionsBlock:nil];

        }else{
            //应用处于前台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{

    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"%@",userInfo);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {

        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [UIAlertController mj_showAlertWithTitle:@"3_iOS10新增：处理后台点击通知的代理方法" message:userInfo.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.addActionDefaultTitle(@"确认");
        } actionsBlock:nil];
    }else{
        //应用处于后台时的本地推送接受
    }
}


//iOS10以下使用这两个方法接收通知，
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        
//            self.userInfo = userInfo;
            //定制自定的的弹出框
            if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
                                                                    message:@"Test On ApplicationStateActive"
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
        
                [alertView show];
        
            }
        completionHandler(UIBackgroundFetchResultNewData);
    }
}


//iOS10以下使用这个方法接收通知
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    //关闭U-Push自带的弹出框
//    [UMessage setAutoAlert:NO];
//    [UMessage didReceiveRemoteNotification:userInfo];
//
//    //    self.userInfo = userInfo;
//    //    //定制自定的的弹出框
//    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    //    {
//    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
//    //                                                            message:@"Test On ApplicationStateActive"
//    //                                                           delegate:self
//    //                                                  cancelButtonTitle:@"确定"
//    //                                                  otherButtonTitles:nil];
//    //
//    //        [alertView show];
//    //
//    //    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}


#pragma mark - checkVersion
- (void)checkVersion:(SUPBaseResponse *)response
{
    if (response.error || SUPIsEmpty(response.responseObject)) {
        return;
    }
    
    NSDictionary *responseData = response.responseObject;
    NSInteger lastest = [responseData[@"lastest"] integerValue];
    NSString *lastestUrl = responseData[@"lastestUrl"];
    
    if (!lastest || SUPIsEmpty(lastestUrl)) {
        return;
    }
    
    BOOL isForce = [responseData[@"isForce"] boolValue];
    // 是否在审核
    BOOL isInGod = [responseData[@"isInGod"] boolValue];
    NSInteger minSupport = [responseData[@"minSupport"] integerValue];
    NSString *suggestion = responseData[@"suggestion"];
    
    NSInteger currentVersion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] integerValue];
    
    if (currentVersion < lastest) {
        [UIAlertController mj_showAlertWithTitle:@"提示" message:suggestion appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.addActionDefaultTitle(@"确认升级");
            if (!isForce && minSupport <= currentVersion) {
                alertMaker.addActionCancelTitle(@"先用着吧");
            }
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if (buttonIndex == 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:lastestUrl] options:@{} completionHandler:^(BOOL success) {
                    NSLog(@"%zd", success);
                }];
            }
        }];
    }else {
        if (isInGod) {
            SUPIsInGod = isInGod;
            self.window.rootViewController = [[CYLTabBarController alloc] init];
        }
    }
}


#pragma mark 键盘收回管理
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField=60;
    manager.enableAutoToolbar = NO;
}
#pragma mark - delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    SUPLog(@"cyl_tabButton = %@",viewController.tabBarItem.cyl_tabButton);
    
    
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

#pragma mark - CYLTabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    SUPLog(@"[control cyl_isTabButton] = %zd",[control cyl_isTabButton]);
    if ([control cyl_isTabButton]) {
        //更改红标状态
        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
        } else {
            [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
        }
        
//        //更改红标状态
//        if ([tabBarController.selectedViewController cyl_isShowTabBadgePoint]) {
//            [tabBarController.selectedViewController cyl_removeTabBadgePoint];
//        } else {
//            [tabBarController.selectedViewController cyl_showTabBadgePoint];
//        }
        SUPLog(@"[control cyl_tabImageView] = %@",[control cyl_tabImageView]);
        animationView = [control cyl_tabImageView];
    }
    
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    }
      SUPLog(@"tabBarController == %@",tabBarController);
     SUPLog(@"tabBarController.selectedIndex == %zd",tabBarController.selectedIndex);
    SUPLog(@"[self cyl_tabBarController] == %@",[self cyl_tabBarController]);
    
//    这个要放开self.window.rootViewController = tabBarController; //这种可以实现tabbar 按钮的动画
//    if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
//        [self addScaleAnimationOnView:animationView repeatCount:1];
//    } else {
//        [self addRotateAnimationOnView:animationView];
//    }
    
    //这个是添加了侧滑之后用这个
    if (tabBarController.selectedIndex % 2 == 0) {
        [self addScaleAnimationOnView:animationView repeatCount:10];
    } else {
        [self addRotateAnimationOnView:animationView];
    }
}
//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

#pragma mark - 缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"JFCitySelector"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
