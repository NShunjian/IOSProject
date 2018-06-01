//
//  FWPickerView.h
//  FTHW
//
//  Created by weiguo on 16/9/21.
//  Copyright © 2016年 YJLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWPickerView;

typedef void (^WWPickViewSubmit)(NSString*);

@interface WWPickerView : UIView<UIPickerViewDelegate>

- (void)setDateViewWithTitle:(NSString *)title withMode:(UIDatePickerMode)mode;

- (void)setDataViewWithItem:(NSArray *)items title:(NSString *)title;

- (void)showPickView:(UIViewController *)vc;

@property(nonatomic,copy)WWPickViewSubmit block;

@end





