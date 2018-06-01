//
//  JSCallOCViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/6/1.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "JSCallOCViewController.h"
#import "TwoViewController.h"
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height

@interface JSCallOCViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation JSCallOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"js call oc";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.webView];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
    
    // 开启日志
    [WebViewJavascriptBridge enableLogging];
    
    // 给webview建立JS与OjbC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [self.bridge setWebViewDelegate:self];
    
    
    // JS调用OjbC的方法
    // 这是JS会调用callme方法，这是OC注册给JS调用的
    // JS需要回调，当然JS也可以传参数过来。data就是JS所传的参数，不一定需要传
    // OC端通过responseCallback回调JS端，JS就可以得到所需要的数据
    
    [self.bridge registerHandler:@"callme" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        
        NSLog(@"99999999999999执行任务了, data from js is ==============================99999%@", data);
        
        
        TwoViewController *t = [[TwoViewController alloc]init];
        
        t.url = data[@"blogURL"];
        
        
        
        //  [self.navigationController pushViewController:t animated:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        if (responseCallback) {
            
            //OC反馈给JS
            responseCallback(@"这是OC给JS的反馈哦~");
            
        }
    }];
    
    
    
}


//-(NSString *)url{
//    if (_url==nil) {
//        _url=[[NSString alloc]init];
//    }
//
//    return _url;
//
//}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //     NSURL *requestURL =[request URL];
    //
    //    NSLog(@"================%@///////%@",[requestURL scheme],requestURL);
    //
    //    self.url = @"崔顺建 崔顺建 崔顺建 崔顺建 崔顺建 崔顺建 崔顺建";
    
    
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSURL *url = [request URL];
        NSLog(@"=======kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk=========%@",url);
        if([[UIApplication sharedApplication]canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                NSLog(@"==================================================");
                
            }];
            
            
        }
        return NO;
    }
    
    
    
    
    return YES;
    
}



- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}



@end
