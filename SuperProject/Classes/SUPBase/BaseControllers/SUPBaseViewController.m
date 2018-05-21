//
//  LSUPBBaseViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPBaseViewController.h"
#import "SUPUMengHelper.h"

@interface SUPBaseViewController ()



@end

@implementation SUPBaseViewController


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearanceWhenContainedInInstancesOfClasses:@[[SUPBaseViewController class]]] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
//  **************************************************************
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
//    _tableView.scrollIndicatorInsets = _tableView.contentInset;

//  *****************************************************************
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 配置友盟统计
    [SUPUMengHelper beginLogPageViewName:self.title ?: self.navigationItem.title];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 配置友盟统计
    [SUPUMengHelper endLogPageViewName:self.title ?: self.navigationItem.title];

}




- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title.copy;
    }
    
    return self;
}




- (void)dealloc
{
    
    NSLog(@"dealloc---%@", self.class);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end







