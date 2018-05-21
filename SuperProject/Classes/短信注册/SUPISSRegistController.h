//
//  SUPISSRegistController.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPBaseViewController.h"

@interface SUPISSRegistController : SUPBaseViewController
@property(nonatomic, strong)NSString *phoneNum;;

- (instancetype)initWithPhoneNumber:(NSString *)phone zone:(NSString *)zone methodType:(SMSGetCodeMethod)method;


@end
