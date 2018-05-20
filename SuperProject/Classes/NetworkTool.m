//
//  NetworkTool.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "NetworkTool.h"
#import <AFNetworking.h>



typedef NS_ENUM(NSInteger,RequestMethod){
    GET,
    POST,
    DOWNLOAD,
    UPLOAD
};
static NSString         *base_url = nil;
static NSTimeInterval   time_out = 60.0f;
static NSDictionary     *common_params = nil;

@interface NetworkTool()
@property (nonatomic, strong) NSMutableArray *tasks;
@end

@implementation NetworkTool

- (NSMutableArray *)tasks
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tasks = [NSMutableArray array];
    });
    return _tasks;
}




static id _instancetype;
+(instancetype)shareNetwork{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instancetype = [[self alloc]init];
    });
    
    
    return _instancetype;
    
    
}

- (void)setBaseUrl:(NSString *)url {
    base_url = url;
}

- (void)setTimeout:(NSTimeInterval)timeout {
    time_out = timeout;
}

- (void)setCommonParams:(NSDictionary *)params {
    common_params = params;
}


#pragma makr - 开始监听网络连接

+ (void)startMonitoring

{
    
    // 1.获得网络监控的管理者
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态改变了,就会调用这个block
        
        switch (status)
        
        {
                
            case AFNetworkReachabilityStatusUnknown:// 未知网络
                
                NSLog(@"未知网络");
                
                [NetworkTool shareNetwork].networkStats=StatusUnknown;
                
                
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:// 没有网络(断网)
                
                NSLog(@"没有网络");
                
                [NetworkTool shareNetwork].networkStats=StatusNotReachable;
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:// 手机自带网络
                
                NSLog(@"手机自带网络");
                
                [NetworkTool shareNetwork].networkStats=StatusReachableViaWWAN;
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:// WIFI
                
                
                
                [NetworkTool shareNetwork].networkStats=StatusReachableViaWiFi;
                
                NSLog(@"WIFI--%d",[NetworkTool shareNetwork].networkStats);
                
                break;
                
        }
        
    }];
    
    
    
    [mgr startMonitoring];
    
}




- (NSString *)print:(NSString *)url params:(NSDictionary *)params
{
    NSMutableString *absURL = [NSMutableString string];
    [absURL appendString:url];
    __block BOOL first = YES;
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keyvalue;
        if (first == YES)
        {
            keyvalue = [NSString stringWithFormat:@"?%@=%@",key,obj];
            first = NO;
        }
        else
        {
            keyvalue = [NSString stringWithFormat:@"&%@=%@",key,obj];
        }
        
        [absURL appendString:keyvalue];
    }];
    return absURL;
}

- (void)GET:(NSString *)url Params:(NSDictionary *)params Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure {
    [self RequestWithUrl:url RequestMethod:GET Params:params progerss:nil FileArray:nil Success:success Failure:failure];
}

- (void)POST:(NSString *)url Params:(NSDictionary *)params Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure {
    [self RequestWithUrl:url RequestMethod:POST Params:params progerss:nil FileArray:nil Success:success Failure:failure];
}

- (void)UPLOADSINGLEFILE:(NSString *)url Params:(NSDictionary *)params FileData:(NSData *)filedata Name:(NSString *)name FileName:(NSString *)filename MimeType:(NSString *)mimeType Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"data"] = filedata;
    dict[@"name"] = name;
    dict[@"filename"] = filename;
    dict[@"mimeType"] = mimeType;
    [self RequestWithUrl:url RequestMethod:UPLOAD Params:params progerss:nil FileArray:@[dict] Success:success Failure:failure];
}

- (void)UPLOADMULTIFILE:(NSString *)url Params:(NSDictionary *)params FileArray:(NSArray *)fileArray Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure {
    
    
    
    [self RequestWithUrl:url RequestMethod:UPLOAD Params:params progerss:nil FileArray:fileArray Success:success Failure:failure];
}
/**
 *  下载
 *
 *  @param url      文件地址
 *  @param path     文件本地存放路径
 *  @param progress 进度
 *  @param success  成功
 *  @param failure  失败
 */
- (void)downLoad:(NSString *)url saveToPath:(NSString *)path progerss:(void(^)(NSProgress * downloadProgress))progress success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self RequestWithUrl:path RequestMethod:DOWNLOAD Params:nil progerss:progress FileArray:nil Success:success Failure:failure];
}


- (void)RequestWithUrl:(NSString *)url RequestMethod:(RequestMethod)method Params:(NSDictionary *)params progerss:(void(^)(NSProgress * downloadProgress))progress FileArray:(NSArray *)fileArray Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = nil;
    
    if (base_url != nil) {
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:base_url]];
    }else {
        manager = [AFHTTPSessionManager manager];
    }
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = time_out;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    manager.operationQueue.maxConcurrentOperationCount = 6;
    
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionary];
    if (common_params != nil) {
        [requestParams addEntriesFromDictionary:common_params];
    }
    if (params != nil) {
        [requestParams addEntriesFromDictionary:params];
    }
    
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@",manager.baseURL];
    requestUrl = [requestUrl stringByAppendingString:url];
    
    NSLog(@"%@ = %@",url,[self print:requestUrl params:requestParams]);
    
    NSLog(@"%@",url);
    
    
    if (method == GET) {
        
        [manager GET:url parameters:requestParams progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                //success(responseObject);
                [self wrapperTask:task responseObject:responseObject error:nil Success:success Failure:failure];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
               // failure(error);
                [self wrapperTask:task responseObject:nil error:error Success:success Failure:failure];
            }
            
        }];
        
        
    }else if (method == POST) {
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                //success(responseObject);
                [self wrapperTask:task responseObject:responseObject error:nil Success:success Failure:failure];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
               // failure(error);
                [self wrapperTask:task responseObject:nil error:error Success:success Failure:failure];
            }
        }];
        
        
    }else if (method == UPLOAD) {
        
        [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSError *error;
            if (fileArray == nil || fileArray.count == 0) {
                if (failure) {
                    failure(error);
                }
            }else {
                [fileArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dict = obj;
                    NSData *filedata = dict[@"data"];
                    NSString *name = dict[@"name"];
                    NSString *filename = dict[@"filename"];
                    NSString *mimeType = dict[@"mimeType"];
                    [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
                }];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
        
    }else if (method == DOWNLOAD){
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLSessionDownloadTask *downTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            progress(downloadProgress);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            if(!url) {
                NSURL *downUrl = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                return [downUrl URLByAppendingPathComponent:[response suggestedFilename]];
            } else {
                return [NSURL fileURLWithPath:url];
            }
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            [self.tasks removeObject:downTask];
            if (!error) {
                success(filePath);
            } else {
                failure(error);
            }
        }];
        [downTask resume];
        
        if (downTask) {
            [self.tasks addObject:downTask];
        }
        
        
        
    }
    
    
    
}

#pragma mark - 处理数据
- (void)wrapperTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error Success:(void(^)(id responseObject))success
            Failure:(void(^)(NSError *error))failure
{
    
    if (error) {
        !failure ?: failure(error);
        return;
    }
    
    if (responseObject) {
        
        NSLog(@"%@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            if ([responseObject[@"success"] integerValue] != 1) {
                
                NSError *customError = [NSError errorWithDomain:@"CustomError" code:-63246 userInfo:nil];
                
                !failure ?: failure(customError);
//                SUPLoginView *lg=[SUPLoginView new];
//                
//                SUPNavigationController *nav = [[SUPNavigationController alloc] initWithRootViewController:lg];
//                
//                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:NO completion:nil];
                
                return;
            }
            
        }
        
        
        !success ?: success(responseObject);
        
        
    }
    
    
}

@end
