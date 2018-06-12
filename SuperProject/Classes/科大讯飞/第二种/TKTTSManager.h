//
//  TKTTSManager.h
//  TTS_demo
//
//  Created by wxc on 18/7/17.
//  Copyright © 2017年 wxc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TKStopSpeakType){
    TKStopSpeakTypeImmediate,//立即
    TKStopSpeakTypeWord,     //一个词
};

typedef NS_ENUM(NSInteger, TKSpeakStatus){
    TKSpeakStatusDefault,//未开始
    TKSpeakStatusStart,//开始
    TKSpeakStatusPause,//暂停
    TKSpeakStatusContinue,//继续
    TKSpeakStatusFinish,//结束
};

@interface TKTTSManager : NSObject

@property (nonatomic, copy) NSString *speakString;
@property (nonatomic, copy) NSAttributedString *speakAttributedString;

@property (nonatomic, assign, readonly) TKSpeakStatus currentStatus;

/**
 单例
 */
+ (instancetype)sharedInstance;

/**
 开始
 */
- (void)startSpeak;


/**
 停止，与start对应
 */
- (BOOL)stopSpeak:(TKStopSpeakType)type;

/**
 暂停
 */
- (BOOL)pauseSpeak:(TKStopSpeakType)type;


/**
 继续
 */
- (void)continueSpeak;

@end
