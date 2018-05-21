//
//  SUPNavigationBar.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SUPNavigationBar;
// 主要处理导航条
@protocol  SUPNavigationBarDataSource<NSObject>

@optional

/**头部标题*/
- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar;

/** 背景图片 */
- (UIImage *)SUPNavigationBarBackgroundImage:(SUPNavigationBar *)navigationBar;
 /** 背景色 */
- (UIColor *)SUPNavigationBackgroundColor:(SUPNavigationBar *)navigationBar;
/** 是否显示底部黑线 */
- (BOOL)SUPNavigationIsHideBottomLine:(SUPNavigationBar *)navigationBar;
/** 导航条的高度 */
- (CGFloat)SUPNavigationHeight:(SUPNavigationBar *)navigationBar;


/** 导航条的左边的 view */
- (UIView *)SUPNavigationBarLeftView:(SUPNavigationBar *)navigationBar;
/** 导航条右边的 view */
- (UIView *)SUPNavigationBarRightView:(SUPNavigationBar *)navigationBar;
/** 导航条中间的 View */
- (UIView *)SUPNavigationBarTitleView:(SUPNavigationBar *)navigationBar;
/** 导航条左边的按钮 */
- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar;
/** 导航条右边的按钮 */
- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar;
@end


@protocol SUPNavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(SUPNavigationBar *)navigationBar;
@end


@interface SUPNavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** <#digest#> */
@property (weak, nonatomic) UIView *titleView;

/** <#digest#> */
@property (weak, nonatomic) UIView *leftView;

/** <#digest#> */
@property (weak, nonatomic) UIView *rightView;

/** <#digest#> */
@property (nonatomic, copy) NSMutableAttributedString *title;

/** <#digest#> */
@property (weak, nonatomic) id<SUPNavigationBarDataSource> dataSource;

/** <#digest#> */
@property (weak, nonatomic) id<SUPNavigationBarDelegate> SUPDelegate;

/** <#digest#> */
@property (weak, nonatomic) UIImage *backgroundImage;

@end
