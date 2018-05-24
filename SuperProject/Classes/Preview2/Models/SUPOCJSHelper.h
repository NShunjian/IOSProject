//
//  SUPOCJSHelper.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

UIKIT_EXTERN NSString *const SUPOCJSHelperScriptMessageHandlerName1_;


@protocol SUPOCJSHelperDelegate <NSObject>

@optional

@end



@interface SUPOCJSHelper : NSObject<WKScriptMessageHandler>

/** <#digest#> */
@property (weak, nonatomic) WKWebView *webView;

/** <#digest#> */
@property (weak, nonatomic) id<SUPOCJSHelperDelegate> delegate;


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end
