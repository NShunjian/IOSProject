//
//  BaseBottomPopoverVC.h
//  QQingCommon
//
//  Created by Ben on 16/10/12.
//  Copyright © 2016年 QQingiOSTeam. All rights reserved.
//

extern NSMutableArray *g_bottomPopupVCArray;

@interface BaseBottomPopoverVC : UIViewController

@property (nonatomic, assign) BOOL backgroundTapsDisabled;

@property (nonatomic, weak) NSLayoutConstraint *heightConstraint; // 只有需要支持旋转的页面，需要访问该属性

// 下面方法可以选择性重写
- (CGFloat)preferredContentHeight;           // 默认为横屏200，竖屏300
- (void)showWithAnimated:(BOOL)animated;
- (void)dismissWithAnimated:(BOOL)animated;
- (void)didTappedOnBackgroundView:(UIGestureRecognizer *)sender;

@end


