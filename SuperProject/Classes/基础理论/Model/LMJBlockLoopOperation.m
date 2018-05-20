//
//  LMJBlockLoopOperation.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJBlockLoopOperation.h"

@implementation LMJBlockLoopOperation

+ (void)operateWithSuccessBlock:(void(^)())successBlock
{
    if (successBlock) {
        successBlock();
    }
}

- (void)setLogAddress:(void (^)(NSString *address))logAddress {
    _logAddress = logAddress;
    
    !_logAddress ?: _logAddress(self.address);
}

- (void)dealloc {
    NSLog(@"dealloc- %@", self.class);
}

@end
