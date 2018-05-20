//
//  LMJOCJSHelper.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

UIKIT_EXTERN NSString *const LMJOCJSHelperScriptMessageHandlerName1_;


@protocol LMJOCJSHelperDelegate <NSObject>

@optional

@end



@interface LMJOCJSHelper : NSObject<WKScriptMessageHandler>

/** <#digest#> */
@property (weak, nonatomic) WKWebView *webView;

/** <#digest#> */
@property (weak, nonatomic) id<LMJOCJSHelperDelegate> delegate;


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end
