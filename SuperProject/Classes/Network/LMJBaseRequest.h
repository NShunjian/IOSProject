//
//  LMJBaseRequest.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LMJBaseResponse;

@interface LMJBaseRequest : NSObject


- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LMJBaseResponse *response))completion;


- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LMJBaseResponse *response))completion;


@end
