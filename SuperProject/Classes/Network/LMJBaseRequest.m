//
//  LMJBaseRequest.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJBaseRequest.h"

@implementation LMJBaseRequest


- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LMJBaseResponse *response))completion
{
    
    LMJWeakSelf(self);
    [[LMJRequestManager sharedManager] GET:URLString parameters:parameters completion:^(LMJBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        
        !completion ?: completion(response);
        
    }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LMJBaseResponse *response))completion
{
    LMJWeakSelf(self);
    [[LMJRequestManager sharedManager] POST:URLString parameters:parameters completion:^(LMJBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        
        !completion ?: completion(response);
        
    }];
}



@end
