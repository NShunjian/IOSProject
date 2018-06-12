//
//  IATViewController.h
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-28.
//
//

#import "QQingSpeechRecognizer.h"
#import "Definition.h"
#import "ISRDataHelper.h"
#import "IATConfig.h"
#import "iflyMSC/iflyMSC.h"

/**
 语音听写demo
 使用该功能仅仅需要四步
 1.创建识别对象；
 2.设置识别参数；
 3.有选择的实现识别回调；
 4.启动识别
 */

@interface QQingSpeechRecognizer ()<IFlySpeechRecognizerDelegate,IFlyPcmRecorderDelegate>

@property (strong,nonatomic) NSMutableString* result;

@property (nonatomic,strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入
@property (nonatomic,assign) QQingSpeechRegonizerTimeoutType timeoutType;

@end

@implementation QQingSpeechRecognizer


#pragma mark - 视图生命周期


-(instancetype)init{
    if (self = [super init]) {
        [self initRecognizer];//初始化识别对象
    }
    return self;
}

-(void)dealloc
{
    [_iFlySpeechRecognizer cancel]; //取消识别
    [_iFlySpeechRecognizer setDelegate:nil];
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    
    [_pcmRecorder stop];
    _pcmRecorder.delegate = nil;
}


#pragma mark - 初始化Recognizer

/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    _iFlySpeechRecognizer.delegate = self;
    
    IATConfig *instance = nil;
    if ([self.delegate respondsToSelector:@selector(speechRecognizerWillConfig:)]) {
        instance = [self.delegate speechRecognizerWillConfig:self];
    }
    if (instance == nil) {
        instance = [IATConfig sharedInstance];
    }
    
    //设置最长录音时间
    [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
    //设置后端点
    [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
    //设置前端点
    [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
    //网络等待时间
    [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
    
    //设置采样率，推荐使用16K
    [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    if ([instance.language isEqualToString:[IATConfig chinese]]) {
        //设置语言
        [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
    }else if ([instance.language isEqualToString:[IATConfig english]]) {
        [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
    }
    //设置是否返回标点符号
    [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];

    
    //初始化录音器
    if (_pcmRecorder == nil)
    {
        _pcmRecorder = [IFlyPcmRecorder sharedInstance];
    }
    
    _pcmRecorder.delegate = self;
    
    [_pcmRecorder setSample:instance.sampleRate];
    
    [_pcmRecorder setSaveAudioPath:nil];    //不保存录音文件
    
}

#pragma mark - Public

/**
 音频流识别启动
 ****/
- (void)start{
    
    self.timeoutType = QQingSpeechRegonizerTimeoutType_None;
    
    
    if(_iFlySpeechRecognizer == nil)
    {
        [self initRecognizer];
    }
    
    if( [_iFlySpeechRecognizer isListening])
    {
//        [_popUpView showText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束，暂不支持多路并发
//        [self didError:nil];
        return;
    }

    
    [_iFlySpeechRecognizer setDelegate:self];
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_STREAM forKey:@"audio_source"];    //设置音频数据模式为音频流
    BOOL ret  = [_iFlySpeechRecognizer startListening];
    
    
    if (ret) {

        //初始化录音环境
        [IFlyAudioSession initRecordingAudioSession];
        
        _pcmRecorder.delegate = self;
        
        //启动录音器服务
        BOOL ret = [_pcmRecorder start];
        if (!ret) {
            [_iFlySpeechRecognizer stopListening];
            [self didError:nil];
            return;
        }
        
        [self didStart];
    }
    else
    {
        [self didError:nil];
    }
}

- (void)stop{
    [self stopWithTimeoutType:QQingSpeechRegonizerTimeoutType_None];
}

- (void)stopWithTimeoutType:(QQingSpeechRegonizerTimeoutType)type{
    [_pcmRecorder stop];
    [_iFlySpeechRecognizer stopListening];
    
    [self didStopWithTimeoutType:type];
}

#pragma mark - Check

-(void)checkBeforeTimeout{
    [self stopWithTimeoutType:QQingSpeechRegonizerTimeoutType_Before];
}

-(void)checkAfterTimeout{
    [self stopWithTimeoutType:QQingSpeechRegonizerTimeoutType_After];
}

-(void)checkTotalTimeout{
    [self stopWithTimeoutType:QQingSpeechRegonizerTimeoutType_Total];
}

-(void)startCheckBeforeTimeout{
    [self performSelector:@selector(checkBeforeTimeout) withObject:nil afterDelay:[[IATConfig sharedInstance].vadBos floatValue] / 1000 - 1];
}

-(void)cancelCheckBeforeTimeout{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkBeforeTimeout) object:nil];
}

-(void)startCheckAfterTimeout{
    [self performSelector:@selector(checkAfterTimeout) withObject:nil afterDelay:[[IATConfig sharedInstance].vadEos floatValue] / 1000 - 1];
}

-(void)cancelCheckAfterTimeout{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkAfterTimeout) object:nil];
}

-(void)startCheckTotalTimeout{
    [self performSelector:@selector(checkTotalTimeout) withObject:nil afterDelay:[[IATConfig sharedInstance].speechTimeout floatValue] / 1000 - 2];
}

-(void)cancelCheckTotalTimeout{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkTotalTimeout) object:nil];
}

-(void)cancelAllCheckTimeout{
    [self cancelCheckBeforeTimeout];
    [self cancelCheckAfterTimeout];
    [self cancelCheckTotalTimeout];
}

#pragma mark - IFlySpeechRecognizerDelegate

/**
 开始识别回调
 ****/
- (void) onBeginOfSpeech
{
}

/**
 停止录音回调
 ****/
- (void) onEndOfSpeech
{
    [_pcmRecorder stop];
}


/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void)onCompleted:(IFlySpeechError *)errorCode
{
    NSString *text ;
    
    if (errorCode.errorCode == 0 ) {
        
        [self didSuccessResult:self.result];
        
        if (_result.length == 0) {
            text = @"无识别结果";
        }else {
            text = [NSString stringWithFormat:@"识别成功:%@",_result];
            //清空识别结果
            _result = nil;
        }
    }else {
        text = [NSString stringWithFormat:@"发生错误：%d %@", errorCode.errorCode,errorCode.errorDesc];
        
        [self didError:errorCode];
    }
    
    NSLog(@"%s %@",__FUNCTION__,text);
}

/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    
    if (resultFromJson.length) {
        [self.result appendString:resultFromJson];
    }
    [self didRecognizedResult:resultFromJson];
}


/**
 听写取消回调
 ****/
- (void) onCancel
{
}

#pragma mark - IFlyPcmRecorderDelegate

- (void)onIFlyRecorderBuffer: (const void *)buffer bufferSize:(int)size
{
    NSData *audioBuffer = [NSData dataWithBytes:buffer length:size];
    
    int ret = [self.iFlySpeechRecognizer writeAudio:audioBuffer];
    if (!ret)
    {
        [self.iFlySpeechRecognizer stopListening];
    }
}

- (void)onIFlyRecorderError:(IFlyPcmRecorder*)recoder theError:(int) error
{
    [self didError:nil];
}

- (void)onIFlyRecorderVolumeChanged:(int)power
{
    [self didVolumeChanged:power];
}

#pragma mark - Delegate

-(void)didStart{
    [self startCheckBeforeTimeout];
    [self startCheckTotalTimeout];
    if ([self.delegate respondsToSelector:@selector(speechRecognizerDidStart:)]) {
        [self.delegate speechRecognizerDidStart:self];
    }
}

-(void)didStopWithTimeoutType:(QQingSpeechRegonizerTimeoutType)timeoutType{
    self.timeoutType = timeoutType;
    [self cancelAllCheckTimeout];
    if ([self.delegate respondsToSelector:@selector(speechRecognizerDidStop:timeoutType:)]) {
        [self.delegate speechRecognizerDidStop:self timeoutType:timeoutType];
    }
}

-(void)didRecognizedResult:(NSString*)result{
    if (result.length) {
        [self cancelCheckBeforeTimeout];
        [self cancelCheckAfterTimeout];
    }
    if ([self.delegate respondsToSelector:@selector(speechRecognizer:resultSegment:)]) {
        [self.delegate speechRecognizer:self resultSegment:result];
    }
}

-(void)didSuccessResult:(NSString*)result{
    [self cancelAllCheckTimeout];
    if ([self.delegate respondsToSelector:@selector(speechRecognizer:successWithResult:timeoutType:)]) {
        [self.delegate speechRecognizer:self successWithResult:result timeoutType:self.timeoutType];
    }
}

-(void)didError:(IFlySpeechError*)error{
    [self cancelAllCheckTimeout];
    if ([self.delegate respondsToSelector:@selector(speechRecognizer:failedWithError:)]) {
        [self.delegate speechRecognizer:self failedWithError:error];
    }
}

-(void)didVolumeChanged:(int)power{
    if (power > 2) {
        [self cancelCheckBeforeTimeout];
        [self cancelCheckAfterTimeout];
        [self startCheckAfterTimeout];
    }
    
    if ([self.delegate respondsToSelector:@selector(speechRecognizer:recorderVolumeChanged:)]) {
        [self.delegate speechRecognizer:self recorderVolumeChanged:power];
    }
}

#pragma mark - Getter

-(NSMutableString*)result{
    if (_result == nil) {
        _result = [NSMutableString new];
    }
    return _result;
}

@end
