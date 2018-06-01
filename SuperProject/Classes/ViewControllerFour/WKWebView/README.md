# WKWebView
自定义封装WKWebView,JS和OC交互(OC调用JS方法,JS调用OC方法和JS与OC之间的传值)


适用于WKWebView和UIWebView,根据系统版本创建对应的webView


使用方法
1.遵守协议 <HXWKWebViewDelegate>
2.初始化并加载本地HTML
    - (void) initWKWebview {

    self.wkWebView = [[HXWKWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100 - 64)];
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"WKWebViewText" withExtension:@"html"];
    [self.wkWebView hx_loadRequest:[NSURLRequest requestWithURL:path]];
    [self.view addSubview:self.wkWebView];
    self.wkWebView.delegate = self;

}

3.实现代理
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


    /**
    WKWebView与JS 交互代理

    @param userContentController userContentController description
    @param message message description
    */
    - (void) hx_userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(HXWebModel *)message;
