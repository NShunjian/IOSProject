//
//  UIView+SUPConfigBlank.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "UIView+SUPConfigBlank.h"

static char BlankPageViewKey;

@implementation UIView (SUPConfigBlank)

- (void)setBlankPageView:(SUPEasyBlankPageView *)blankPageView{
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SUPEasyBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(SUPEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[SUPEasyBlankPageView alloc] initWithFrame:CGRectMake(0, 0, self.SUP_width, self.SUP_height)];
        }
        self.blankPageView.hidden = NO;
        [self addSubview:self.blankPageView];
        
        [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
}

@end
