//
//  SUPRequestManager.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPBaseResponse.h"
#import <AFNetworking.h>

typedef enum : NSInteger {
    SUPRequestManagerStatusCodeCustomDemo = -10000,
} SUPRequestManagerStatusCode;

typedef SUPBaseResponse *(^ResponseFormat)(SUPBaseResponse *response);


@interface SUPRequestManager : AFHTTPSessionManager


+ (instancetype)sharedManager;


//本地数据模式
@property (assign, nonatomic) BOOL isLocal;

//预处理返回的数据
@property (copy, nonatomic) ResponseFormat responseFormat;


//当前的网络状态
@property (assign, nonatomic) AFNetworkReachabilityStatus currentNetworkStatus;



- (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void (^)(SUPBaseResponse *response))completion;

- (void)GET:(NSString *)urlString parameters:(id)parameters completion:(void (^)(SUPBaseResponse *response))completion;

/**
  data 对应的二进制数据
  name 服务端需要参数
 */
- (void)upload:(NSString *)urlString parameters:(id)parameters formDataBlock:(void(^)(id<AFMultipartFormData> formData))formDataBlock progress:(void (^)(NSProgress *progress))progress completion:(void (^)(SUPBaseResponse *response))completion;


@end
