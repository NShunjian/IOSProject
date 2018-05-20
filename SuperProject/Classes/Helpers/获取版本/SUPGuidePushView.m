//
//  SUPGuidePushView.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPGuidePushView.h"

@implementation SUPGuidePushView

//与下面的guideView这个方法具有一样的功能获取加载xib
+ (instancetype)guidePushView
{
    return [self loadInstanceFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)setupUIOnce
{
    //    self.layer.anchorPoint =
    
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.frame = newSuperview.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
+ (void)showGuideView
{
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    NSLog(@"======================================%@",sanboxVersion);
    if (![currentVersion isEqualToString:sanboxVersion]) {
        SUPGuidePushView *guideView = [SUPGuidePushView guideView];
        guideView.frame = kKeyWindow.bounds;
        [kKeyWindow addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//与上面的guidePushView这个方法具有一样的功能获取加载xib
+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (IBAction)closeBtnClick:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}



@end
