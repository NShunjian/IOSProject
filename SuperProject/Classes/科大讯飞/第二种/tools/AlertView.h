//
//  AlertView.h
//  MSCDemo
//
//  Created by hchuang on 13-9-25.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

//#import <Foundation/Foundation.h>

@interface AlertView : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIActivityIndicatorView *aiv;
@property (nonatomic, strong) UIView*  ParentView;
@property (nonatomic, assign) int queueCount;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setText:(NSString *) text;

- (void)show;

- (void)hide;

@end
