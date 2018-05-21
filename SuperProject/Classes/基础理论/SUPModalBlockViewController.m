//
//  SUPModalBlockViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPModalBlockViewController.h"

@interface SUPModalBlockViewController ()

@end

@implementation SUPModalBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        !self.successBlock ?: self.successBlock();
        
    });
}

@end
