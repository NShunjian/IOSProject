//
//  SUPIntroductoryPagesHelper.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPIntroductoryPagesHelper.h"
#import "SUPIntroductoryPagesView.h"

@interface SUPIntroductoryPagesHelper ()

@property (weak, nonatomic) UIWindow *curWindow;

@property (strong, nonatomic) SUPIntroductoryPagesView *curIntroductoryPagesView;

@end

@implementation SUPIntroductoryPagesHelper

+ (instancetype)shareInstance
{
    static SUPIntroductoryPagesHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[SUPIntroductoryPagesHelper alloc] init];
    });
    
    return shareInstance;
}

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray
{
    if (![SUPIntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [SUPIntroductoryPagesHelper shareInstance].curIntroductoryPagesView = [SUPIntroductoryPagesView pagesViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) images:imageArray];
    }
    
    [SUPIntroductoryPagesHelper shareInstance].curWindow = [UIApplication sharedApplication].keyWindow;
    [[SUPIntroductoryPagesHelper shareInstance].curWindow addSubview:[SUPIntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
}

@end
