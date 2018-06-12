//
//  BaseBottomPopoverVC.m
//  QQingCommon
//
//  Created by Ben on 16/10/12.
//  Copyright © 2016年 QQingiOSTeam. All rights reserved.
//

#import "BaseBottomPopoverVC.h"
#import "QQingWindowRootViewController.h"

NSMutableArray *g_bottomPopupVCArray;

@interface BaseBottomPopoverVC ()

@property (nonatomic, strong)   UIWindow *window;
@property (nonatomic, strong)   UIWindow *originalKeyWindow;

@property (nonatomic, strong)   UIViewController *rootViewController;
@property (nonatomic, strong)   UIView *backgroundView;

@property (nonatomic, weak)     NSLayoutConstraint *xConstraint;
@property (nonatomic, weak)     NSLayoutConstraint *yConstraint;
@property (nonatomic, weak)     NSLayoutConstraint *widthConstraint;

@property (nonatomic, strong)   UIMotionEffectGroup *motionEffectGroup;
@property (nonatomic, assign)   BOOL hasBeenDismissed;

@end

@implementation BaseBottomPopoverVC

#pragma mark - View life cycle

+ (void)load {
    if (!g_bottomPopupVCArray) {
        g_bottomPopupVCArray = [NSMutableArray array];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addMotionEffects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (UIMotionEffectGroup *)motionEffectGroup {
    if(!_motionEffectGroup) {
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        
        _motionEffectGroup = [UIMotionEffectGroup new];
        _motionEffectGroup.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    }
    
    return _motionEffectGroup;
}

- (UIWindow *)window {
    if (!_window) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.windowLevel = UIWindowLevelStatusBar;
        
        QQingWindowRootViewController *rootViewController = [QQingWindowRootViewController createRootViewControllerWithStatusBarStyle:[UIApplication sharedApplication].statusBarStyle];
        _window.rootViewController = rootViewController;
    }
    
    return _window;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedOnBackgroundView:)];
        [_backgroundView addGestureRecognizer:tapRecognizer];
    }
    
    return _backgroundView;
}

#pragma mark - Private methods

- (void)addMotionEffects {
    [self.view addMotionEffect:self.motionEffectGroup];
}

- (void)removeMotionEffects {
    [self.view removeMotionEffect:self.motionEffectGroup];
}

- (void)addBottomPopoverVC:(BaseBottomPopoverVC *)bottomPopoverVC {
    @synchronized (g_bottomPopupVCArray) {
        [g_bottomPopupVCArray addObject:bottomPopoverVC];
    }
}

- (void)removeBottomPopoverVC:(BaseBottomPopoverVC *)bottomPopoverVC {
    @synchronized (g_bottomPopupVCArray) {
        [g_bottomPopupVCArray removeObject:bottomPopoverVC];
    }
}

#pragma mark - IBActions

- (void)didTappedOnBackgroundView:(UIGestureRecognizer *)sender {
    if(!self.backgroundTapsDisabled && !self.hasBeenDismissed) {
        self.hasBeenDismissed = YES;
        
        [self dismissWithAnimated:YES];
    }
}

#pragma mark - Public methods

- (CGFloat)preferredContentHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? 200 : 300;
}

- (void)showWithAnimated:(BOOL)animated {
    self.rootViewController = self.window.rootViewController;
    
    {
        self.originalKeyWindow = [UIApplication sharedApplication].keyWindow;
        [self.window makeKeyAndVisible];
        
        // If we start in landscape mode also update the windows frame to be accurate
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            self.window.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
        }
    }
    
    {
        self.backgroundView.alpha = 0;
        [self.rootViewController.view addSubview:self.backgroundView];
        
        [self.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
        [self.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    }
    
    [self willMoveToParentViewController:self.rootViewController];
    [self viewWillAppear:YES];
    
    [self.rootViewController addChildViewController:self];
    [self.rootViewController.view addSubview:self.view];
    
    [self viewDidAppear:YES];
    [self didMoveToParentViewController:self.rootViewController];
    
    self.xConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    self.yConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    self.widthConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:[self preferredContentHeight]];
    
    [self.rootViewController.view addConstraint:self.xConstraint];
    [self.rootViewController.view addConstraint:self.yConstraint];
    [self.rootViewController.view addConstraint:self.widthConstraint];
    [self.view addConstraint:self.heightConstraint];
    
    [self.rootViewController.view setNeedsUpdateConstraints];
    [self.rootViewController.view layoutIfNeeded];
    
    [self.rootViewController.view removeConstraint:self.yConstraint];
    self.yConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.rootViewController.view addConstraint:self.yConstraint];
    
    [self.rootViewController.view setNeedsUpdateConstraints];
    
    if (animated) {
        self.view.alpha = 0;
        
        //[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.backgroundView.alpha = 1;
            self.view.alpha = 1;
            
            [self.rootViewController.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self addBottomPopoverVC:self];
        }];
    } else {
        self.backgroundView.alpha = 1;
        self.view.alpha = 1;
        [self.rootViewController.view layoutIfNeeded];
        
        [self addBottomPopoverVC:self];
    }
}

- (void)dismissWithAnimated:(BOOL)animated {
    if (animated) {
        [self.rootViewController.view removeConstraint:self.yConstraint];
        self.yConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self.rootViewController.view addConstraint:self.yConstraint];
        
        [self.rootViewController.view setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.backgroundView.alpha = 0;
            self.view.alpha = 0;
            
            [self.rootViewController.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self willMoveToParentViewController:nil];
            [self viewWillDisappear:YES];
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
            [self didMoveToParentViewController:nil];
            [self viewDidDisappear:YES];
            
            [self.backgroundView removeFromSuperview];
            [self.window resignKeyWindow];
            [self.originalKeyWindow makeKeyAndVisible];
            self.window = nil;
            [self removeBottomPopoverVC:self];
            self.hasBeenDismissed = NO;
        }];
    } else {
        [self willMoveToParentViewController:nil];
        [self viewWillDisappear:YES];
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        [self viewDidDisappear:YES];
        
        [self.backgroundView removeFromSuperview];
        [self.window resignKeyWindow];
        [self.originalKeyWindow makeKeyAndVisible];
        self.window = nil;
        [self removeBottomPopoverVC:self];
        self.hasBeenDismissed = NO;
    }
}

@end


