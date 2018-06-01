//
//  HXWKWebView.m
//  WKWebView
//
//  Created by Jney on 2017/7/27.
//  Copyright © 2017年 Jney. All rights reserved.
//

#import "HXWKWebView.h"
#import "WebViewJavascriptBridge.h"

#define isiOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

static void *HXWebBrowserContext = &HXWebBrowserContext;

@interface HXWKWebView ()<WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate, WKScriptMessageHandler>

@property WebViewJavascriptBridge* bridge;

/*
 *  webView进度条定时器
 */
@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@property (nonatomic, strong) NSURL *URLToLaunchWithPermission;
@property (nonatomic, strong) UIAlertView *externalAppPermissionAlertView;

@end

@implementation HXWKWebView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if(isiOS8) {
            WKWebViewConfiguration *config = [WKWebViewConfiguration new];
            //初始化偏好设置属性：preferences
            config.preferences = [WKPreferences new];
            //The minimum font size in points default is 0;
            config.preferences.minimumFontSize = 10;
            //是否支持JavaScript
            config.preferences.javaScriptEnabled = YES;
            //不通过用户交互，是否可以打开窗口
            config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
            //通过JS与webView内容交互
            config.userContentController = [WKUserContentController new];
            
            //注入JS对象名称senderModel，当JS通过senderModel来调用时，我们可以在WKScriptMessageHandler代理中接收到
            [config.userContentController addScriptMessageHandler:self name:@"senderModel"];
            
            self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) configuration:config];
            [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            [self.wkWebView setNavigationDelegate:self];
            [self.wkWebView setUIDelegate:self];
            [self.wkWebView setMultipleTouchEnabled:YES];
            [self.wkWebView setAutoresizesSubviews:YES];
            [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
            [self addSubview:self.wkWebView];
            self.wkWebView.scrollView.bounces = NO;
            [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:HXWebBrowserContext];
        }else {
            self.uiWebView = [[UIWebView alloc] init];
            [self.uiWebView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
            [self.uiWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            [self.uiWebView setDelegate:self];
            [self.uiWebView setMultipleTouchEnabled:YES];
            [self.uiWebView setAutoresizesSubviews:YES];
            [self.uiWebView setScalesPageToFit:YES];
            [self.uiWebView.scrollView setAlwaysBounceVertical:YES];
            self.uiWebView.scrollView.bounces = NO;
            self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.uiWebView];
            
            [WebViewJavascriptBridge enableLogging]; //开启调试模式
            //响应JS通过callhandler发送给OC的消息
            [self.bridge registerHandler:@"testJavascriptSendMessage" handler:^(id data, WVJBResponseCallback responseCallback) {
                responseCallback(data);
                if ([self.delegate respondsToSelector:@selector(hx_userContentController:didReceiveScriptMessage:)]) {
                    HXWebModel *message = [[HXWebModel alloc] init];
                    message.body = data;
                    [self.delegate hx_userContentController:nil didReceiveScriptMessage:message];
                }
                
            }];
            [self addSubview:self.uiWebView];
        }
        self.backgroundColor = [UIColor whiteColor];
        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
        [self.progressView setFrame:CGRectMake(0, 0, self.frame.size.width, self.progressView.frame.size.height)];
        [self setTintColor:[UIColor colorWithRed:0.400 green:0.863 blue:0.133 alpha:1.000]];
        [self addSubview:self.progressView];
    }
    return self;
}

- (BOOL) hx_canGoBack{
    if (self.wkWebView) {
        return [self.wkWebView canGoBack];
    }else{
        return [self.uiWebView canGoBack];
        
    }
}

- (void)hx_reload {
    if(self.wkWebView) {
        [self.wkWebView reload];
    } else {
        [self.uiWebView reload];
    }
}


- (void) hx_goBack{
    
    if (self.wkWebView) {
        [self.wkWebView goBack];
    }else{
        [self.uiWebView goBack];
        
    }
}

- (void)hx_loadRequest:(NSURLRequest *)request {
    if(self.wkWebView) {
        [self.wkWebView loadRequest:request];
    }
    else  {
        [self.uiWebView loadRequest:request];
    }
}

- (void)hx_loadURL:(NSURL *)URL {
    [self hx_loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)hx_loadURLString:(NSString *)URLString {
    
    NSString *urlString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:urlString];
    [self hx_loadURL:URL];
}

- (void)hx_loadHTMLString:(NSString *)HTMLString {
    if(self.wkWebView) {
        [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
    }
    else if(self.uiWebView) {
        [self.uiWebView loadHTMLString:HTMLString baseURL:nil];
    }
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor ?: [UIColor clearColor];
    [self.progressView setTintColor:progressColor];
}


/**
 获取view所在的控制器
 
 @return 控制器
 */
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

///这里是UIWebView代理
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    webView == self.uiWebView ? [self.delegate hx_webViewDidStartLoad:self] : nil;
}

#pragma mark 监听请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(webView == self.uiWebView) {
        if(![self externalAppRequiredToOpenURL:request.URL]) {
            self.uiWebViewCurrentURL = request.URL;
            self.uiWebViewIsLoading = YES;
            [self fakeProgressViewStartLoading];
            //代理
            
            return [self.delegate hx_webView:self shouldStartLoadWithURL:request.URL];
            
        }
        else {
            [self launchExternalAppWithURL:request.URL];
            return NO;
        }
    }
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView == self.uiWebView) {
        self.titleString = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if(!self.uiWebView.isLoading) {
            self.uiWebViewIsLoading = NO;
            [self fakeProgressBarStopLoading];
        }
        //代理
        [self.delegate hx_webView:self didFinishLoadingURL:self.uiWebView.request.URL];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if(webView == self.uiWebView) {
        if(!self.uiWebView.isLoading) {
            self.uiWebViewIsLoading = NO;
            [self fakeProgressBarStopLoading];
        }
        //代理
        [self.delegate hx_webView:self didFailToLoadURL:self.uiWebView.request.URL error:error];
    }
}

///WKWebView代理
#pragma mark - WKNavigationDelegate

// 当main frame的导航开始请求时，会调用此方法
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        //代理
        [self.delegate hx_webViewDidStartLoad:self];
        
        
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容开始返回时调用");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
            self.titleString = obj;
            //代理
            [self.delegate hx_webView:self didFinishLoadingURL:self.wkWebView.URL];
        }];
        
    }
}

// 当main frame开始加载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    webView == self.wkWebView ? [self.delegate hx_webView:self didFailToLoadURL:self.wkWebView.URL error:error] : nil;
}

// 当main frame最后下载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    
    if(webView == self.wkWebView) {
        //代理
        [self.delegate hx_webView:self didFailToLoadURL:self.wkWebView.URL error:error];
    }
}

// 当main frame接收到服务重定向时，会回调此方法 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"重定向");
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if(![self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType]){
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    if(webView == self.wkWebView) {
        NSURL *URL = navigationAction.request.URL;
        ///加载失败
        NSError *error = nil;
        NSHTTPURLResponse *response = nil;
        [NSURLConnection sendSynchronousRequest:navigationAction.request returningResponse:&response error:&error];
        ///加载的本地URL(加载本地url的时候成功是不会出现statusCode状态)
        if (([response.URL.absoluteString rangeOfString:@"file:"].location == NSNotFound) && ([response.URL.absoluteString rangeOfString:@"about:blank"].location == NSNotFound) && response.statusCode != 200) {
            //状态码不是200就是失败  空白页面不算失败
            decisionHandler(WKNavigationActionPolicyCancel);
            [self.delegate hx_webView:self didFailToLoadURL:self.wkWebView.URL error:nil];
            return ;
        }
        
        if(![self externalAppRequiredToOpenURL:URL]) {
            if(!navigationAction.targetFrame) {
                //表示webview新开启一个页面
                [self hx_loadURL:URL];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
            [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
        }else if([[UIApplication sharedApplication] canOpenURL:URL]) {
            [self launchExternalAppWithURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //
    decisionHandler(WKNavigationResponsePolicyAllow);
}

-(BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType
{
    //代理
    return [self.delegate hx_webView:self shouldStartLoadWithURL:request.URL];
    
    
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
///如果需要显示提示框,则需要实现以下代理

//alert 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [[self viewController] presentViewController:alert animated:YES completion:nil];
    
}

//confirm 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [[self viewController] presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"confirm message:%@", message);
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:@"调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [[self viewController] presentViewController:alert animated:YES completion:NULL];
}


#pragma mark - Estimated Progress KVO (WKWebView)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Fake Progress Bar Control (UIWebView)

- (void)fakeProgressViewStartLoading {
    [self.progressView setProgress:0.0f animated:NO];
    [self.progressView setAlpha:1.0f];
    
    if(!self.fakeProgressTimer) {
        self.fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
    }
}

- (void)fakeProgressBarStopLoading {
    if(self.fakeProgressTimer) {
        [self.fakeProgressTimer invalidate];
    }
    if(self.progressView) {
        [self.progressView setProgress:1.0f animated:YES];
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)fakeProgressTimerDidFire:(id)sender {
    CGFloat increment = 0.005/(self.progressView.progress + 0.2);
    if([self.uiWebView isLoading]) {
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        if(self.progressView.progress < 0.95) {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

#pragma mark - External App Support

- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    /*
     若需要限制只允许某些前缀的scheme通过请求，则取消下述注释，并在数组内添加自己需要放行的前缀
     NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https",@"file"]];
     return ![validSchemes containsObject:URL.scheme];
     */
    
    return !URL;
}

- (void)launchExternalAppWithURL:(NSURL *)URL {
    self.URLToLaunchWithPermission = URL;
    if (![self.externalAppPermissionAlertView isVisible]) {
        [self.externalAppPermissionAlertView show];
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(alertView == self.externalAppPermissionAlertView) {
        if(buttonIndex != alertView.cancelButtonIndex) {
            [[UIApplication sharedApplication] openURL:self.URLToLaunchWithPermission];
        }
        self.URLToLaunchWithPermission = nil;
    }
}

#pragma mark - self Life cycle

- (void)dealloc {
    [self.uiWebView setDelegate:nil];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([self.delegate respondsToSelector:@selector(hx_userContentController:didReceiveScriptMessage:)]) {
        HXWebModel *messageModel = [[HXWebModel alloc] init];
        messageModel.name = message.name;
        messageModel.body = message.body;
        [self.delegate hx_userContentController:userContentController didReceiveScriptMessage:messageModel];
    }
}

/**
 HTML和OC交互
 
 @param scriptString 脚本字符串
 */
- (void)hx_stringByEvaluatingJavaScriptFromString:(NSString *)scriptString completionHandler:(CompletionHandler)handlerBlock{
    
    if (self.wkWebView) {
        [self.wkWebView evaluateJavaScript:scriptString completionHandler:^(id _Nullable object, NSError * _Nullable error) {
            handlerBlock(object);
            
        }];
    }else{
        id object = [self.uiWebView stringByEvaluatingJavaScriptFromString:scriptString];
        handlerBlock(object);
    }
}

- (void)hx_stringByEvaluatingSendMessageToJavaScript:(NSString *)name paremeter:(NSString *) paremeter completionHandler:(CompletionHandler)handlerBlock{
    
    if (self.wkWebView) {
        NSString *scriptString = [NSString stringWithFormat:@"%@('%@')",name,paremeter];
        [self.wkWebView evaluateJavaScript:scriptString completionHandler:^(id _Nullable object, NSError * _Nullable error) {
            handlerBlock(object);
        }];
        
    }else{
        ///给JS发送消息
        [self.bridge callHandler:name data:paremeter responseCallback:^(id responseData) {
            handlerBlock(responseData);
        }];
        
    }
}

@end

