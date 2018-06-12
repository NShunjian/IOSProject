//
//  TKTTSManager.m
//  TTS_demo
//
//  Created by wxc on 18/7/17.
//  Copyright © 2017年 wxc. All rights reserved.
//

#import "TKTTSManager.h"
#import <AVFoundation/AVFoundation.h>

@interface TKTTSManager ()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;//合成器
@property (nonatomic, strong) AVSpeechUtterance *utterance;    //表达器

@property (nonatomic, assign) TKSpeakStatus currentStatus;

@end

@implementation TKTTSManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _synthesizer = [[AVSpeechSynthesizer alloc]init];
        _synthesizer.delegate = self;
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static TKTTSManager *manager;
    dispatch_once(&once, ^{
        manager = [[TKTTSManager alloc]init];
    });
    
    return manager;
}

#pragma mark 内容
- (void)setSpeakString:(NSString *)speakString
{
    _speakString = speakString;
    _utterance = [AVSpeechUtterance speechUtteranceWithString:speakString];
    [self setUtterance];
}

- (void)setSpeakAttributedString:(NSAttributedString *)speakAttributedString
{
    _speakAttributedString = speakAttributedString;
    _utterance = [AVSpeechUtterance speechUtteranceWithAttributedString:speakAttributedString];
    [self setUtterance];
}


/**
 设置声音
 */
- (void)setUtterance
{
    //声音
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[AVSpeechSynthesisVoice currentLanguageCode]];
    //中式发音
    voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    //英式发音
    //    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    
    _utterance.voice = voice;
    _utterance.rate = AVSpeechUtteranceDefaultSpeechRate;//速率
    _utterance.pitchMultiplier = 0.8;//音调
    _utterance.volume = 1;//音量
    _utterance.preUtteranceDelay = 0;//朗读本句前延迟
    _utterance.postUtteranceDelay = 0;//朗读本句后延迟
}

#pragma mark public
/**
 开始
 */
- (void)startSpeak
{
    _currentStatus = TKSpeakStatusStart;
    if (_synthesizer.isSpeaking || _synthesizer.isPaused) {
        [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }else{
        [_synthesizer speakUtterance:_utterance];
    }
}


/**
 停止，与start对应
 */
- (BOOL)stopSpeak:(TKStopSpeakType)type
{
    BOOL status = NO;
    switch (type) {
        case TKStopSpeakTypeImmediate:
            status = [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            break;
            
        case TKStopSpeakTypeWord:
            status = [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
            break;
            
        default:
            status = NO;
            break;
    }
    
    if (status) {
        _currentStatus = TKSpeakStatusFinish;
    }
    
    return status;
}

/**
 暂停
 */
- (BOOL)pauseSpeak:(TKStopSpeakType)type
{
    BOOL status = NO;
    switch (type) {
        case TKStopSpeakTypeImmediate:
            status = [_synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            break;
            
        case TKStopSpeakTypeWord:
            status = [_synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
            break;
            
        default:
            status = NO;
            break;
    }
    
    if (status) {
        _currentStatus = TKSpeakStatusPause;
    }
    
    return status;
}


/**
 继续
 */
- (void)continueSpeak
{
    _currentStatus = TKSpeakStatusContinue;
    [_synthesizer continueSpeaking];
}

#pragma mark AVSpeechSynthesizerDelegate

//开始执行
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    
}

//结束执行
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    
}

//暂停执行
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance
{
    
}

//继续执行
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance
{
    
}

//取消时执行
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance
{
    if (_currentStatus == TKSpeakStatusStart) {
        [_synthesizer speakUtterance:_utterance];
    }
}

//朗读某一段执行
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance
{
    
}

@end
