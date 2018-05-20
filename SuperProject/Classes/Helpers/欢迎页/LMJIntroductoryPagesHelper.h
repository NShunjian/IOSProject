//
//  LMJIntroductoryPagesHelper.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMJIntroductoryPagesHelper : NSObject

+ (instancetype)shareInstance;

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray;

@end
