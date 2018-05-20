//
//  UIView+LMJConfigBlank.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJEasyBlankPageView.h"

@interface UIView (LMJConfigBlank)
- (void)configBlankPage:(LMJEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end
