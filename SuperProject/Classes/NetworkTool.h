//
//  NetworkTool.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    
    
    StatusUnknown           = -1,//未知网络
    
    StatusNotReachable      = 0,   //没有网络
    
    StatusReachableViaWWAN  = 1,   //手机自带网络
    
    StatusReachableViaWiFi  = 2    //wifi
    
    
    
}NetworkStatu;

@interface NetworkTool : NSObject

/**
 
 *  获取网络
 
 */

@property (nonatomic,assign)NetworkStatu networkStats;



/**
 
 *  开启网络监测
 
 */

+ (void)startMonitoring;




+ (instancetype)shareNetwork;

/**
 *  设置网络请求接口的基地址（程序启动的时候设置一次就行）
 *
 *  @param url 基地址（http://211.151.130.187）
 */
- (void)setBaseUrl:(NSString *)url;

/**
 *  设置请求超时时长（默认60s）
 *
 *  @param timeout 超时时间
 */
- (void)setTimeout:(NSTimeInterval)timeout;

/**
 *  设置公共参数
 *
 *  @param params 公参
 */
- (void)setCommonParams:(NSDictionary *)params;

/**
 *  GET请求
 *
 *  @param url     请求地址
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 *
 *
 */
- (void)GET:(NSString *)url
                   Params:(NSDictionary *)params
                  Success:(void(^)(id responseObject))success
                  Failure:(void(^)(NSError *error))failure;

/**
 *  POST请求
 *
 *  @param url     请求地址
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 *
 *
 */
- (void)POST:(NSString *)url
                    Params:(NSDictionary *)params
                   Success:(void(^)(id responseObject))success
                   Failure:(void(^)(NSError *error))failure;

/**
 *  上传单个文件
 *
 *  @param url      请求地址
 *  @param params   参数
 *  @param filedata 文件数据
 *  @param name     服务器用来解析的字段
 *  @param filename 文件名
 *  @param mimeType mimetype
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  
 */
- (void)UPLOADSINGLEFILE:(NSString *)url
                                Params:(NSDictionary *)params
                              FileData:(NSData *)filedata
                                  Name:(NSString *)name
                              FileName:(NSString *)filename
                              MimeType:(NSString *)mimeType
                               Success:(void(^)(id responseObject))success
                               Failure:(void(^)(NSError *error))failure;
//-(void)she;
/**
 *  上传多个文件
 *
 *  @param url       请求地址
 *  @param params    参数
 *  @param fileArray 文件数组
 *  @param success   成功回调
 *  @param failure   失败回调
 *
 
 */

- (void)UPLOADMULTIFILE:(NSString *)url
                               Params:(NSDictionary *)params
                            FileArray:(NSArray *)fileArray
                              Success:(void(^)(id responseObject))success
                              Failure:(void(^)(NSError *error))failure;

/**
 *  下载
 *
 *  @param url      文件地址
 *  @param path     文件本地存放路径
 *  @param progress 进度
 *  @param success  成功
 *  @param failure  失败
 */
- (void)downLoad:(NSString *)url saveToPath:(NSString *)path progerss:(void (^)(NSProgress * downloadProgress))progress success:(void (^)(id responseObject))success failure:(void  (^)(NSError *error))failure;



@end
