//
//  LMJEasyBlankPageView.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LMJEasyBlankPageViewTypeNoData
} LMJEasyBlankPageViewType;

@interface LMJEasyBlankPageView : UIView

- (void)configWithType:(LMJEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block;

@end
