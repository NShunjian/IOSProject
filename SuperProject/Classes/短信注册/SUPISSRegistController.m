//
//  SUPISSRegistController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPISSRegistController.h"
#import "SUPLoginSuccessViewControlle.h"
#import "SMSSDKUIProcessHUD.h"
@interface SUPISSRegistController ()<UITextFieldDelegate>
{
        NSTimer *_timer;
}
@property (weak, nonatomic) IBOutlet UITextField *varifiTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *resendButton;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (nonatomic, assign) SMSGetCodeMethod methodType;

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *zone;

@end

@implementation SUPISSRegistController
- (instancetype)initWithPhoneNumber:(NSString *)phone zone:(NSString *)zone methodType:(SMSGetCodeMethod)method
{
    if (self = [super init])
    {
        _phone = phone;
        _zone  = zone;
        _methodType = method;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //验证码
    _varifiTextField.delegate = self;
    
    //密码
    _passwordTextField.delegate = self;
    
    //提示条
    self.tipLabel.text = [NSString stringWithFormat:@"验证码已发送至手机  %@", _phone];
    
    //添加隐藏键盘手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKeyBoard)];
    [self.view addGestureRecognizer:tapGesture];

}

//隐藏键盘手势
- (void)removeKeyBoard
{
    [_varifiTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}


//重新发送验证码
- (IBAction)ResendButton:(UIButton *)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phone zone:_zone template:nil result:^(NSError *error) {
        if (error)
        {
            [SMSSDKUIProcessHUD dismiss];
            NSLog(@"验证码获取失败");
        }
        else
        {
            [SMSSDKUIProcessHUD showSuccessInfo:@"获取验证码成功"];
            [SMSSDKUIProcessHUD dismissWithDelay:1.5 result:^{
            }];
        }
    }];
}


//下一步
- (IBAction)nextStepButtonTapped:(UIButton *)sender {
    
    if (_passwordTextField.text.length >= 6) {
        
        [self submit:sender];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"请设置大于六位数的密码"preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popoverPresentationController];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

#pragma mark -提交验证码
- (void)submit:(id)sender
{
    [SMSSDKUIProcessHUD showProcessHUDWithInfo:@"提交验证码"];
    
    [SMSSDK commitVerificationCode:_varifiTextField.text phoneNumber:_phone zone:_zone result:^(NSError *error) {
        

        if (error)
        {
            [SMSSDKUIProcessHUD dismiss];
            NSLog(@"验证失败");
        }
        else
        {
            [SMSSDKUIProcessHUD showSuccessInfo:@"提交成功"];
            [SMSSDKUIProcessHUD dismissWithDelay:1.5 result:^{
                [_timer invalidate];
                SUPLoginSuccessViewControlle  *vc = [[SUPLoginSuccessViewControlle alloc]init];
//                [self.navigationController pushViewController:vc animated:YES];
                 [self presentViewController:vc animated:YES completion:nil];
            }];
        }
    }];
}

#pragma mark ----- UITextFieldDelegate -----
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_varifiTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    return YES;
}



@end
