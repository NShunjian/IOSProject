//
//  LMJIntroductoryPagesHelper.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJIntroductoryPagesHelper.h"
#import "LMJIntroductoryPagesView.h"

@interface LMJIntroductoryPagesHelper ()

@property (weak, nonatomic) UIWindow *curWindow;

@property (strong, nonatomic) LMJIntroductoryPagesView *curIntroductoryPagesView;

@end

@implementation LMJIntroductoryPagesHelper

+ (instancetype)shareInstance
{
    static LMJIntroductoryPagesHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[LMJIntroductoryPagesHelper alloc] init];
    });
    
    return shareInstance;
}

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray
{
    if (![LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView = [LMJIntroductoryPagesView pagesViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) images:imageArray];
    }
    
    [LMJIntroductoryPagesHelper shareInstance].curWindow = [UIApplication sharedApplication].keyWindow;
    [[LMJIntroductoryPagesHelper shareInstance].curWindow addSubview:[LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
}

@end
