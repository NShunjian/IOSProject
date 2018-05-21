//
//  SUPBaseRequest.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPBaseRequest.h"

@implementation SUPBaseRequest


- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(SUPBaseResponse *response))completion
{
    
    SUPWeakSelf(self);
    [[SUPRequestManager sharedManager] GET:URLString parameters:parameters completion:^(SUPBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        
        !completion ?: completion(response);
        
    }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(SUPBaseResponse *response))completion
{
    SUPWeakSelf(self);
    [[SUPRequestManager sharedManager] POST:URLString parameters:parameters completion:^(SUPBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        
        !completion ?: completion(response);
        
    }];
}



@end
