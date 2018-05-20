//
//  SUPAppDelegate.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BMKLocationkit/BMKLocationAuth.h>
#import "MPLocationManager.h"
@interface SUPAppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate,BMKLocationAuthDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)setupLoginViewController;
-(void)setUpHomeViewController;


@end
