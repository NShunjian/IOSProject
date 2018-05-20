//
//  LMJTabBarController.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CYLTabBarController.h>

@interface LMJTabBarController : NSObject

@property (nonatomic, readonly, strong) CYLTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;


@end
