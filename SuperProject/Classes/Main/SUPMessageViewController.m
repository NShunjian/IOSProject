//
//  SUPMessageViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPMessageViewController.h"
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
    self.navigationItem.title = @"功能实例";
    
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.SUP_height;
    self.tableView.contentInset = edgeInsets;
    
    
//    SUPWordItem *item0 = [SUPWordItem itemWithTitle:@"" subTitle: @"BSJ"];
//    [item0 setItemOperation:^(NSIndexPath *indexPath){
//        [weakself presentViewController:[[BSJTabBarController alloc] init] animated:YES completion:nil];
//    }];

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
//
//    [self.sections addObject:section0];
    
    
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



@end
