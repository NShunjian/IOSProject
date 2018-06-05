//
//  SUPTabBarController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPTabBarController.h"
#import "SUPNavigationController.h"
#import "SUPHomeViewController.h"
#import "SUPMessageViewController.h"
#import "SUPMeViewController.h"
#import "SUPNewViewController.h"

@interface SUPTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation SUPTabBarController

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                     tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                               imageInsets:imageInsets
                                                                                   titlePositionAdjustment:titlePositionAdjustment
                                                                                                   context:self.context
                                                  ];
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}


//TabBar文字跟图标设置
- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"功能列表",
                                                 CYLTabBarItemImage : @"tabBar_essence_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"基础",
                                                  CYLTabBarItemImage : @"tabBar_friendTrends_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_friendTrends_click_icon",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"实用技术",
                                                 CYLTabBarItemImage : @"tabBar_new_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_new_click_icon",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"分享登录",
                                                  CYLTabBarItemImage : @"tabBar_me_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_me_click_icon"
                                                  };

    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}


//控制器设置
- (NSArray *)viewControllers {
    UIViewController *one = [[SUPNavigationController alloc] initWithRootViewController:[[SUPHomeViewController alloc] init]];

    UIViewController *two = [[SUPNavigationController alloc] initWithRootViewController:[[SUPNewViewController alloc] init]];

    UIViewController *three = [[SUPNavigationController alloc] initWithRootViewController:[[SUPMessageViewController alloc] init]];

    UIViewController *four = [[SUPNavigationController alloc] initWithRootViewController:[[SUPMeViewController alloc] init]];

    NSArray *viewControllers = @[
                                 three,two,one,four
                                 ];
    
    return viewControllers;
}














/*         ************************* 另外一种写法 这种写法不好添加中间的加号按钮******************************
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor redColor];
    [self setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, -3)] forKeyPath:SUPKeyPath(self, titlePositionAdjustment)];
    [self addTabarItems];
    [self addChildViewControllers];
    [MBProgressHUD showMessage:@"正在登录中.........." ToView:self.view RemainTime:1];
    self.delegate = self;
}


- (void)addChildViewControllers
{
    SUPNavigationController *one = [[SUPNavigationController alloc] initWithRootViewController:[[SUPHomeViewController alloc] init]];
    
    SUPNavigationController *two = [[SUPNavigationController alloc] initWithRootViewController:[[SUPNewViewController alloc] init]];

    SUPNavigationController *three = [[SUPNavigationController alloc] initWithRootViewController:[[SUPMessageViewController alloc] init]];

    SUPNavigationController *four = [[SUPNavigationController alloc] initWithRootViewController:[[SUPMeViewController alloc] init]];
    self.viewControllers = @[three,two,one,four];
    
}

- (void)addTabarItems
{
    
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"基础",
                                                 CYLTabBarItemImage : @"tabBar_essence_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"功能",
                                                 CYLTabBarItemImage : @"tabBar_friendTrends_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_friendTrends_click_icon",
                                                 };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"其他",
                                                 CYLTabBarItemImage : @"tabBar_new_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_new_click_icon",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"分享登录",
                                                  CYLTabBarItemImage : @"tabBar_me_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_me_click_icon"
                                                  };
    
    self.tabBarItemsAttributes = @[
                                       thirdTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       firstTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

*/
@end
