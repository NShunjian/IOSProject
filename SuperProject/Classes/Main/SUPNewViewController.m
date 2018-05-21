//  SUPNewViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPNewViewController.h"
#import "SUPAddressPickerViewController.h"
#import "SUPNoNavBarViewController.h"
#import "SUPAdaptFontViewController.h"
#import "SUPBlankPageViewController.h"
#import "SUPAnimationNavBarViewController.h"
#import "SUPYYTextViewController.h"
#import "SUPListExpandHideViewController.h"
#import "SUPElementsCollectionViewController.h"
#import "SUPVerticalLayoutViewController.h"
#import "SUPHorizontalLayoutViewController.h"
#import "SUPKeyboardHandleViewController.h"
#import "SUPDownLoadFileViewController.h"
#import "SUPMasonryViewController.h"
#import "SUPBaiduMapViewController.h"
#import "PoiSearchDemoViewController.h"
#import "SUPQRCodeViewController.h"
#import "SUPUpLoadImagesViewController.h"
#import "SUPUpLoadProgressViewController.h"
#import "SUPListTimerCountDownViewController.h"
#import "SUPH5_OCViewController.h"
#import "SUPAlertViewsViewController.h"
#import "SUPFillTableFormViewController.h"
////#import "SUPFaceRecognizeViewController.h"
#import "SUPTableSDWebImageViewController.h"
#import "SUPDragTableViewController.h"
#import "SUPCalendarViewController.h"
#import "SUPNavBarFadeViewController.h"
#import "SUPFingerCheckViewController.h"



@interface SUPNewViewController ()
@property (weak, nonatomic) UILabel *backBtn;
@end

@implementation SUPNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor whiteColor];

    [self.navigationController.tabBarItem setBadgeColor:[UIColor RandomColor]];
    
    [self.navigationController.tabBarItem setBadgeValue:@"2"];

    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.SUP_height;
    self.tableView.contentInset = edgeInsets;
//    SUPWordArrowItem *item0 = [SUPWordArrowItem itemWithTitle:@"占位" subTitle: nil];
//    item0.destVc = [SUPLoggerViewController class];

    SUPWordArrowItem *item1 = [SUPWordArrowItem itemWithTitle:@"省市区三级联动" subTitle: nil];

    item1.destVc = [SUPAddressPickerViewController class];

    SUPWordArrowItem *item2 = [SUPWordArrowItem itemWithTitle:@"没有导航栏全局返回(侧滑)" subTitle: nil];

    item2.destVc = [SUPNoNavBarViewController class];

    SUPWordArrowItem *item3 = [SUPWordArrowItem itemWithTitle:@"字体适配屏幕" subTitle: nil];

    item3.destVc = [ SUPAdaptFontViewController class];

    SUPWordArrowItem *item4 = [SUPWordArrowItem itemWithTitle:@"空白页展示" subTitle: nil];

    item4.destVc = [SUPBlankPageViewController class];

    SUPWordArrowItem *item5 = [SUPWordArrowItem itemWithTitle:@"导航条颜色或者高度渐变" subTitle: nil];

    item5.destVc = [SUPAnimationNavBarViewController class];

    SUPWordArrowItem *item6 = [SUPWordArrowItem itemWithTitle:@"关于 YYText 使用" subTitle: nil];

    item6.destVc = [SUPYYTextViewController class];

    SUPWordArrowItem *item7 = [SUPWordArrowItem itemWithTitle:@"列表的展开和收起" subTitle: nil];

    item7.destVc = [SUPListExpandHideViewController class];

    SUPWordArrowItem *item8 = [SUPWordArrowItem itemWithTitle:@"App首页 CollectionView 布局" subTitle: nil];

    item8.destVc = [SUPElementsCollectionViewController class];

    SUPWordArrowItem *item9 = [SUPWordArrowItem itemWithTitle:@"垂直流水布局" subTitle: nil];

    item9.destVc = [SUPVerticalLayoutViewController class];


    SUPWordArrowItem *item10 = [SUPWordArrowItem itemWithTitle:@"水平流水布局" subTitle: nil];

    item10.destVc = [SUPHorizontalLayoutViewController class];

    SUPWordArrowItem *item11 = [SUPWordArrowItem itemWithTitle:@"键盘处理" subTitle: nil];

    item11.destVc = [SUPKeyboardHandleViewController class];

    SUPWordArrowItem *item12 = [SUPWordArrowItem itemWithTitle:@"文件下载" subTitle: nil];

    item12.destVc = [SUPDownLoadFileViewController class];

    SUPWordArrowItem *item13 = [SUPWordArrowItem itemWithTitle:@"Masonry 布局实例" subTitle: nil];

    item13.destVc = [SUPMasonryViewController class];

    SUPWordArrowItem *item15 = [SUPWordArrowItem itemWithTitle:@"百度地图" subTitle: nil];

    item15.destVc = [SUPBaiduMapViewController class];
    
    SUPWordArrowItem *item = [SUPWordArrowItem itemWithTitle:@"POI搜索" subTitle:nil];
    
    item.destVc = [PoiSearchDemoViewController class];
    
    SUPWordArrowItem *item16 = [SUPWordArrowItem itemWithTitle:@"二维码" subTitle: nil];

    item16.destVc = [SUPQRCodeViewController class];

    SUPWordArrowItem *item17 = [SUPWordArrowItem itemWithTitle:@"照片上传" subTitle: nil];

    item17.destVc = [SUPUpLoadImagesViewController class];

    SUPWordArrowItem *item18 = [SUPWordArrowItem itemWithTitle:@"照片上传有进度" subTitle: nil];

    item18.destVc = [SUPUpLoadProgressViewController class];


    SUPWordArrowItem *item19 = [SUPWordArrowItem itemWithTitle:@"列表倒计时" subTitle: nil];

    item19.destVc = [SUPListTimerCountDownViewController class];

    SUPWordArrowItem *item20 = [SUPWordArrowItem itemWithTitle:@"H5和 OC 交互" subTitle: nil];

    item20.destVc = [SUPH5_OCViewController class];

    SUPWordArrowItem *item21 = [SUPWordArrowItem itemWithTitle:@"自定义各种弹框" subTitle: nil];

    item21.destVc = [SUPAlertViewsViewController class];

    SUPWordArrowItem *item22 = [SUPWordArrowItem itemWithTitle:@"常见表单类型" subTitle: nil];

    item22.destVc = [SUPFillTableFormViewController class];

//    SUPWordArrowItem *item23 = [SUPWordArrowItem itemWithTitle:@"人脸识别" subTitle: nil];
//    item23.destVc = [SUPFaceRecognizeViewController class];

    SUPWordArrowItem *item24 = [SUPWordArrowItem itemWithTitle:@"列表加载图片" subTitle: @"SDWebImage"];

    item24.destVc = [SUPTableSDWebImageViewController class];

    SUPWordArrowItem *item25 = [SUPWordArrowItem itemWithTitle:@"列表拖拽" subTitle: @""];

    item25.destVc = [SUPDragTableViewController class];

    SUPWordArrowItem *item26 = [SUPWordArrowItem itemWithTitle:@"日历操作" subTitle: @""];

    item26.destVc = [SUPCalendarViewController class];

    SUPWordArrowItem *item27 = [SUPWordArrowItem itemWithTitle:@"导航条渐变" subTitle: @""];

    item27.destVc = [SUPNavBarFadeViewController class];

    SUPWordArrowItem *item28 = [SUPWordArrowItem itemWithTitle:@"指纹解锁" subTitle: @""];

    item28.destVc = [SUPFingerCheckViewController class];

    SUPItemSection *section0 = [SUPItemSection sectionWithItems:@[item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12,item13,item15,item,item16,item17,item18,item19,item20,item21,item22,item24,item25,item26,item27,item28] andHeaderTitle:@"静态单元格的头部标题" footerTitle:@"静态单元格的尾部标题"];
    
    NSLog(@"%lu",(unsigned long)section0.items.count);
    //弹出提示
    [self showNewStatusesCount:section0.items.count];
    
    [self.sections addObject:section0];
    [self backBtn];
}



#pragma mark 重写BaseViewController设置内容

- (UIColor *)SUPNavigationBackgroundColor:(SUPNavigationBar *)navigationBar
{
    return [UIColor whiteColor];
}
- (BOOL)SUPNavigationIsHideBottomLine:(SUPNavigationBar *)navigationBar
{
    return NO;
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

- (void)titleClickEvent:(UILabel *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%@", sender);
}

- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar
{
    return [self changeTitle:@"自定义导航栏 View"];
}


- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [leftButton setTitle:@"左边" forState: UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    return nil;
}


- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
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
    label.SUP_x = 0;
    label.SUP_y = CGRectGetMaxY([self.navigationController navigationBar].frame) - label.frame.size.height;
    
    // 5.添加到导航控制器的view
    //[self.navigationController.view addSubview:label];
    [self.view insertSubview:label belowSubview:self.SUP_navgationBar];
    
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
        
        SUPWeakSelf(self);
        [btn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            if (weakself.presentedViewController) {
                [weakself.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }else{
                 [weakself.navigationController popViewControllerAnimated:YES];
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
                    
                    weakbtn.mj_x = (weakbtn.
                                    mj_x - Main_Screen_Width / 2) > 0 ? (Main_Screen_Width - weakbtn.SUP_width - 20) : 20;
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
