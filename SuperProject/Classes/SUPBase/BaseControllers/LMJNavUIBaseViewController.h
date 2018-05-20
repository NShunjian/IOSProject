//
//  LMJBaseViewController.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJNavigationBar.h"
#import "LMJNavigationController.h"

@class LMJNavUIBaseViewController;
@protocol LMJNavUIBaseViewControllerDataSource <NSObject>

@optional
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(LMJNavUIBaseViewController *)navUIBaseViewController;

- (UIStatusBarStyle)navUIBaseViewControllerPreferStatusBarStyle:(LMJNavUIBaseViewController *)navUIBaseViewController;

@end

@interface LMJNavUIBaseViewController : UIViewController <LMJNavigationBarDelegate, LMJNavigationBarDataSource,LMJNavUIBaseViewControllerDataSource>

-(void)changeNavigationBarTranslationY:(CGFloat)translationY;

-(void)changeNavgationTitle:(NSMutableAttributedString *)title;

-(void)changeNavigationBarHeight:(CGFloat)height;

-(void)changeNavgationBarBackgroundColor:(UIColor *)backgroundColor;

/** <#digest#> */
@property (weak, nonatomic) LMJNavigationBar *lmj_navgationBar;
@end
