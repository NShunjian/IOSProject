//
//  SUPTextViewController.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPNavUIBaseViewController.h"
#import "SUPNavUIBaseViewController.h"

@class SUPTextViewController;
@protocol SUPTextViewControllerDataSource <NSObject>

@optional
- (UIReturnKeyType)textViewControllerLastReturnKeyType:(SUPTextViewController *)textViewController;

- (BOOL)textViewControllerEnableAutoToolbar:(SUPTextViewController *)textViewController;

- (NSArray <UIButton *> *)textViewControllerRelationButtons:(SUPTextViewController *)textViewController;

@end


@protocol SUPTextViewControllerDelegate <UITextViewDelegate, UITextFieldDelegate>

@optional
#pragma mark - 最后一个输入框点击键盘上的完成按钮时调用
- (void)textViewController:(SUPTextViewController *)textViewController inputViewDone:(id)inputView;



@end




@interface SUPTextViewController : SUPNavUIBaseViewController<SUPTextViewControllerDataSource, SUPTextViewControllerDelegate>

- (BOOL)textFieldShouldClear:(UITextField *)textField NS_REQUIRES_SUPER;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string NS_REQUIRES_SUPER;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_REQUIRES_SUPER;
- (BOOL)textFieldShouldReturn:(UITextField *)textField NS_REQUIRES_SUPER;


@end




#pragma mark - design UITextField
IB_DESIGNABLE
@interface UITextField (SUPTextViewController)

@property (assign, nonatomic) IBInspectable BOOL isEmptyAutoEnable;

@end


@interface SUPTextViewControllerTextField : UITextField

@end





