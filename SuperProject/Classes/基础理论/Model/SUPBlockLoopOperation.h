//
//  SUPBlockLoopOperation.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUPBlockLoopOperation : NSObject

+ (void)operateWithSuccessBlock:(void(^)())successBlock;

/** <#digest#> */
@property (nonatomic, copy) NSString *address;

/** <#digest#> */
@property (nonatomic, copy) void(^logAddress)(NSString *address);

@end
