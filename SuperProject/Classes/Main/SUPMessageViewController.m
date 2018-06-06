//
//  SUPMessageViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPMessageViewController.h"
#import "UserViewController.h"
#import "JiaMediator.h"
#import "JiaMediator+UserModuleActions.h"
#import "SUPSearchBarViewController.h"
#import "SUPTabBarController.h"
//#import "JiaAlertView.h"
//#import "SINTabBarController.h"
//#import "IMHTabBarController.h"
//#import "MUSHomeListViewController.h"
//#import "VIDTabBarController.h"
@interface SUPMessageViewController ()
/** <#digest#> */
@property (weak, nonatomic) UILabel *backBtn;
@end

@implementation SUPMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SUPWeakSelf(self);
    NSLog(@"%@", weakself);
    self.navigationItem.title = @"请您触摸";
    
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.SUP_height;
    self.tableView.contentInset = edgeInsets;
    
    //监听返回值通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userVCNotification:) name:kUserViewControllerNotificationWithName object:nil];
    
    SUPTabBarController *tabBarControllerConfig = [[SUPTabBarController alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    tabBarController.delegate = self;
    
    SUPWordItem *item0 = [SUPWordItem itemWithTitle:@"MQTT协议实现物联网开发" subTitle: @""];
    [item0 setItemOperation:^(NSIndexPath *indexPath){
        //        [weakself presentViewController:[[BSJTabBarController alloc] init] animated:YES completion:nil];
        [weakself.navigationController pushViewController:[[SUPMQTTViewController alloc]init] animated:NO];
    }];
    
    
    SUPWordItem *item1 = [SUPWordItem itemWithTitle:@"通过模块并通知返回值==值传到上一个页面" subTitle: @">"];
    [item1 setItemOperation:^(NSIndexPath *indexPath){
        
        NSDictionary *userParaDictionary=@{kUserModuleActionsDictionaryKeyID:@"1"};
        
        UIViewController *viewController=[[JiaMediator sharedInstance] JiaMediator_User_viewControllerForDetail:userParaDictionary];
        
        [weakself.navigationController pushViewController:viewController animated:YES];
    }];
    
    
    SUPWordArrowItem *item2 = [SUPWordArrowItem itemWithTitle:@"自定义SearchBar" subTitle:nil];
    item2.destVc = [SUPSearchBarViewController class];
    
    SUPWordItem *item3 = [SUPWordItem itemWithTitle:@"自定义分享模板" subTitle: nil];
    [item3 setItemOperation:^(NSIndexPath *indexPath){
        NSArray *contentArray = @[@{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                                  @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                                  @{@"name":@"QQ",@"icon":@"sns_icon_4"},
                                  @{@"name":@"微信",@"icon":@"sns_icon_7"},
                                  @{@"name":@"朋友圈",@"icon":@"sns_icon_8"},
                                  @{@"name":@"微信收藏",@"icon":@"sns_icon_9"}];
        JiaShareMenuView *shareView = [[JiaShareMenuView alloc] init];
        shareView.rowNumberItem=3;
        shareView.cancelButtonText=@"取消分享";
        [shareView addShareItems:self.view shareItems:contentArray selectShareItem:^(NSInteger tag, NSString *title) {
            NSLog(@"%ld --- %@", tag, title);
        }];
        
    }];
    
    SUPWordItem *item4 = [SUPWordItem itemWithTitle:@"模态弹出+导航模式->设计模块" subTitle: nil];
    NSDictionary *curParams=@{kDesignerModuleActionsDictionaryKeyName:@"wujunyang",kDesignerModuleActionsDictionaryKeyID:@"1001",kDesignerModuleActionsDictionaryKeyImage:@"designerImage"};
    [item4 setItemOperation:^(NSIndexPath *indexPath){
        //模态方式
//        UIViewController *viewController=[[JiaMediator sharedInstance]JiaMediator_Designer_viewControllerForDetail:curParams];
//        [weakself presentViewController:viewController animated:YES completion:nil];
        
        //导航模式
        UIViewController *viewController=[[JiaMediator sharedInstance]JiaMediator_Designer_viewControllerForDetail:curParams];
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
    
    SUPWordItem *item5 = [SUPWordItem itemWithTitle:@"WebViewJS与OC交互" subTitle: @""];
    [item5 setItemOperation:^(NSIndexPath *indexPath){
        
        [weakself.navigationController pushViewController:[[SUPOCandJSViewController alloc]init] animated:NO];
    }];
    SUPWordItem *item6 = [SUPWordItem itemWithTitle:@"WKWebViewjs与oc交互" subTitle: @""];
    [item6 setItemOperation:^(NSIndexPath *indexPath){
        
        [weakself.navigationController pushViewController:[[SUPWKViewController alloc]init] animated:NO];
    }];
    
    
    SUPItemSection *section0 = [SUPItemSection sectionWithItems:@[item0,item1,item2,item3,item4,item5,item6] andHeaderTitle:nil footerTitle:nil];
    
    [self.sections addObject:section0];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    //    SUPWordItem *item1 = [SUPWordItem itemWithTitle:@"SIN" subTitle: @"新浪微博"];
    //    [item1 setItemOperation:^(NSIndexPath *indexPath){
    //        [weakself presentViewController:[[SINTabBarController alloc] init] animated:YES completion:nil];
    //    }];
    //
    
    
    //    SUPWordItem *item2 = [SUPWordItem itemWithTitle:@"IM_HX" subTitle: @"环信聊天"];
    //    [item2 setItemOperation:^(NSIndexPath *indexPath){
    //        [weakself presentViewController:[[IMHTabBarController alloc] init] animated:YES completion:nil];
    //    }];
    
    
    
    //    SUPWordItem *item3 = [SUPWordItem itemWithTitle:@"Musics" subTitle: @"QQ音乐"];
    //    [item3 setItemOperation:^(NSIndexPath *indexPath){
    //        [weakself presentViewController:[[SUPNavigationController alloc] initWithRootViewController:[[MUSHomeListViewController alloc] init]] animated:YES completion:nil];
    //    }];
    //
    //
    //
    //    SUPWordItem *item4 = [SUPWordItem itemWithTitle:@"Videos" subTitle: @"列表视频"];
    //    [item4 setItemOperation:^(NSIndexPath *indexPath){
    //        [weakself presentViewController:[[VIDTabBarController alloc] init] animated:YES completion:nil];
    //    }];
    
    
    
    //    SUPItemSection *section0 = [SUPItemSection sectionWithItems:@[item0] andHeaderTitle:nil footerTitle:nil];
    
    //    [self.sections addObject:section0];
    
    
}

#pragma mark - Events

- (void)userVCNotification:(NSNotification *)dic{
    NSDictionary *infoDic=(NSDictionary *)dic.userInfo;
    NSLog(@"－－－－－接收到通知返回------");
    
    NSLog(@"内容为：%@",infoDic);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"回调回来的参数" message:[NSString stringWithFormat:@"内容为：%@",infoDic] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

/**
 *  加载控制器的时候设置打开抽屉模式  (因为在后面会关闭)
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.backBtn.hidden = !self.presentedViewController;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.backBtn.hidden = !self.presentedViewController;
}

- (UILabel *)backBtn
{
    if(_backBtn == nil)
    {
        UILabel *btn = [[UILabel alloc] init];
        btn.text = @"点击返回";
        btn.font = AdaptedFontSize(10);
        btn.textColor = [UIColor whiteColor];
        btn.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];;
        btn.textAlignment = NSTextAlignmentCenter;
        btn.userInteractionEnabled = YES;
        [btn sizeToFit];
        [btn setFrame:CGRectMake(20, 100, btn.SUP_width + 20, 30)];
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;
        
        SUPWeakSelf(self);
        [btn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            
            if (weakself.presentedViewController) {
                [weakself.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }
            
        }];
        
        
        SUPWeakSelf(btn);
        [btn addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithActionBlock:^(UIPanGestureRecognizer  *_Nonnull sender) {
            
            //            NSLog(@"%@", sender);
            
            // 获取手势的触摸点
            // CGPoint curP = [pan locationInView:self.imageView];
            
            // 移动视图
            // 获取手势的移动，也是相对于最开始的位置
            CGPoint transP = [sender translationInView:weakbtn];
            
            weakbtn.transform = CGAffineTransformTranslate(weakbtn.transform, transP.x, transP.y);
            
            // 复位
            [sender setTranslation:CGPointZero inView:weakbtn];
            
            if (sender.state == UIGestureRecognizerStateEnded) {
                
                [UIView animateWithDuration:0.2 animations:^{
                    
                    weakbtn.SUP_x = (weakbtn.SUP_x - kScreenWidth / 2) > 0 ? (kScreenWidth - weakbtn.SUP_width - 20) : 20;
                    weakbtn.SUP_y = weakbtn.SUP_y > 80 ? weakbtn.SUP_y : 80;
                }];
            }
            
        }]];
        
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:btn];
        
        _backBtn = btn;
    }
    return _backBtn;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/** 导航条左边的按钮 */
- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [leftButton setTitle:@"点击核心动画" forState:UIControlStateNormal];
    leftButton.SUP_width = 120;
     [leftButton setTitleColor:[UIColor RandomColor] forState:UIControlStateNormal];
    return nil;
}
/** 导航条右边的按钮 */
- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [rightButton setTitle:@"点击右侧菜单栏" forState:UIControlStateNormal];
    rightButton.SUP_width = 120;
    [rightButton setTitleColor:[UIColor RandomColor] forState:UIControlStateNormal];
    return nil;
}



#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
#pragma mark -实现侧滑...
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    NSLog(@"%s", __func__);
}
//触摸屏幕跳转到对应索引的tabbarItem  (在这里可以触摸 导航标题)
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cyl_popSelectTabBarChildViewControllerAtIndex:3 completion:^(__kindof UIViewController *selectedTabBarChildViewController) {
        NSLog(@"%@",selectedTabBarChildViewController);
       
    }];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UIViewController *viewController_ = [viewController  cyl_getViewControllerInsteadOfNavigationController];
    [[viewController_ cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

@end

