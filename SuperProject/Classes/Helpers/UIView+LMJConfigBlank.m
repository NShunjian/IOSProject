//
//  UIView+LMJConfigBlank.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "UIView+LMJConfigBlank.h"

static char BlankPageViewKey;

@implementation UIView (LMJConfigBlank)

- (void)setBlankPageView:(LMJEasyBlankPageView *)blankPageView{
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LMJEasyBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(LMJEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[LMJEasyBlankPageView alloc] initWithFrame:CGRectMake(0, 0, self.lmj_width, self.lmj_height)];
        }
        self.blankPageView.hidden = NO;
        [self addSubview:self.blankPageView];
        
        [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
}

@end
