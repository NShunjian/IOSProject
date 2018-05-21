//
//  SUPBaseViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPNavUIBaseViewController.h"
#import "SUPNavigationBar.h"

@interface SUPNavUIBaseViewController ()



@end

@implementation SUPNavUIBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.SUP_navgationBar.SUP_width = self.view.SUP_width;
    [self.view bringSubviewToFront:self.SUP_navgationBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = [self navUIBaseViewControllerPreferStatusBarStyle:self];
}


#pragma mark - SUPNavUIBaseViewControllerDataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(SUPNavUIBaseViewController *)navUIBaseViewController
{
    return YES;
}


- (UIStatusBarStyle)navUIBaseViewControllerPreferStatusBarStyle:(SUPNavUIBaseViewController *)navUIBaseViewController
{
    return UIStatusBarStyleDefault;
}


#pragma mark - DataSource
/**头部标题*/
- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar
{
    return [self changeTitle:self.title ?: self.navigationItem.title];
}

/** 背景图片 */
//- (UIImage *)SUPNavigationBarBackgroundImage:(SUPNavigationBar *)navigationBar
//{
//
//}

/** 背景色 */
- (UIColor *)SUPNavigationBackgroundColor:(SUPNavigationBar *)navigationBar
{
    return [UIColor whiteColor];
}

/** 是否显示底部黑线 */
//- (BOOL)SUPNavigationIsHideBottomLine:(SUPNavigationBar *)navigationBar
//{
//    return NO;
//}

/** 导航条的高度 */
- (CGFloat)SUPNavigationHeight:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%f",[UIApplication sharedApplication].statusBarFrame.size.height + 44.0);
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}


/** 导航条的左边的 view */
//- (UIView *)SUPNavigationBarLeftView:(SUPNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的 view */
//- (UIView *)SUPNavigationBarRightView:(SUPNavigationBar *)navigationBar
//{
//
//}
/** 导航条中间的 View */
//- (UIView *)SUPNavigationBarTitleView:(SUPNavigationBar *)navigationBar
//{
//
//}
/** 导航条左边的按钮 */
//- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的按钮 */
//- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
//{
//
//}



#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}


#pragma mark 自定义代码

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, title.length)];
    
    return title;
}


- (SUPNavigationBar *)SUP_navgationBar
{
    // 父类控制器必须是导航控制器
    if(!_SUP_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]] && [self navUIBaseViewControllerIsNeedNavBar:self])
    {
        SUPNavigationBar *navigationBar = [[SUPNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        [self.view addSubview:navigationBar];
        _SUP_navgationBar = navigationBar;
        
        navigationBar.dataSource = self;
        navigationBar.SUPDelegate = self;
        
        
    }
    return _SUP_navgationBar;
}



-(void)changeNavigationBarTranslationY:(CGFloat)translationY
{
    self.SUP_navgationBar.transform = CGAffineTransformMakeTranslation(0, translationY);
}

-(void)changeNavgationTitle:(NSMutableAttributedString *)title
{
    self.SUP_navgationBar.title = title;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    self.SUP_navgationBar.title = [self changeTitle:title];
}

-(void)changeNavigationBarHeight:(CGFloat)height
{
    self.SUP_navgationBar.SUP_height = height;
}

-(void)changeNavgationBarBackgroundColor:(UIColor *)backgroundColor
{
    self.SUP_navgationBar.backgroundColor = backgroundColor;
}


@end










