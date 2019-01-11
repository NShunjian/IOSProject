//
//  TwoViewController.m
//  1234
//
//  Created by 崔顺建 on 17/2/6.
//  Copyright © 2017年 superMan. All rights reserved.
//

#import "TwoViewController.h"
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height
#import "JSCallOCViewController.h"
@interface TwoViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;


@end

@implementation TwoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //JSCallOCViewController *js = [[JSCallOCViewController alloc]init];
    
    
    self.view.backgroundColor = [UIColor greenColor];
    
    
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.webView.delegate = self;
    
    
        [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:self.url];
    
    NSLog(@"8888888888888  -----------------------%@",self.url);
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    //NSLog(@"55555555555555555555555555555555555555%@======================",self.url);
        
       // NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //[self.webView loadRequest:request];
        


    
    
    
    // Do any additional setup after loading the view.
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
