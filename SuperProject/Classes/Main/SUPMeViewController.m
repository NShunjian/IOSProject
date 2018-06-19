//
//  SUPMeViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPMeViewController.h"
#import "SUPUMengHelper.h"
#import "SUPUMeng.h"
#import "SUPRegisterViewController.h"

@interface SUPMeViewController ()

/** <#digest#> */
@property (weak, nonatomic) UIButton *QQLoginBtn;
/** <#digest#> */
@property (weak, nonatomic) UIButton *WXLoginBtn;
/** <#digest#> */
@property (weak, nonatomic) UIButton *SinaLoginBtn;

/** <#digest#> */
@property (weak, nonatomic) UIButton *shareBtn;

@property (nonatomic,weak)UIButton *SMSBtn;

@property(nonatomic,strong) UIView *viewAnima; //装 滚动视图的容器
@property(nonatomic,weak) UILabel *customLab;
@property(nonatomic,strong) NSTimer* timer;// 定义定时器

@end

@implementation SUPMeViewController

#pragma mark viewController生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //关闭抽屉模式
//    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];

}
-(void)dealloc{
    [_timer invalidate];
    _timer=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //*******添加中间标题
    [self addMiddleTitleView];
    // 启动NSTimer定时器来改变UIImageView的位置
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self selector:@selector(changePos)
                                                userInfo:nil repeats:YES];

    NSArray<UIButton *> *btns = @[self.shareBtn, self.SinaLoginBtn, self.QQLoginBtn, self.WXLoginBtn,self.SMSBtn];
    
    [btns mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:44 leadSpacing:150 tailSpacing:200];
    
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.right.offset(-50);
    }];
}

/**
 *  多个控件固定间隔的等间隔排列，变化的是控件的长度或者宽度值
 *
 *  @param axisType        轴线方向
 *  @param fixedSpacing    间隔大小
 *  @param leadSpacing     头部间隔
 *  @param tailSpacing     尾部间隔
 */
//- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType
//                    withFixedSpacing:(CGFloat)fixedSpacing l
//eadSpacing:(CGFloat)leadSpacing
//tailSpacing:(CGFloat)tailSpacing;

/**
 *  多个固定大小的控件的等间隔排列,变化的是间隔的空隙
 *
 *  @param axisType        轴线方向
 *  @param fixedItemLength 每个控件的固定长度或者宽度值
 *  @param leadSpacing     头部间隔
 *  @param tailSpacing     尾部间隔
 */
//- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType
//                 withFixedItemLength:(CGFloat)fixedItemLength
//                         leadSpacing:(CGFloat)leadSpacing
//                         tailSpacing:(CGFloat)tailSpacing;



#pragma mark - 登录
- (void)thirdLoginClick:(UIButton *)loginBtn
{
    
    NSInteger tag = loginBtn.tag;

    UMSocialPlatformType type = UMSocialPlatformType_UnKnown;

    switch (tag) {
        case 1:

            type = UMSocialPlatformType_QQ;

            break;

        case 2:

            type = UMSocialPlatformType_WechatSession;

            break;


        case 3:

            type = UMSocialPlatformType_Sina;

            break;


        default:

            return;

            break;
    }
    
    
    [SUPUMengHelper getUserInfoForPlatform:type completion:^(UMSocialUserInfoResponse *result, NSError *error) {

        NSLog(@"result ==== %@", result);

    }];

}



#pragma mark - 懒加载
- (UIButton *)QQLoginBtn
{
    if(_QQLoginBtn == nil)
    {
        UIButton *loginBtn = [[UIButton alloc] init];
        [loginBtn setTitle:@"QQLogin" forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        loginBtn.tag = 1;
        [loginBtn addTarget:self action:@selector(thirdLoginClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:loginBtn];
        
        
        loginBtn.titleLabel.font = AdaptedFontSize(20);
        
        [loginBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        _QQLoginBtn = loginBtn;
        
    }
    return _QQLoginBtn;
}

- (UIButton *)WXLoginBtn
{
    if(_WXLoginBtn == nil)
    {
        UIButton *loginBtn = [[UIButton alloc] init];
        [loginBtn setTitle:@"WXLogin" forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        loginBtn.tag = 2;
        [loginBtn addTarget:self action:@selector(thirdLoginClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:loginBtn];
        
        loginBtn.titleLabel.font = AdaptedFontSize(20);
        
        [loginBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        _WXLoginBtn = loginBtn;
    }
    return _WXLoginBtn;
}


- (UIButton *)SinaLoginBtn
{
    if(_SinaLoginBtn == nil)
    {
        UIButton *loginBtn = [[UIButton alloc] init];
        
        [loginBtn setTitle:@"SinaLogin" forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        loginBtn.tag = 3;
        [loginBtn addTarget:self action:@selector(thirdLoginClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:loginBtn];
        
        loginBtn.titleLabel.font = AdaptedFontSize(20);
        
        [loginBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        _SinaLoginBtn = loginBtn;
    }
    return _SinaLoginBtn;
}


- (UIButton *)shareBtn
{
    if(_shareBtn == nil)
    {
        UIButton *loginBtn = [[UIButton alloc] init];
        
        [loginBtn setTitle:@"分享面板" forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        loginBtn.tag = 4;
        [loginBtn addTarget:self action:@selector(rightButtonEvent:navigationBar:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:loginBtn];
        
        loginBtn.titleLabel.font = AdaptedFontSize(20);
        
        [loginBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        _shareBtn = loginBtn;
    }
    return _shareBtn;
}

- (UIButton *)SMSBtn
{
    if(_SMSBtn == nil)
    {
        UIButton *loginBtn = [[UIButton alloc] init];
        [loginBtn setTitle:@"SMS短信" forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
      
        [loginBtn addTarget:self action:@selector(smsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:loginBtn];
        
        
        loginBtn.titleLabel.font = AdaptedFontSize(20);
        
        [loginBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        _SMSBtn = loginBtn;
        
    }
    return _SMSBtn;
}

#pragma mark 短信验证

-(void)smsBtnClick:(UIButton *)loginBtn{
    SUPRegisterViewController *sms = [[SUPRegisterViewController alloc]init];
    [self.navigationController pushViewController:sms animated:YES];
}


#pragma mark 重写BaseViewController设置内容

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%s", __func__);
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    [SUPUMengHelper shareTitle:@"NJHu-GitHub" subTitle:@"谢谢使用!欢迎交流!" thumbImage:@"https://avatars2.githubusercontent.com/u/18454795?s=400&u=c8a7cc691e5c3611e9fb49dcf9c83843dd9141a2&v=4" shareURL:@"https://www.jianshu.com"];
    //加入copy的操作
    //@see http://dev.umeng.com/social/ios/进阶文档#6
//    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_UserDefine_Begin+2
//                                     withPlatformIcon:[UIImage imageNamed:@"cui"]
//                                     withPlatformName:@"哥"];
//
//    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
////#ifdef UM_Swift
////    [UMSocialSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
////#else
//        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
////#endif
//            //在回调里面获得点击的
//            if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
//                NSLog(@"点击演示添加Icon后该做的操作");
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加自定义icon"
//                                                                    message:@"具体操作方法请参考UShareUI内接口文档"
//                                                                   delegate:nil
//                                                          cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                          otherButtonTitles:nil];
//                    [alert show];
//
//                });
//            }
//            else{
//                [self runShareWithType:platformType];
//            }
//        }];
//
}

- (void)runShareWithType:(UMSocialPlatformType)type
{
//    UMShareTypeViewController *VC = [[UMShareTypeViewController alloc] initWithType:type];
//    [self.navigationController pushViewController:VC animated:YES];
}




- (void)titleClickEvent:(UILabel *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%@", sender);
}

//- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar
//{
//    return [self changeTitle:@"友盟分享和第三方登录"];
//}

#pragma mark 自定义代码

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, title.length)];
    
    return title;
}


- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"navigationButtonReturn"];
}



- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
{
    UIButton *btn = rightButton;
    
    btn.backgroundColor = SUPRGBColor(241, 158, 194);

    [btn setTitle:@"分享" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    
    return nil;
}
- (UIView *)SUPNavigationBarTitleView:(SUPNavigationBar *)navigationBar{
    
    return self.viewAnima;
}

//添加中间视图
-(void) addMiddleTitleView
{
    //定义视图大小
    CGFloat viewX = (self.view.frame.size.width-200)/2;
    UIView *viewAnima = [[UIView alloc] initWithFrame:CGRectMake(viewX, 100, 200, 40)];
    viewAnima.backgroundColor = [UIColor  whiteColor];
    self.viewAnima = viewAnima;
    //定义视图容器
    //         [self.view addSubview:viewAnima];
    
    //    self.navigationItem.titleView = self.viewAnima;
    
    
    CGFloat customLabY = (self.viewAnima.frame.size.height - 30)/2;
    UILabel *customLab = [[UILabel alloc] init];
    customLab.frame = CGRectMake(self.viewAnima.frame.size.width, customLabY,SUPScreenWidth, 30);
    [customLab setTextColor:[UIColor redColor]];
    [customLab setText:@"友盟分享和第三方登录,短信(￣▽￣)"];
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.customLab = customLab;
    
    
    
    //添加视图
    [self.viewAnima addSubview:customLab];
}

//其实蝴蝶的整个移动都是————靠iv.center来去设置的
- (void) changePos
{
    CGPoint curPos = self.customLab.center;
//    NSLog(@"curPos.x = %f", curPos.x);
    //根据customLab的长度 判断移动的距离
    // 当curPos的x坐标已经超过了屏幕的宽度
    if(curPos.x < -230)
    {
        CGFloat jianJu = self.customLab.frame.size.width/2;
        // 控制蝴蝶再次从屏幕左侧开始移动
        self.customLab.center = CGPointMake(self.viewAnima.frame.size.width + jianJu, 20);
    }
    else
    {
        // 通过修改iv的center属性来改变iv控件的位置
        self.customLab.center = CGPointMake(curPos.x-4, 20);
    }
    //其实蝴蝶的整个移动都是————靠iv.center来去设置的
}


@end
