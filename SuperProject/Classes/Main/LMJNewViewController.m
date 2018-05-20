//  LMJNewViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJNewViewController.h"
#import "LMJAddressPickerViewController.h"
#import "LMJNoNavBarViewController.h"
#import "LMJAdaptFontViewController.h"
#import "LMJBlankPageViewController.h"
#import "LMJAnimationNavBarViewController.h"
#import "LMJYYTextViewController.h"
#import "LMJListExpandHideViewController.h"
#import "LMJElementsCollectionViewController.h"
#import "LMJVerticalLayoutViewController.h"
#import "LMJHorizontalLayoutViewController.h"
#import "LMJKeyboardHandleViewController.h"
#import "LMJDownLoadFileViewController.h"
#import "LMJMasonryViewController.h"
#import "LMJBaiduMapViewController.h"
#import "PoiSearchDemoViewController.h"
#import "LMJQRCodeViewController.h"
#import "LMJUpLoadImagesViewController.h"
#import "LMJUpLoadProgressViewController.h"
#import "LMJListTimerCountDownViewController.h"
#import "LMJH5_OCViewController.h"
#import "LMJAlertViewsViewController.h"
#import "LMJFillTableFormViewController.h"
////#import "LMJFaceRecognizeViewController.h"
#import "LMJTableSDWebImageViewController.h"
#import "LMJDragTableViewController.h"
#import "LMJCalendarViewController.h"
#import "LMJNavBarFadeViewController.h"
#import "LMJFingerCheckViewController.h"



@interface LMJNewViewController ()
@property (weak, nonatomic) UILabel *backBtn;
@end

@implementation LMJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor whiteColor];

    [self.navigationController.tabBarItem setBadgeColor:[UIColor RandomColor]];
    
    [self.navigationController.tabBarItem setBadgeValue:@"2"];

    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.lmj_height;
    self.tableView.contentInset = edgeInsets;
//    LMJWordArrowItem *item0 = [LMJWordArrowItem itemWithTitle:@"占位" subTitle: nil];
//    item0.destVc = [LMJLoggerViewController class];

    LMJWordArrowItem *item1 = [LMJWordArrowItem itemWithTitle:@"省市区三级联动" subTitle: nil];

    item1.destVc = [LMJAddressPickerViewController class];

    LMJWordArrowItem *item2 = [LMJWordArrowItem itemWithTitle:@"没有导航栏全局返回(侧滑)" subTitle: nil];

    item2.destVc = [LMJNoNavBarViewController class];

    LMJWordArrowItem *item3 = [LMJWordArrowItem itemWithTitle:@"字体适配屏幕" subTitle: nil];

    item3.destVc = [ LMJAdaptFontViewController class];

    LMJWordArrowItem *item4 = [LMJWordArrowItem itemWithTitle:@"空白页展示" subTitle: nil];

    item4.destVc = [LMJBlankPageViewController class];

    LMJWordArrowItem *item5 = [LMJWordArrowItem itemWithTitle:@"导航条颜色或者高度渐变" subTitle: nil];

    item5.destVc = [LMJAnimationNavBarViewController class];

    LMJWordArrowItem *item6 = [LMJWordArrowItem itemWithTitle:@"关于 YYText 使用" subTitle: nil];

    item6.destVc = [LMJYYTextViewController class];

    LMJWordArrowItem *item7 = [LMJWordArrowItem itemWithTitle:@"列表的展开和收起" subTitle: nil];

    item7.destVc = [LMJListExpandHideViewController class];

    LMJWordArrowItem *item8 = [LMJWordArrowItem itemWithTitle:@"App首页 CollectionView 布局" subTitle: nil];

    item8.destVc = [LMJElementsCollectionViewController class];

    LMJWordArrowItem *item9 = [LMJWordArrowItem itemWithTitle:@"垂直流水布局" subTitle: nil];

    item9.destVc = [LMJVerticalLayoutViewController class];


    LMJWordArrowItem *item10 = [LMJWordArrowItem itemWithTitle:@"水平流水布局" subTitle: nil];

    item10.destVc = [LMJHorizontalLayoutViewController class];

    LMJWordArrowItem *item11 = [LMJWordArrowItem itemWithTitle:@"键盘处理" subTitle: nil];

    item11.destVc = [LMJKeyboardHandleViewController class];

    LMJWordArrowItem *item12 = [LMJWordArrowItem itemWithTitle:@"文件下载" subTitle: nil];

    item12.destVc = [LMJDownLoadFileViewController class];

    LMJWordArrowItem *item13 = [LMJWordArrowItem itemWithTitle:@"Masonry 布局实例" subTitle: nil];

    item13.destVc = [LMJMasonryViewController class];

    LMJWordArrowItem *item15 = [LMJWordArrowItem itemWithTitle:@"百度地图" subTitle: nil];

    item15.destVc = [LMJBaiduMapViewController class];
    
    LMJWordArrowItem *item = [LMJWordArrowItem itemWithTitle:@"POI搜索" subTitle:nil];
    
    item.destVc = [PoiSearchDemoViewController class];
    
    LMJWordArrowItem *item16 = [LMJWordArrowItem itemWithTitle:@"二维码" subTitle: nil];

    item16.destVc = [LMJQRCodeViewController class];

    LMJWordArrowItem *item17 = [LMJWordArrowItem itemWithTitle:@"照片上传" subTitle: nil];

    item17.destVc = [LMJUpLoadImagesViewController class];

    LMJWordArrowItem *item18 = [LMJWordArrowItem itemWithTitle:@"照片上传有进度" subTitle: nil];

    item18.destVc = [LMJUpLoadProgressViewController class];


    LMJWordArrowItem *item19 = [LMJWordArrowItem itemWithTitle:@"列表倒计时" subTitle: nil];

    item19.destVc = [LMJListTimerCountDownViewController class];

    LMJWordArrowItem *item20 = [LMJWordArrowItem itemWithTitle:@"H5和 OC 交互" subTitle: nil];

    item20.destVc = [LMJH5_OCViewController class];

    LMJWordArrowItem *item21 = [LMJWordArrowItem itemWithTitle:@"自定义各种弹框" subTitle: nil];

    item21.destVc = [LMJAlertViewsViewController class];

    LMJWordArrowItem *item22 = [LMJWordArrowItem itemWithTitle:@"常见表单类型" subTitle: nil];

    item22.destVc = [LMJFillTableFormViewController class];

//    LMJWordArrowItem *item23 = [LMJWordArrowItem itemWithTitle:@"人脸识别" subTitle: nil];
//    item23.destVc = [LMJFaceRecognizeViewController class];

    LMJWordArrowItem *item24 = [LMJWordArrowItem itemWithTitle:@"列表加载图片" subTitle: @"SDWebImage"];

    item24.destVc = [LMJTableSDWebImageViewController class];

    LMJWordArrowItem *item25 = [LMJWordArrowItem itemWithTitle:@"列表拖拽" subTitle: @""];

    item25.destVc = [LMJDragTableViewController class];

    LMJWordArrowItem *item26 = [LMJWordArrowItem itemWithTitle:@"日历操作" subTitle: @""];

    item26.destVc = [LMJCalendarViewController class];

    LMJWordArrowItem *item27 = [LMJWordArrowItem itemWithTitle:@"导航条渐变" subTitle: @""];

    item27.destVc = [LMJNavBarFadeViewController class];

    LMJWordArrowItem *item28 = [LMJWordArrowItem itemWithTitle:@"指纹解锁" subTitle: @""];

    item28.destVc = [LMJFingerCheckViewController class];

    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12,item13,item15,item,item16,item17,item18,item19,item20,item21,item22,item24,item25,item26,item27,item28] andHeaderTitle:@"静态单元格的头部标题" footerTitle:@"静态单元格的尾部标题"];
    
    NSLog(@"%lu",(unsigned long)section0.items.count);
    //弹出提示
    [self showNewStatusesCount:section0.items.count];
    
    [self.sections addObject:section0];
    [self backBtn];
}



#pragma mark 重写BaseViewController设置内容

- (UIColor *)lmjNavigationBackgroundColor:(LMJNavigationBar *)navigationBar
{
    return [UIColor whiteColor];
}
- (BOOL)lmjNavigationIsHideBottomLine:(LMJNavigationBar *)navigationBar
{
    return NO;
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

- (void)titleClickEvent:(UILabel *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    NSLog(@"%@", sender);
}

- (NSMutableAttributedString*)lmjNavigationBarTitle:(LMJNavigationBar *)navigationBar
{
    return [self changeTitle:@"自定义导航栏 View"];
}


- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LMJNavigationBar *)navigationBar
{
    [leftButton setTitle:@"左边" forState: UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    return nil;
}


- (UIImage *)lmjNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(LMJNavigationBar *)navigationBar
{
    rightButton.backgroundColor = [UIColor redColor];
    [rightButton setTitle:@"右边" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    return nil;
}



#pragma mark 自定义代码

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];
    
    return title;
}


- (void)showNewStatusesCount:(NSInteger)count
{
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    
    // 2.显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%ld条实例数据", count];
    } else {
        label.text = @"没有最新的数据";
    }
    
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithRed:254/255.0  green:129/255.0 blue:0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.frame.size.width;
    label.height = 35;
    label.lmj_x = 0;
    label.lmj_y = CGRectGetMaxY([self.navigationController navigationBar].frame) - label.frame.size.height;
    
    // 5.添加到导航控制器的view
    //[self.navigationController.view addSubview:label];
    [self.view insertSubview:label belowSubview:self.lmj_navgationBar];
    
    // 6.动画
    CGFloat duration = 0.75;
    //label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.frame.size.height);
        //label.alpha = 1.0;
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            //label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
}


- (UILabel *)backBtn
{
    if(_backBtn == nil)
    {
        UILabel *btn = [[UILabel alloc] init];
        btn.text = @"点击返回";
        btn.textAlignment = NSTextAlignmentCenter;
//        btn.font = BOLDSYSTEMFONT(15);
//        btn.textColor = [UIColor blackColor];
//        btn.backgroundColor = RGBA(220, 220, 220,1);
        
        //如果不是加图片就把注释的打开  图片的相关代码注释
        UIImage *img = [UIImage imageNamed:@"image3"];
        NSTextAttachment *textAttach = [[NSTextAttachment alloc]init];
        textAttach.image = img;
        textAttach.bounds = CGRectMake(0, 0, 70, 70);
        NSAttributedString * strA =[NSAttributedString attributedStringWithAttachment:textAttach];
        btn.attributedText = strA;
        
//        btn.layer.cornerRadius = 35;
//        btn.layer.borderWidth = 4;
//        btn.layer.masksToBounds = YES;
        btn.userInteractionEnabled = YES;
//        [btn sizeToFit];
        [btn setFrame:CGRectMake(20, 64, 70, 70)];
        
        LMJWeakSelf(self);
        [btn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            if (weakself.presentedViewController) {
                [weakself.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }else{
                 [weakself.navigationController popViewControllerAnimated:YES];
            }
            
        }];
        
        
        LMJWeakSelf(btn);
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
                    
                    weakbtn.mj_x = (weakbtn.
                                    mj_x - Main_Screen_Width / 2) > 0 ? (Main_Screen_Width - weakbtn.lmj_width - 20) : 20;
                    weakbtn.mj_y = weakbtn.mj_y > 80 ? weakbtn.mj_y : 80;
                }];
            }
            
        }]];
        
        
        
        [kKeyWindow addSubview:btn];
        
        _backBtn = btn;
    }
    return _backBtn;
}


@end
