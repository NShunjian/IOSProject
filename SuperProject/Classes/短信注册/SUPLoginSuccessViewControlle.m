//
//  SUPLoginSuccessViewControlle.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPLoginSuccessViewControlle.h"

@interface SUPLoginSuccessViewControlle ()


@end

@implementation SUPLoginSuccessViewControlle


//个人中心

- (IBAction)personCenterButtonTapped:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}


//取消
- (IBAction)cancelButtonTapped:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
