//
//  UITextField+ExtentRange.h
//  QQingCommon
//
//  Created by Ben on 15/8/22.
//  Copyright (c) 2015年 QQingiOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)

- (NSRange)selectedRange;
- (void)setSelectedRange:(NSRange)range;

@end
