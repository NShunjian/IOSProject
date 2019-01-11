//
//  SUPPublicViewController.m
//  不得姐
//

//  Copyright © 2016年 cui. All rights reserved.
//

#import "SUPPublicViewController.h"
#import "SUPVersionButton.h"
#import <POP.h>
static CGFloat const XMGAnimationDelay = 0.1;
static CGFloat const XMGSpringFactor = 10;

@interface SUPPublicViewController ()
@property (weak, nonatomic) UIImageView *sloganImageView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *publishButtons;
@end

@implementation SUPPublicViewController
- (UIImageView *)sloganImageView
{
    if(_sloganImageView == nil)
    {
        UIImageView *sloganImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
//        sloganImageView.backgroundColor = [UIColor redColor];
        sloganImageView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
        [self.view addSubview:sloganImageView];
        _sloganImageView = sloganImageView;
        
        
        [sloganImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.offset(0);
            
            make.top.offset(self.view.SUP_height * 0.2);
            
        }];
        
    }
    return _sloganImageView;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self publicBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self publicButtons];
}
-(void)publicBtn
{
    //这是第二种方法
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.sloganImageView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [self publishButtons];
    }];
}
//这是第一种方法
-(void)publicButtons{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (SUPScreenHeight - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (SUPScreenWidth - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        SUPVersionButton *button = [[SUPVersionButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - SUPScreenHeight;
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = XMGSpringFactor;
        anim.springSpeed = XMGSpringFactor;
        anim.beginTime = CACurrentMediaTime() + XMGAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    // 标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = SUPScreenWidth * 0.5;
    CGFloat centerEndY = SUPScreenHeight * 0.2;
    CGFloat centerBeginY = centerEndY - SUPScreenHeight;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * XMGAnimationDelay;
    anim.springBounciness = XMGSpringFactor;
    anim.springSpeed = XMGSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
}
- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            SUPLog(@"发视频");
        } else if (button.tag == 1) {
            SUPLog(@"发图片");
        }
    }];
}
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + SUPScreenHeight;
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * XMGAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}
//- (NSMutableArray<UIButton *> *)publishButtons
//{
//    if(_publishButtons == nil)
//    {
//        //列数
//        NSInteger colNum = 3;
//
//        // 数据
//        NSArray<NSString *> *imageStrs = @[@"publish-audio", @"publish-offline", @"publish-picture", @"publish-review", @"publish-text", @"publish-video"];
//
//        NSArray<NSString *> *titles = @[@"发声音", @"离线下载", @"发图片", @"审帖", @"发段子", @"发视频"];
//        CGFloat buttonW = 72;
//        CGFloat buttonH = buttonW + 30;
//        CGFloat buttonStartX = 20;
//        CGFloat buttonStartY = ([UIScreen mainScreen].bounds.size.height - 2*buttonH)/2;
//        CGFloat buttonMargin = ([UIScreen mainScreen].bounds.size.width - 3*buttonW - 2*buttonStartX)/2;
//
//
//
//        NSMutableArray<UIButton *> *publishButtons = [NSMutableArray array];
//        _publishButtons = publishButtons;
//
//        [imageStrs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            SUPVersionButton *button = [[SUPVersionButton alloc]init];
//            button.tag = idx;
//            [self.view addSubview:button];
//            NSInteger row = idx/colNum;
//            NSInteger col = idx%colNum;
//            CGFloat buttonX = buttonStartX + col*(buttonMargin + buttonW);
//            CGFloat buttonEndY = buttonStartY + row*buttonH;
//            CGFloat buttonStartY = buttonEndY - [UIScreen mainScreen].bounds.size.height;
//
//            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
//
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            button.titleLabel.font = [UIFont systemFontOfSize:12];
//            [button setTitle:titles[idx] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
//
//            //创建pop动画
//            POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
//            ani.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonStartY, buttonW, buttonH)];
//            ani.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
//            ani.springBounciness = 10;
//            ani.springSpeed = 10;
//            ani.beginTime = CACurrentMediaTime() + 0.1*idx;
//            [button pop_addAnimation:ani forKey:nil];
//        }];
//         }
//    return _publishButtons;
//}
- (IBAction)CancleButtonClick {
    
//    [self canCle:nil];
    [self cancelWithCompletionBlock:nil];
}

//-(void)clickButton:(UIButton*)button{
//
//    [self canCle:^{
//        if (button.tag == 0) {
//
//            NSLog(@"=========");
//        }
//    }];
//
//}

//-(void)canCle:(void(^)())complent{
//
//
//    for (NSInteger i = 2; i<self.view.subviews.count; i++) {
//
//        UIView *subView = self.view.subviews[i];
//
//        POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//        CGFloat y = subView.centerY + [UIScreen mainScreen].bounds.size.height;
//
//        ani.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, y)];
//        ani.beginTime = CACurrentMediaTime() + 0.1*(i-2);
//        [subView pop_addAnimation:ani forKey:nil];
//        if (i == self.view.subviews.count-1) {
//            [ani setCompletionBlock:^(POPAnimation *ani, BOOL fish) {
//                [self dismissViewControllerAnimated:NO completion:nil];
//
//
//
//                !complent ? : complent();
//            }];
//
//
//
//        }
//
//
//    }
//
//
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [self canCle:nil];
    [self cancelWithCompletionBlock:nil];
}
@end
