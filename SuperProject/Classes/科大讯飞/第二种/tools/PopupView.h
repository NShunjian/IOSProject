//
//  PopupView.h
//  MSCDemo
//
//  Created by iflytek on 13-6-7.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIView

@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIView*  ParentView;
@property (nonatomic,assign) int queueCount;


/**
 initialize popUpView
 **/
- (id)initWithFrame:(CGRect)frame withParentView:(UIView*)view;


/**
 show text
 **/
- (void)showText:(NSString *)text;


/**
 set text
 **/
- (void)setText:(NSString *) text;//deprecated..

@end
