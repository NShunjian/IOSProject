//
//  MOBUDPClient.h
//  RTSPDemo
//
//  Created by fenghj on 16/4/8.
//  Copyright © 2016年 vimfung. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  接收数据回调处理器
 */
typedef void (^MOBFUDPClientReceiveDataHandler) (NSString *address, UInt32 port, NSData *data);

/**
 *  UDP客户端
 */
@interface MOBFUDPClient : NSObject

/**
 *  初始化UDP客户端
 *
 *  @param port 端口
 *
 *  @return 客户端对象
 */
- (instancetype)initWithPort:(UInt32)port;

/**
 *  开始
 */
- (void)start;

/**
 *  结束
 */
- (void)stop;

/**
 发送数据

 @param data 数据
 @param address 地址
 @param port 端口
 @return YES 发送成功，NO 发送失败
 */
- (BOOL)sendData:(NSData *)data toAddress:(NSString *)address andPort:(UInt32)port;

/**
 *  接收到数据
 *
 *  @param handler 事件处理器
 */
- (void)onReceiveData:(MOBFUDPClientReceiveDataHandler)handler;

@end
