//
//  LMJAnnotationCustomPopView.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
// 

#import "LMJAnnotationCustomPopView.h"

@interface LMJAnnotationCustomPopView ()

@end

@implementation LMJAnnotationCustomPopView

+ (instancetype)popView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

@end
