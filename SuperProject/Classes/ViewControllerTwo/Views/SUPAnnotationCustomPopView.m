//
//  SUPAnnotationCustomPopView.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
// 

#import "SUPAnnotationCustomPopView.h"

@interface SUPAnnotationCustomPopView ()

@end

@implementation SUPAnnotationCustomPopView

+ (instancetype)popView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

@end
