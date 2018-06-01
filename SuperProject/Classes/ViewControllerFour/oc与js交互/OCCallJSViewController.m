//
//  OCCallJSViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/6/1.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "OCCallJSViewController.h"
#import "WebViewJavascriptBridge.h"

#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height
@interface OCCallJSViewController ()<UIWebViewDelegate>
{
    UITextField *textField;
    UILabel     *resultL;
}
@property(nonatomic, strong)UIWebView               *webView;
@property(nonatomic, strong)WebViewJavascriptBridge *bridge;
@end

@implementation OCCallJSViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"oc call js";
    self.view.backgroundColor = [UIColor grayColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.webView];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewJavaScriptBridge" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
    
    //开启日志
    [WebViewJavascriptBridge enableLogging];
    
    //给webview建立JS与OjbC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [self.bridge setWebViewDelegate:self];
    
    [self addView:self.webView];
    
}
- (void)addView:(UIWebView *)webView
{
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 350, 250, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view insertSubview:textField aboveSubview:webView];
    
    UIButton *caculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    caculateBtn.frame = CGRectMake(150, 400, 80, 30);
    caculateBtn.backgroundColor = [UIColor blueColor];
    [caculateBtn setTitle:@"计算" forState:UIControlStateNormal];
    [caculateBtn addTarget:self action:@selector(caculateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:caculateBtn aboveSubview:webView];
    
    resultL = [[UILabel alloc] initWithFrame:CGRectMake(50, 400, 80, 30)];
    resultL.font = [UIFont systemFontOfSize:14];
    resultL.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:resultL];
    [self.view insertSubview:textField aboveSubview:webView];
    
}

- (void)caculateButtonAction:(id)sender
{
    // OC调用JS方法
    //OC给JS提供公开的API，JS端通过注册，就可以在OC端调用此API并传入参数时，得到回调。
    NSLog(@"OC端 call JS端");
    
    [self.bridge callHandler:@"factorial" data:[NSNumber numberWithInteger:[textField.text integerValue]] responseCallback:^(id responseData) {
        
        resultL.text = [NSString stringWithFormat:@"结果%@",[responseData objectForKey:@"result"]];
        
        NSLog(@"OC端得到回调responseData: %@",responseData);
        
    }];
    
    //OC给JS提供公开的API，JS端通过注册，就可以在OC端调用此API，没有参数传入和回调。
    //    [self.bridge callHandler:@"openWebviewBridge" data:nil];
    //    NSLog(@"OC端 call JS端: openWebviewBridge");
    
}


@end
