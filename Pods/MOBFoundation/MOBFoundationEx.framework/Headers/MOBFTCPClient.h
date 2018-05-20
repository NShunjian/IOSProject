//
//  MOBFSocket.h
//  CFNetworkDemo
//
//  Created by fenghj on 15/8/18.
//  Copyright © 2015年 vimfung. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Socket连接处理器
 */
typedef void (^MOBFTCPClientConnectedHandler) ();

/**
 *  Socket断开连接处理器
 *
 *  @param error 错误信息
 */
typedef void (^MOBFTCPClientDisconnectedHandler) (NSError *error);

/**
 *  Socket接收数据处理器
 *
 *  @param data 数据
 */
typedef void (^MOBFTCPClientReceiveDataHandler) (NSData *data);

/**
 *  Socket实现
 */
@interface MOBFTCPClient : NSObject

/**
 *  主机
 */
@property (nonatomic, copy, readonly) NSString *host;

/**
 *  端口
 */
@property (nonatomic, readonly) UInt32 port;

/**
 *  初始化Socket
 *
 *  @param host 主机名称
 *  @param port 端口号
 *
 *  @return Socket对象
 */
- (instancetype)initWithHost:(NSString *)host port:(UInt32)port;

/**
 *  连接
 *
 *  @return YES 连接成功，NO 连接失败
 */
- (BOOL)connect;

/**
 *  断开连接
 */
- (void)disconnect;

/**
 *  写入数据
 *
 *  @param data 数据
 */
- (void)sendData:(NSData *)data;

/**
 *  已连接事件
 *
 *  @param handler 事件处理器
 */
- (void)onConnected:(MOBFTCPClientConnectedHandler)handler;

/**
 *  已断开链接事件
 *
 *  @param handler 事件处理器
 */
- (void)onDisconnected:(MOBFTCPClientDisconnectedHandler)handler;

/**
 *  接收数据
 *
 *  @param handler 事件处理器
 */
- (void)onReceiveData:(MOBFTCPClientReceiveDataHandler)handler;

@end
