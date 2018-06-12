//
//  QQingUtils.h
//  QQing
//
//  Created by 李杰 on 1/28/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface QQingUtils : NSObject

+ (QQingUtils *)sharedQQingUtils;

// Progress
+ (MBProgressHUD *)showProgressHUDWithText:(NSString *)text;
+ (MBProgressHUD *)showProgressHUDWithText:(NSString *)text inWindow:(UIWindow *)window;
+ (void)hideProgressHUDWithAnimated:(BOOL)animated;
+ (void)hideProgressHUD;

// Toast
+ (void)showToastWithText:(NSString *)text;
+ (void)showToastWithText:(NSString *)text withImageName:(NSString *)imageName blockUI:(BOOL)needBlockUI;

// Alert
+ (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message confirmTitle:(NSString*)enterStr;

// ScreenShoot
+ (UIImage *)screenshotForView:(UIView *)view;

@end
