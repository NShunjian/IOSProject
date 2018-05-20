//
//  LMJAutoRefreshFooter.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJAutoRefreshFooter.h"

@implementation LMJAutoRefreshFooter

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
    self.automaticallyChangeAlpha = YES;
//    self.automaticallyHidden = YES;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
