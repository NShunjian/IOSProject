//
//  DesignerViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "DesignerViewController.h"



@interface DesignerViewController()

@property (nonatomic, strong) UIButton *returnButton;
@end


@implementation DesignerViewController

#pragma mark – Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    
    self.navigationItem.title=@"设计师模块";
    NSLog(@"当前参数：%@",self.parameterDictionary);
    
    NSLog(@"%@",[self getMessage]);
    NSLog(@"%@",[self getOtherMessage]);
    [self.view addSubview:self.returnButton];
    self.returnButton.frame=CGRectMake(10, 250, 50, 50);
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[self getMessage] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Events

- (void)didTappedReturnButton:(UIButton *)button
{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIButton *)returnButton
{
    if (_returnButton == nil) {
        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnButton addTarget:self action:@selector(didTappedReturnButton:) forControlEvents:UIControlEventTouchUpInside];
        [_returnButton setTitle:@"返回" forState:UIControlStateNormal];
        [_returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _returnButton;
}


-(NSString *)getMessage
{
    return @"我是原来的内容";
}

-(NSString *)getOtherMessage
{
    return @"我是getOtherMessage的内容";
}

@end
