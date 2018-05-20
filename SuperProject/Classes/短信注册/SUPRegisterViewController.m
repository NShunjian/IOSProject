//
//  SUPRegisterViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPRegisterViewController.h"
#import "SUPISSRegistController.h"
#import "NSString+PJR.h"
#import "SMSSDKUIProcessHUD.h"
@interface SUPRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *PhoneNumberTextfield;
@property (nonatomic, assign) SMSGetCodeMethod methodType;

@end

@implementation SUPRegisterViewController
- (instancetype)initWithMethod:(SMSGetCodeMethod)methodType
{
    if (self = [super init])
    {
        _methodType = methodType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//隐藏键盘手势
- (void)removeKeyBoard
{
    [_PhoneNumberTextfield resignFirstResponder];
}

- (void)SUPBack {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//获取验证码
- (IBAction)GainVerification:(UIButton *)sender {
    
    if ([_PhoneNumberTextfield.text isVAlidPhoneNumber]) {
        [_PhoneNumberTextfield resignFirstResponder];
        [self getVerificationCodeWithMethod:SMSGetCodeMethodSMS];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"请输入正确的手机号"preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popoverPresentationController];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)getVerificationCodeWithMethod:(SMSGetCodeMethod)method
{
    NSString *alertText = [NSString stringWithFormat:@"%@",_PhoneNumberTextfield.text];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"电话号码验证" message:alertText preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [SMSSDKUIProcessHUD showProcessHUDWithInfo:@"发送请求..."];

        NSString *template = nil;

        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_PhoneNumberTextfield.text zone:@"+86" template:template result:^(NSError *error) {
            if (error)
            {
                [SMSSDKUIProcessHUD dismiss];
                NSLog(@"验证码获取失败");

            }
            else
            {
                [SMSSDKUIProcessHUD showSuccessInfo:@"获取验证码成功"];
                [SMSSDKUIProcessHUD dismissWithDelay:1.5 result:^{

                    SUPISSRegistController *vc =[[SUPISSRegistController alloc]initWithPhoneNumber:_PhoneNumberTextfield.text zone:@"+86" methodType:_methodType];
                    //    [self.navigationController pushViewController:vc animated:YES];
                        [self presentViewController:vc animated:YES completion:nil];

                }];
            }
        }];
    }];
    [alert addAction:ok];

    [self presentViewController:alert animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
