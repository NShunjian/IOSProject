//
//  HXWKWebView.h
//  WKWebView
//
//  Created by Jney on 2017/7/27.
//  Copyright © 2017年 Jney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "HXWebModel.h"

@class HXWKWebView;
@protocol HXWKWebViewDelegate <NSObject>
@required

/**
 webView加载完成
 
 @param hxWebview webView管理工具
 @param URL 加载url
 */
- (void)hx_webView:(HXWKWebView *)hxWebview didFinishLoadingURL:(NSURL *)URL;

/**
 webView加载失败
 
 @param hxWebview webView管理工具
 @param URL 加载url
 @param error 错误信息
 */
- (void)hx_webView:(HXWKWebView *)hxWebview didFailToLoadURL:(NSURL *)URL error:(NSError *)error;

/**
 webView即将加载
 
 @param hxWebview webView管理工具
 @param URL 加载url
 @return 返回是否加载出页面
 */
- (BOOL)hx_webView:(HXWKWebView *)hxWebview shouldStartLoadWithURL:(NSURL *)URL;

/**
 webView开始加载
 
 @param hxWebview webView管理工具
 */
- (void)hx_webViewDidStartLoad:(HXWKWebView *)hxWebview;

@optional
/**
 WKWebView与JS 交互代理
 
 @param userContentController userContentController description
 @param message message description
 */
- (void) hx_userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(HXWebModel *)message;

@end

typedef void(^CompletionHandler)(id object);

@interface HXWKWebView : UIView
/*
 *  webView的标题
 */
@property (nonatomic, strong) NSString *titleString;
/*
 *  webView进度条
 */
@property (nonatomic, strong) UIProgressView *progressView;
/*
 *  webView进度条颜色
 */
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, copy  ) CompletionHandler completionHandler;

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIWebView *uiWebView;
@property (nonatomic, weak  ) id <HXWKWebViewDelegate> delegate;

- (instancetype) initWithFrame:(CGRect)frame;


/**
 是否可以返回
 
 @return 是否可以返回
 */
- (BOOL) hx_canGoBack;

/**
 刷新页面
 */
- (void) hx_reload;

/**
 返回
 */
- (void) hx_goBack;

/**
 加载网络请求
 
 @param request request
 */
- (void)hx_loadRequest:(NSURLRequest *)request;

/**
 加载url
 
 @param URL url
 */
- (void)hx_loadURL:(NSURL *)URL;

/**
 加载URLString字符串
 
 @param URLString 字符串
 */
- (void)hx_loadURLString:(NSString *)URLString;

/**
 加载html字符串
 
 @param HTMLString html字符串
 */
- (void)hx_loadHTMLString:(NSString *)HTMLString;


/**
 HTML给OC发送消息
 
 @param scriptString 脚本字符串
 @param handlerBlock 回调
 */
- (void)hx_stringByEvaluatingJavaScriptFromString:(NSString *)scriptString completionHandler:(CompletionHandler)handlerBlock;


/**
 OC给HTML页面发送消息
 
 @param name 函数名
 @param paremeter 参数
 @param handlerBlock 回调
 */
- (void)hx_stringByEvaluatingSendMessageToJavaScript:(NSString *)name paremeter:(NSString *) paremeter completionHandler:(CompletionHandler)handlerBlock;
@end

