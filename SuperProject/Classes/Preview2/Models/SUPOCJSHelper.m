//
//  SUPOCJSHelper.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPOCJSHelper.h"

NSString *const SUPOCJSHelperScriptMessageHandlerName1_ = @"OCJSHelper1";

@implementation SUPOCJSHelper

- (void)dealloc {
    NSLog(@"%@, %s", self.class, __func__);
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{       NSLog(@"%@",message.body);
    if (userContentController == self.webView.configuration.userContentController) {
        
        
        if ([message.name isEqualToString:SUPOCJSHelperScriptMessageHandlerName1_]) {
            
            
            NSDictionary *dict = message.body;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    
                    NSString *code = dict[@"code"];
                    
                    if ([code isEqualToString:@"getDeviceId"]) {
                        
                        NSString *functionName = dict[@"functionName"];
                        
                        
                        NSString *js = [functionName stringByAppendingFormat:@"('%@')", @"OC里边得到 DeviceID: 9213876827468372"];
                        
                        [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
                            
                            NSLog(@"%@", error);
                            
                        }];
                        
                    }
                    
                    
                }
                
 
            });
  
            
        }
        
        
        
    }
}

@end
