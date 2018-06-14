//
//  SUPBaseViewController.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUPNavigationBar.h"
#import "SUPNavigationController.h"

@class SUPNavUIBaseViewController;
@protocol SUPNavUIBaseViewControllerDataSource <NSObject>

@optional
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(SUPNavUIBaseViewController *)navUIBaseViewController;

- (UIStatusBarStyle)navUIBaseViewControllerPreferStatusBarStyle:(SUPNavUIBaseViewController *)navUIBaseViewController;

@end

@interface SUPNavUIBaseViewController : UIViewController <SUPNavigationBarDelegate, SUPNavigationBarDataSource,SUPNavUIBaseViewControllerDataSource>

-(void)changeNavigationBarTranslationY:(CGFloat)translationY;

-(void)changeNavgationTitle:(NSMutableAttributedString *)title;

-(void)changeNavigationBarHeight:(CGFloat)height;

-(void)changeNavgationBarBackgroundColor:(UIColor *)backgroundColor;
-(void)changeNavgationBarBackgroundView:(UIView *)view;
/** <#digest#> */
@property (weak, nonatomic) SUPNavigationBar *SUP_navgationBar;
@end
