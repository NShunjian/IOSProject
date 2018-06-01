//
//  SUPOCandJSViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/6/1.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPOCandJSViewController.h"
#import "JSCallOCViewController.h"
#import "OCCallJSViewController.h"

@interface SUPOCandJSViewController ()

@end

@implementation SUPOCandJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 200, 30);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"JSCallOCButton" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jsCallOcButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(50, 150, 200, 30);
    secondButton.backgroundColor = [UIColor cyanColor];
     [secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secondButton setTitle:@"OCCallJSButton" forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(oCCallJsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];
}

- (void)jsCallOcButtonAction:(id)sender
{
    JSCallOCViewController *jSCallOCViewController = [[JSCallOCViewController alloc] init];
    [self.navigationController pushViewController:jSCallOCViewController animated:YES];
}

- (void)oCCallJsButtonAction:(id)sender
{
    OCCallJSViewController *oCCallJSViewController = [[OCCallJSViewController alloc] init];
    [self.navigationController pushViewController:oCCallJSViewController animated:YES];
    
}

@end
