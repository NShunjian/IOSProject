//
//  QQingUtils.m
//  QQing
//
//  Created by 李杰 on 1/28/15.
//
//

#import "QQingUtils.h"
#import "MBProgressHUD.h"

//static const NSInteger kMinumAddLabelPopupViewBottomBlank = 10;

@interface QQingUtils () <UIGestureRecognizerDelegate>

// 弹出框
@property (nonatomic, strong) UIScrollView *popup;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, strong) UIView *contentHolder;
@property (nonatomic, assign) CGAffineTransform initialPopupTransform; // contentHolder

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@property (nonatomic, strong) MBProgressHUD *progressHUDForToast;

@end

@implementation QQingUtils

+ (QQingUtils *)sharedQQingUtils {
    static dispatch_once_t pred;
    __strong static QQingUtils *sharedQQingUtils = nil;
    dispatch_once( &pred, ^{
        sharedQQingUtils = [[QQingUtils alloc] init];
    });
    return sharedQQingUtils;
}

// Progress
+ (MBProgressHUD *)showProgressHUDWithText:(NSString *)text {
    return [QQingUtils showProgressHUDWithText:text inWindow:[[UIApplication sharedApplication] keyWindow]];
}

+ (MBProgressHUD *)showProgressHUDWithText:(NSString *)text inWindow:(UIWindow *)window {
    [[QQingUtils sharedQQingUtils].progressHUD hide:NO];
    if (window) {
        [QQingUtils sharedQQingUtils].progressHUD = [[MBProgressHUD alloc] initWithWindow:window];
        
        // Full screen show.
        [window addSubview:[QQingUtils sharedQQingUtils].progressHUD];
        [[QQingUtils sharedQQingUtils].progressHUD bringToFront];
        
        [QQingUtils sharedQQingUtils].progressHUD.labelText = text;
        [QQingUtils sharedQQingUtils].progressHUD.mode = (text.length > 0) ? MBProgressHUDModeText : MBProgressHUDModeIndeterminate;
        [QQingUtils sharedQQingUtils].progressHUD.removeFromSuperViewOnHide = YES;
        [QQingUtils sharedQQingUtils].progressHUD.square = !(text.length > 0);
        [QQingUtils sharedQQingUtils].progressHUD.dimBackground = YES;
        [QQingUtils sharedQQingUtils].progressHUD.userInteractionEnabled = YES;
        
        [[QQingUtils sharedQQingUtils].progressHUD show:YES];
        
        [[GCDQueue mainQueue] queueBlock:^{
            [[QQingUtils sharedQQingUtils].progressHUD setNeedsDisplay];;
        }];
    }
    
    return [QQingUtils sharedQQingUtils].progressHUD;
}

+ (void)hideProgressHUDWithAnimated:(BOOL)animated {
    if ([NSThread isMainThread]) {
        [[QQingUtils sharedQQingUtils].progressHUD hide:animated];
    } else {
        [[GCDQueue mainQueue] queueBlock:^{
            [[QQingUtils sharedQQingUtils].progressHUD hide:animated];
        }];
    }
}

+ (void)hideProgressHUD {
    if ([NSThread isMainThread]) {
        [[QQingUtils sharedQQingUtils].progressHUD hide:YES];
    } else {
        [[GCDQueue mainQueue] queueBlock:^{
            [[QQingUtils sharedQQingUtils].progressHUD hide:YES];
        }];
    }
}

// Toast
+ (void)showToastWithText:(NSString *)text {
    [QQingUtils showToastWithText:text withImageName:nil blockUI:YES];
}

+ (void)showToastWithText:(NSString *)text withImageName:(NSString *)imageName blockUI:(BOOL)needBlockUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 方案一：使用MBProgressHUD
        [[QQingUtils sharedQQingUtils].progressHUDForToast hide:NO];
        if ([[UIApplication sharedApplication] keyWindow]) {
            [QQingUtils sharedQQingUtils].progressHUDForToast = [[MBProgressHUD alloc] initWithWindow:[[UIApplication sharedApplication] keyWindow]];
            
            // Full screen show.
            [[[UIApplication sharedApplication] keyWindow] addSubview:[QQingUtils sharedQQingUtils].progressHUDForToast];
            [[QQingUtils sharedQQingUtils].progressHUDForToast bringToFront];
            
            [QQingUtils sharedQQingUtils].progressHUDForToast.labelText = text;
            if (([imageName length] > 0) && [UIImage imageNamed:imageName]) {
                [QQingUtils sharedQQingUtils].progressHUDForToast.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
                [QQingUtils sharedQQingUtils].progressHUDForToast.mode = MBProgressHUDModeCustomView;
            } else {
                [QQingUtils sharedQQingUtils].progressHUDForToast.mode = text.length > 0 ? MBProgressHUDModeText : MBProgressHUDModeIndeterminate;
                [QQingUtils sharedQQingUtils].progressHUDForToast.square = !(text.length > 0);
            }

            [QQingUtils sharedQQingUtils].progressHUDForToast.removeFromSuperViewOnHide = YES;
            [QQingUtils sharedQQingUtils].progressHUDForToast.dimBackground = needBlockUI;
            [QQingUtils sharedQQingUtils].progressHUDForToast.userInteractionEnabled = needBlockUI;
            
            [[QQingUtils sharedQQingUtils].progressHUDForToast show:YES];
            
            [[QQingUtils sharedQQingUtils].progressHUDForToast hide:YES afterDelay:1.5];
        }
        
        // 方案二：使用TSMessage
//        [TSMessage setDefaultViewController:[[UIApplication sharedApplication].delegate.window rootViewController]];
//        
//        [TSMessage showNotificationWithTitle:text//NSLocalizedString(@"Tell the user something", nil)
//                                    subtitle:nil//NSLocalizedString(@"This is some neutral notification!", nil)
//                                        type:TSMessageNotificationTypeMessage];
    });
}

// Alert
+ (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message confirmTitle:(NSString*)enterStr {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:enterStr,nil];
    
    [alertView show];
}

+ (UIImage *)screenshotForView:(UIView *)view {
    UIGraphicsBeginImageContext(view.bounds.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // hack, helps w/ our colors when blurring
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    imageData = nil;
    
    return image;
}

@end
