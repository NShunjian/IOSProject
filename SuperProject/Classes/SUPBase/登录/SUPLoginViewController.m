//
//  SUPLoginViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPLoginViewController.h"
#import "SUPAppDelegate.h"
#import "NetworkTool.h"
#import "LMJRequestManager.h"
@interface SUPLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *SUPUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *SUPUserPasswordTextField;

@end

@implementation SUPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SUPRGBColor(206, 218, 229);
}
- (IBAction)loginButton:(UIButton *)sender {
     [(SUPAppDelegate*)AppDelegateInstance setUpHomeViewController];
//    NSString *username = _SUPUserNameTextField.text;
//    NSString *psd = _SUPUserPasswordTextField.text;
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    NSDictionary *dic = @{
//                          @"flowNo": @"111111",
//                          @"object": @{
//                                  @"username": username,
//                                  @"password": psd
//                                  }
//                          };
//
//    [[LMJRequestManager sharedManager] POST:@"http://118.184.186.2:8088//auth_s/auth-user/login"
//                                 parameters:dic completion:^(LMJBaseResponse *response) {
//           [(SUPAppDelegate*)AppDelegateInstance setUpHomeViewController];
////                                      NSLog(@"%@",response);
//                                 }];

    
//    NSDictionary *dic = @{
//                          @"flowNo": @"111111",
//                          @"object": @{
//                                  @"username": username,
//                                  @"password": psd
//                                  }
//                          };
//
//    if ([username isEqualToString:@""]) {
//        [[NetworkTool shareNetwork] POST:@"http://118.184.186.2:8088//auth_s/auth-user/login" Params:dic Success:^(id responseObject) {
//            NSLog(@"%@",responseObject);
//
//
//
//        } Failure:^(NSError *error) {
//
//            NSLog(@"%@",error);
//
//
//        }];
//    }
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
