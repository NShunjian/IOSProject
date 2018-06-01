//
//  ViewController.m
//  WKWebView
//
//  Created by Jney on 2017/7/27.
//  Copyright © 2017年 Jney. All rights reserved.
//

#import "SUPWKViewController.h"
#import "SecondViewController.h"
#import "HXWKWebView.h"

@interface SUPWKViewController ()<HXWKWebViewDelegate>

@property (nonatomic, strong)HXWKWebView *wkWebView;
///用来存放HTML页面上文本款的字符串
@property (nonatomic, strong)__block NSString *htmlStr;

@end

@implementation SUPWKViewController
@synthesize wkWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化wkWebView并加载本地HTML
    [self initWKWebview];

}
- (IBAction)goBack:(UIButton *)sender {
    
        if ([self.wkWebView hx_canGoBack]) {
            ///如果WKWebViewk可以返回上一个页面
            [self.wkWebView hx_goBack];
        }
}

- (IBAction)clickButton:(UIButton *)sender {
    [self.wkWebView hx_stringByEvaluatingSendMessageToJavaScript:@"setValue" paremeter:@"在这里通过OC给JS赋值" completionHandler:^(id object) {
        NSLog(@"%@",object);
    }];
}

/**
 初始化并加载本地HTML
 */
- (void) initWKWebview {
    
    self.wkWebView = [[HXWKWebView alloc]initWithFrame:CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100 - 104)];
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"WKWebViewText" withExtension:@"html"];
    [self.wkWebView hx_loadURL:path];
    [self.view addSubview:self.wkWebView];
    self.wkWebView.delegate = self;

}

#pragma mark - HXWKWebViewDelegate

/**
 HTML开始加载
 */
- (void) hx_webViewDidStartLoad:(HXWKWebView *)hxWebview{
    
    NSLog(@"The page starts loading...");
    
}

/**
 HTML加载完毕
 */
- (void) hx_webView:(HXWKWebView *)hxWebview didFinishLoadingURL:(NSURL *)URL{
    
    NSLog(@"The page is loaded!");
    self.title = self.wkWebView.titleString;
    
}

/**
 HTML加载失败
 */
- (void) hx_webView:(HXWKWebView *)hxWebview didFailToLoadURL:(NSURL *)URL error:(NSError *)error{
    
    NSLog(@"Loading error!");
    
}


/**
 在url变化或网页内容变化的时候也能调用
 */
- (BOOL) hx_webView:(HXWKWebView *)hxWebview shouldStartLoadWithURL:(NSURL *)URL{
    NSLog(@"Intercept to URL：%@",URL);
    return YES;
}

/**
 WKWebView和JS交互代理
 */
- (void)hx_userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(HXWebModel *)message{
   
    
    NSLog(@"JS交互:%@",message.body);
    ///点击网页上的按钮 获取文本款的值
    NSString *textString = @"document.getElementById('nameID').value";
    
    [self.wkWebView hx_stringByEvaluatingJavaScriptFromString:textString completionHandler:^(id object) {
        self.htmlStr = object;
        NSLog(@"获取html文本框上的值:%@",object);//获取的是网页文本框内的值
    }];
    
    ///JS调用OC方法
    //body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
    if ([message.body isKindOfClass:[NSString class]]) {
        //在点击HTML里面的"点击跳转到下一个页面"的时候会发送一个包含"pushNextVC"的message
        if ([message.body isEqualToString:@"pushNextVC"]) {
            SecondViewController *secondVC = [SecondViewController new];
            secondVC.htmlText = self.htmlStr;
            [self.navigationController pushViewController:secondVC animated:YES];
            
        }
    }

    
}
#pragma mark - SUPNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

#pragma mark - SUPNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
