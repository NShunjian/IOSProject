//
//  BaseSTTInputHandler.h
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseSTTInputHandler : NSObject

@property (nonatomic, strong) id inputControl;
@property (nonatomic, assign) NSUInteger currentInputPosition;   // 初始化时不用手动传，构造方法中会计算的

+ (instancetype)inputHandlerWithInputControl:(id)inputControl;

- (instancetype)initWithInputControl:(id)inputControl;

- (void)handleAppendText:(NSString *)textToAppend;

@end


