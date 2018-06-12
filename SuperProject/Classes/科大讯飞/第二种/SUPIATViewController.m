//
//  SUPiatViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/6/11.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPIATViewController.h"
#import "iatConfig.h"
#import <QuartzCore/QuartzCore.h>
//#import <AVFoundation/AVAudioSession.h>
#import <AudioToolbox/AudioSession.h>
#import "PopupView.h"
#import "AlertView.h"
#import "TTSConfig.h"
#import "isrDataHelper.h"
#import "TKTTSManager.h"
#import "LLSpeakingView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define USERWORDS   @"{\"userword\":[{\"name\":\"我的常用词\",\"words\":[\"陈光\",\"何飞\",\"李叶敏\",\"杨晨\",\"杨富超\",\"杨阳\"]},{\"name\":\"我的好友\",\"words\":[\"陈光\",\"何飞\",\"李叶敏\",\"杨晨\",\"杨富超\",\"杨阳\"]}]}"
#define NAME        @"userwords"
@interface SUPIATViewController ()<UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *perTextField;
@property (nonatomic, strong) TKTTSManager *manger;
@property (nonatomic,assign)NSTimer * timer;
@property (nonatomic,assign)int volume;

@property (nonatomic, strong) LLSpeakingView *speakingView;
@property (nonatomic, strong) NSTimer *changeVolume;


@end

@implementation SUPIATViewController

- (IBAction)tanqi:(UIButton *)sender {

}

//这是另一种
- (void)stopAnimation {
    [_speakingView stopSpeak];
    [_changeVolume invalidate];
}

- (void)startAnimation {
    [self yuyinF];
    [_speakingView startSpeak];
    _changeVolume = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(changeVoice) userInfo:nil repeats:YES];
//    NSTimer *timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

- (void)changeVoice {
   int value = self.volume*10;
//    int value = self.volume;
    NSLog(@"value = %zd",value);
    [_speakingView volumeChange:value];
    
   
}

-(void)timerAction{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _manger = [TKTTSManager sharedInstance];
    self.uploader = [[IFlyDataUploader alloc] init];
    iatConfig *instance = [iatConfig sharedInstance];
    instance.language = [IFlySpeechConstant LANGUAGE_CHINESE];
    instance.accent = [IFlySpeechConstant ACCENT_MANDARIN];
    _audioPlayer = [[PcmPlayer alloc] init];
    [self createUI];
    _perTextField.delegate = self;
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    _speakingView = [[LLSpeakingView alloc] initWithFrame:CGRectMake(0, SUPScreenHeight-200, SUPScreenWidth, 200)];
    _speakingView.clipsToBounds = YES;
    [self.view addSubview:_speakingView];
    
//    [_speakingView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSMutableArray *contsArr = [[NSMutableArray alloc] init];
//    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(self.view,_speakingView);
    NSNumber *width = @(300);
//    NSDictionary *metrics = NSDictionaryOfVariableBindings(width);
//    [contsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[_speakingView]-0-|"]
//                                                                          options:0
//                                                                          metrics:nil
//                                                                            views:viewsDic]];
//
//    [contsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[_speakingView(width)]-0-|"]
//                                                                          options:0
//                                                                          metrics:metrics
//                                                                            views:viewsDic]];
//    [self.view addConstraints:contsArr];
    //开始动画按钮
    UIButton *starAnimationButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [starAnimationButon addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [starAnimationButon setTitle:@"开始动画" forState:UIControlStateNormal];
    [starAnimationButon setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:starAnimationButon];
    [starAnimationButon setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *saBtnContsArr = [[NSMutableArray alloc] init];
    width = @(100);
    NSNumber *height = @(40);
    NSDictionary *btnMetrics = NSDictionaryOfVariableBindings(width,height);
    NSDictionary *btnViewDic = NSDictionaryOfVariableBindings(self.view,starAnimationButon);
    [saBtnContsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[starAnimationButon(width)]"]
                                                                               options:0
                                                                               metrics:btnMetrics
                                                                                 views:btnViewDic]];
    
    [saBtnContsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[starAnimationButon(height)]"]
                                                                               options:0
                                                                               metrics:btnMetrics
                                                                                 views:btnViewDic]];
    
    [saBtnContsArr addObject:[NSLayoutConstraint constraintWithItem:starAnimationButon
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    
    [saBtnContsArr addObject:[NSLayoutConstraint constraintWithItem:starAnimationButon
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:150]];
    [self.view addConstraints:saBtnContsArr];
    
    //关闭动画
    UIButton *stopAnimationButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopAnimationButon addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
    [stopAnimationButon setTitle:@"结束动画" forState:UIControlStateNormal];
    [stopAnimationButon setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:stopAnimationButon];
    [stopAnimationButon setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *stBtnContsArr = [[NSMutableArray alloc] init];
    NSDictionary *stBtnViewDic = NSDictionaryOfVariableBindings(self.view,starAnimationButon,stopAnimationButon);
    [stBtnContsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[stopAnimationButon(width)]"]
                                                                               options:0
                                                                               metrics:btnMetrics
                                                                                 views:stBtnViewDic]];
    
    [stBtnContsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[starAnimationButon]-20-[stopAnimationButon(height)]"]
                                                                               options:0
                                                                               metrics:btnMetrics
                                                                                 views:stBtnViewDic]];
    
    [stBtnContsArr addObject:[NSLayoutConstraint constraintWithItem:stopAnimationButon
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    
    
    [self.view addConstraints:stBtnContsArr];
}

- (IBAction)uploadhotword:(UIButton *)sender {
    [self updateData];
}

-(void)updateData{
    [_iFlySpeechRecognizer stopListening];
    [_uploader setParameter:@"uup" forKey:[IFlySpeechConstant SUBJECT]];
    [_uploader setParameter:@"userword" forKey:[IFlySpeechConstant DATA_TYPE]];
    
    IFlyUserWords *iFlyUserWords = [[IFlyUserWords alloc] initWithJson:USERWORDS ];
    
    [_uploader uploadDataWithCompletionHandler:
     ^(NSString * grammerID, IFlySpeechError *error)
     {
         if (error.errorCode == 0) {
             //             _textView.text = @"佳晨实业\n蜀南庭苑\n高兰路\n复联二\n李馨琪\n鹿晓雷\n张集栋\n周家莉\n叶震珂\n熊泽萌\n";
             SUPLog(@"======success==========");
             [MBProgressHUD showAutoMessage:@"上传success"];
         }
         [self onUploadFinished:error];
     } name:NAME data:[iFlyUserWords toString]];
    
    
    
    //    //创建上传对象
    //    _uploader = [[IFlyDataUploader alloc] init];
    //    //用户词表
    ////#define USERWORDS   @"{\"userword\":[{\"name\":\"iflytek\",\"words\":[\"德国盐猪手\",\"1912酒吧街\",\"清蒸鲈鱼\",\"挪威三文鱼\",\"黄埔军校\",\"横沙牌坊\",\"科大讯飞\"]}]}"
    //    IFlyUserWords *iFlyUserWords = [[IFlyUserWords alloc] initWithJson:USERWORDS ];
    //    //设置上传参数
    //    [_uploader setParameter:@"uup" forKey:@"sub"];
    //    [_uploader setParameter:@"userword" forKey:@"dtt"];
    //    //启动上传（请注意name参数的不同）
    //    [_uploader uploadDataWithCompletionHandler:^(NSString * grammerID, IFlySpeechError *error){
    //        SUPLog(@"======success==========");
    //         [self onUploadFinished:error];
    //    }name: @"userwords" data:[iFlyUserWords toString]];
    
    
}
#pragma mark - IFlyDataUploaderDelegate

/**
 result callback of uploading contacts or customized words
 **/
- (void) onUploadFinished:(IFlySpeechError *)error
{
    NSLog(@"[error errorCode] = %d",[error errorCode]);
    
    if ([error errorCode] == 0) {
        [_popUpView showText: NSLocalizedString(@"T_ISR_UpSucc", nil)];
    }
    else {
        [_popUpView showText: [NSString stringWithFormat:@"%@:%d", NSLocalizedString(@"T_ISR_UpFail", nil), error.errorCode]];
        
    }
}



- (void)startSynBtnHandler:(NSString *)string {
    
    if ([string isEqualToString:@""]) {
        [_popUpView showText: NSLocalizedString(@"T_TTS_InvTxt", nil)];
        return;
    }
    
    if (_audioPlayer != nil && _audioPlayer.isPlaying == YES) {
        [_audioPlayer stop];
    }
    
    _synType = NomalType;
    
    //    self.hasError = NO;
    //    [NSThread sleepForTimeInterval:0.05];
    
    //    [_popUpView removeFromSuperview];
    //    self.isCanceled = NO;
    
    _iFlySpeechSynthesizer.delegate = self;
    
    NSString* str= string;
    
    [_iFlySpeechSynthesizer startSpeaking:str];
    
    if (_iFlySpeechSynthesizer.isSpeaking) {
        _state = Playing;
    }
}



-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s",__func__);
    
    if ([iatConfig sharedInstance].haveView == NO) {
        
        [_iFlySpeechRecognizer cancel];
        [_iFlySpeechRecognizer setDelegate:nil];
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        [_pcmRecorder stop];
        _pcmRecorder.delegate = nil;
    }
    else
    {
        [_iflyRecognizerView cancel];
        [_iflyRecognizerView setDelegate:nil];
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    }
    [super viewWillDisappear:animated];
    
    
    self.isViewDidDisappear = true;
    [_iFlySpeechSynthesizer stopSpeaking];
    [_audioPlayer stop];
    [_inidicateView hide];
    _iFlySpeechSynthesizer.delegate = nil;
    
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)startBtnHandler:(id)sender {
    [self yuyinF];
}

-(void)yuyinF{
    NSLog(@"%s[IN]",__func__);
    //    [self.manager connectToLast:^(NSError *error) {
    //                    SUPLog(@"connectToLast error=%@",error);
    //              }];
    //        [iatConfig sharedInstance].haveView = YES;
    
    if ([iatConfig sharedInstance].haveView == NO) {
        
        [_perTextField setText:@""];
        [_perTextField resignFirstResponder];
        self.isCanceled = NO;
        self.isStreamRec = NO;
        
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        
        [_iFlySpeechRecognizer cancel];
        
        //Set microphone as audio source
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //Set result type
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //Set the audio name of saved recording file while is generated in the local storage path of SDK,by default in library/cache.
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            //            [_audioStreamBtn setEnabled:NO];
            //            [_upWordListBtn setEnabled:NO];
            //            [_upContactBtn setEnabled:NO];
            
        }else{
            [_popUpView showText: NSLocalizedString(@"M_ISR_Fail", nil)];//Last session may be not over, recognition not supports concurrent multiplexing.
        }
    }else {
        
        if(_iflyRecognizerView == nil)
        {
            [self initRecognizer ];
        }
        
        [_perTextField setText:@""];
        [_perTextField resignFirstResponder];
        
        //Set microphone as audio source
        [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //Set result type
        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //Set the audio name of saved recording file while is generated in the local storage path of SDK,by default in library/cache.
        [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        BOOL ret = [_iflyRecognizerView start];
        if (ret) {
            //            [_startRecBtn setEnabled:NO];
            //            [_audioStreamBtn setEnabled:NO];
            //            [_upWordListBtn setEnabled:NO];
            //            [_upContactBtn setEnabled:NO];
        }
    }
    
    
}
#pragma mark - Initialization

/**
 initialize recognition conctol and set recognition params
 **/
-(void)initRecognizer
{
    NSLog(@"%s",__func__);
    
    if ([iatConfig sharedInstance].haveView == NO) {
        
        //recognition singleton without view
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        }
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //set recognition domain
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            iatConfig *instance = [iatConfig sharedInstance];
            
            //set timeout of recording
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //set VAD timeout of end of speech(EOS)
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //set VAD timeout of beginning of speech(BOS)
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //set network timeout
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //set sample rate, 16K as a recommended option
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //set language
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            
            //set whether or not to show punctuation in recognition results
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
        
        //Initialize recorder
        if (_pcmRecorder == nil)
        {
            _pcmRecorder = [IFlyPcmRecorder sharedInstance];
        }
        
        _pcmRecorder.delegate = self;
        
        [_pcmRecorder setSample:[iatConfig sharedInstance].sampleRate];
        
        [_pcmRecorder setSaveAudioPath:nil];    //not save the audio file
        
    }else  {
        
        //recognition singleton with view
        if (_iflyRecognizerView == nil) {
            
            _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        }
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //set recognition domain
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        
        _iflyRecognizerView.delegate = self;
        
        if (_iflyRecognizerView != nil) {
            iatConfig *instance = [iatConfig sharedInstance];
            //set timeout of recording
            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //set VAD timeout of end of speech(EOS)
            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //set VAD timeout of beginning of speech(BOS)
            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //set network timeout
            [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //set sample rate, 16K as a recommended option
            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //set language
            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            //set whether or not to show punctuation in recognition results
            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }
    
    if([[iatConfig sharedInstance].language isEqualToString:@"en_us"]){
        if([iatConfig sharedInstance].isTranslate){
            [self translation:NO];
        }
    }
    else{
        if([iatConfig sharedInstance].isTranslate){
            [self translation:YES];
        }
    }
    
}

-(void)translation:(BOOL) langIsZh
{
    
    if ([iatConfig sharedInstance].haveView == NO) {
        [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_SCH]];
        
        if(langIsZh){
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"translang"];
        }
        else{
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"translang"];
        }
        
        [_iFlySpeechRecognizer setParameter:@"translate" forKey:@"addcap"];
        
        [_iFlySpeechRecognizer setParameter:@"its" forKey:@"trssrc"];
    }
    else{
        [_iflyRecognizerView setParameter:@"1" forKey:[IFlySpeechConstant ASR_SCH]];
        
        if(langIsZh){
            [_iflyRecognizerView setParameter:@"cn" forKey:@"orilang"];
            [_iflyRecognizerView setParameter:@"en" forKey:@"translang"];
        }
        else{
            [_iflyRecognizerView setParameter:@"en" forKey:@"orilang"];
            [_iflyRecognizerView setParameter:@"cn" forKey:@"translang"];
        }
        
        [_iflyRecognizerView setParameter:@"translate" forKey:@"addcap"];
        
        [_iflyRecognizerView setParameter:@"its" forKey:@"trssrc"];
    }
    
    
}


-(void)setExclusiveTouchForButtons:(UIView *)myView
{
    for (UIView * button in [myView subviews]) {
        if([button isKindOfClass:[UIButton class]])
        {
            [((UIButton *)button) setExclusiveTouch:YES];
        }
        else if ([button isKindOfClass:[UIView class]])
        {
            [self setExclusiveTouchForButtons:button];
        }
    }
}

#pragma mark - IFlyPcmRecorderDelegate

- (void) onIFlyRecorderBuffer: (const void *)buffer bufferSize:(int)size
{
    NSData *audioBuffer = [NSData dataWithBytes:buffer length:size];
    
    int ret = [self.iFlySpeechRecognizer writeAudio:audioBuffer];
    if (!ret)
    {
        [self.iFlySpeechRecognizer stopListening];
        
    }
}

- (void) onIFlyRecorderError:(IFlyPcmRecorder*)recoder theError:(int) error
{
    
}

//range from 0 to 30
- (void) onIFlyRecorderVolumeChanged:(int) power
{
    //    NSLog(@"%s,power=%d",__func__,power);
    //
    //    if (self.isCanceled) {
    //        [_popUpView removeFromSuperview];
    //        return;
    //    }
    //
    //    NSString * vol = [NSString stringWithFormat:@"%@：%d", NSLocalizedString(@"T_RecVol", nil),power];
    //    [_popUpView showText: vol];
    //    SUPLog(@"%zd",power);
    
}

#pragma mark - IFlySpeechRecognizerDelegate

/**
 volume callback,range from 0 to 30.
 **/
- (void) onVolumeChanged: (int)volume
{
    
    
    //    SUPLog(@"volume == %zd",volume);
    self.volume = volume;
    
    //    if (self.isCanceled) {
    //        [_popUpView removeFromSuperview];
    //        return;
    //    }
    //    NSLocalizedString(@"T_RecVol", nil)
    //    NSString * vol = [NSString stringWithFormat:@"%@：%d",@"音量" ,volume];
    //    [_popUpView showText: vol];
    
    
}



/**
 Beginning Of Speech
 **/
- (void) onBeginOfSpeech
{
    NSLog(@"onBeginOfSpeech");
    
    if (self.isStreamRec == NO)
    {
        self.isBeginOfSpeech = YES;
        [_popUpView showText: NSLocalizedString(@"T_RecNow", nil)];
    }
}

/**
 End Of Speech
 **/
- (void) onEndOfSpeech
{
    NSLog(@"onEndOfSpeech");
    
    [_pcmRecorder stop];
    [_popUpView showText: NSLocalizedString(@"T_RecStop", nil)];
}


/**
 recognition session completion, which will be invoked no matter whether it exits error.
 error.errorCode =
 0     success
 other fail
 **/
- (void) onCompleted:(IFlySpeechError *) error
{
    NSLog(@"%s",__func__);
    
    if ([iatConfig sharedInstance].haveView == NO ) {
        
        NSString *text ;
        
        if (self.isCanceled) {
            text = NSLocalizedString(@"T_ISR_Cancel", nil);
            
        } else if (error.errorCode == 0 ) {
            if (_result.length == 0) {
                text = NSLocalizedString(@"T_ISR_NoRlt", nil);
            }else {
                text = NSLocalizedString(@"T_ISR_Succ", nil);
                //empty results
                _result = nil;
            }
        }else {
            text = [NSString stringWithFormat:@"Error：%d %@", error.errorCode,error.errorDesc];
            NSLog(@"%@",text);
        }
        
        [self stopAnimation];
        NSLog(@"定时器被取消");
        [_popUpView showText: text];
        
    }else {
        [_popUpView showText: NSLocalizedString(@"T_ISR_Succ", nil)];
        NSLog(@"errorCode:%d",[error errorCode]);
    }
}

/**
 result callback of recognition without view
 results：recognition results
 isLast：whether or not this is the last result
 **/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    _result =[NSString stringWithFormat:@"%@%@", _perTextField.text,resultString];
    
    NSString * resultFromJson =  nil;
    
    if([iatConfig sharedInstance].isTranslate){
        
        NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //The result type must be utf8, otherwise an unknown error will happen.
                                    [resultString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if(resultDic != nil){
            NSDictionary *trans_result = [resultDic objectForKey:@"trans_result"];
            
            if([[iatConfig sharedInstance].language isEqualToString:@"en_us"]){
                NSString *dst = [trans_result objectForKey:@"dst"];
                NSLog(@"dst=%@",dst);
                resultFromJson = [NSString stringWithFormat:@"%@\ndst:%@",resultString,dst];
            }
            else{
                NSString *src = [trans_result objectForKey:@"src"];
                NSLog(@"src=%@",src);
                resultFromJson = [NSString stringWithFormat:@"%@\nsrc:%@",resultString,src];
            }
        }
    }
    else{
        resultFromJson = [isrDataHelper stringFromJson:resultString];
    }
    
    //    _perTextField.text = [NSString stringWithFormat:@"%@%@", _perTextField.text,resultFromJson];
    
    NSString * str1 = [[NSString stringWithFormat:@"%@%@", _perTextField.text,resultFromJson] stringByReplacingOccurrencesOfString:@"，" withString:@""];
    NSString * str = [str1 stringByReplacingOccurrencesOfString:@"。" withString:@""];
    //    str = [str stringByReplacingOccurrencesOfString:@"查找" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    _perTextField.text = str;
    NSLog(@"str.length = %zd=%@=",str.length,str);
    
    
    
    
    if (isLast){
        NSLog(@"ISR Results(json)：%@",  self.result);
    }
    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_perTextField.text=%@",isLast,_perTextField.text);
}



/**
 result callback of recognition with view
 resultArray：recognition results
 isLast：whether or not this is the last result
 **/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString * resultFromJson =  nil;
    
    if([iatConfig sharedInstance].isTranslate){
        
        NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //The result type must be utf8, otherwise an unknown error will happen.
                                    [resultString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if(resultDic != nil){
            NSDictionary *trans_result = [resultDic objectForKey:@"trans_result"];
            
            if([[iatConfig sharedInstance].language isEqualToString:@"en_us"]){
                NSString *dst = [trans_result objectForKey:@"dst"];
                NSLog(@"dst=%@",dst);
                resultFromJson = [NSString stringWithFormat:@"%@\ndst:%@",resultString,dst];
            }
            else{
                NSString *src = [trans_result objectForKey:@"src"];
                NSLog(@"src=%@",src);
                resultFromJson = [NSString stringWithFormat:@"%@\nsrc:%@",resultString,src];
            }
        }
    }
    else{
        resultFromJson = [NSString stringWithFormat:@"%@",resultString];//;[ISRDataHelper stringFromJson:resultString];
    }
    
    //    _perTextField.text = [NSString stringWithFormat:@"%@%@", _perTextField.text,resultFromJson];
    NSString * str1 = [[NSString stringWithFormat:@"%@%@", _perTextField.text,resultFromJson] stringByReplacingOccurrencesOfString:@"，" withString:@""];
    NSString * str = [str1 stringByReplacingOccurrencesOfString:@"。" withString:@""];
    //    str = [str stringByReplacingOccurrencesOfString:@"查找" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    _perTextField.text = str;
    NSLog(@"str.length = %zd=%@=",str.length,str);
    
    
}



/**
 callback of canceling recognition
 **/
- (void) onCancel
{
    NSLog(@"Recognition is cancelled");
}

-(void) showPopup
{
    [_popUpView showText: NSLocalizedString(@"T_ISR_Uping", nil)];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initRecognizer];
    [self initSynthesizer];
    
}


#pragma mark - Initialization

- (void)initSynthesizer
{
    TTSConfig *instance = [TTSConfig sharedInstance];
    if (instance == nil) {
        return;
    }
    
    //TTS singleton
    if (_iFlySpeechSynthesizer == nil) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    }
    
    _iFlySpeechSynthesizer.delegate = self;
    
    //set the resource path, only for offline TTS
    NSString *resPath = [[NSBundle mainBundle] resourcePath];
    NSString *newResPath = [[NSString alloc] initWithFormat:@"%@/aisound/common.jet;%@/aisound/xiaoyan.jet",resPath,resPath];
    [[IFlySpeechUtility getUtility] setParameter:@"tts" forKey:[IFlyResourceUtil ENGINE_START]];
    [_iFlySpeechSynthesizer setParameter:newResPath forKey:@"tts_res_path"];
    
    //set speed,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.speed forKey:[IFlySpeechConstant SPEED]];
    
    //set volume,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.volume forKey:[IFlySpeechConstant VOLUME]];
    
    //set pitch,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.pitch forKey:[IFlySpeechConstant PITCH]];
    
    //set sample rate
    [_iFlySpeechSynthesizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    //set TTS speaker
    [_iFlySpeechSynthesizer setParameter:instance.vcnName forKey:[IFlySpeechConstant VOICE_NAME]];
    
    //set text encoding mode
    [_iFlySpeechSynthesizer setParameter:@"unicode" forKey:[IFlySpeechConstant TEXT_ENCODING]];
    
    //set engine type
    [_iFlySpeechSynthesizer setParameter:instance.engineType forKey:[IFlySpeechConstant ENGINE_TYPE]];
    
    NSDictionary* languageDic=@{@"catherine":@"text_english",//English
                                @"XiaoYun":@"text_vietnam",//Vietnamese
                                @"Abha":@"text_hindi",//Hindi
                                @"Gabriela":@"text_spanish",//Spanish
                                @"Allabent":@"text_russian",//Russian
                                @"Mariane":@"text_french"};//French
    
    NSString* textNameKey=[languageDic valueForKey:instance.vcnName];
    NSString* textSample=nil;
    
    if(textNameKey && [textNameKey length]>0){
        textSample=NSLocalizedStringFromTable(textNameKey, @"tts/tts", nil);
    }else{
        textSample=NSLocalizedStringFromTable(@"text_chinese", @"tts/tts", nil);
    }
    
    //    [_textView setText:textSample];
    SUPLog(@"textSample == %@",textSample);
}







-(void)createUI{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(30, HEIGHT-260, (WIDTH-90)/2, 40);
    [button setTitle:@"按住录音" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.layer.cornerRadius = 20;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(voiceBtnClickDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(voiceBtnClickCancel:) forControlEvents:UIControlEventTouchCancel];
    [button addTarget:self action:@selector(voiceBtnClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(voiceBtnClickDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [button addTarget:self action:@selector(voiceBtnClickUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [button addTarget:self action:@selector(voiceBtnClickDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [self.view addSubview:button];
}


-(void)voiceBtnClickDown:(UIButton *)btn{//按下
    
    
    if ([_iFlySpeechRecognizer startListening]) {
        [_iFlySpeechRecognizer cancel];
        _iFlySpeechRecognizer = nil;
    }
    
    [self yuyinF];
    
    NSLog(@"按下");
    
    [btn setTitle:@"松开完成" forState:UIControlStateNormal];
    
    UIView * recordView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-100, HEIGHT/2-100, 200, 200)];
    
    recordView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    recordView.tag = 101;
    UIImageView * micImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*50/720, HEIGHT*66/1280,WIDTH*280/720, HEIGHT*200/1280)];
    micImg.contentMode = UIViewContentModeLeft;
    [micImg setImage:[UIImage imageNamed:@"chat_microphone_1"]];
    micImg.backgroundColor = [UIColor clearColor];
    micImg.tag = 135;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(voiceChange:) userInfo:nil repeats:YES];
    
    UIImageView * micImgCan = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*120/720, HEIGHT*66/1280,WIDTH*140/720, HEIGHT*200/1280)];
    micImgCan.backgroundColor = [UIColor clearColor];
    micImgCan.image = [UIImage imageNamed:@"chat_microphone_cancel"];
    micImgCan.tag = 134;
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(micImg.frame)+HEIGHT*60/1280, 160, HEIGHT*60/1280)];
    label.tag = 136;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"手指上滑,取消发送";
    
    
    micImgCan.hidden = YES;
    micImg.hidden = NO;
    
    [recordView addSubview:label];
    [recordView addSubview:micImg];
    [recordView addSubview:micImgCan];
    
    [self.view addSubview:recordView];
}

-(void)voiceChange:(NSTimer *)timer{
    
    UIView * view = [self.view viewWithTag:101];
    
    UIImageView * micImg = [view viewWithTag:135];
    
    CGFloat lowPassResults =self.volume*0.05;
    NSLog(@"lowPassResults = %f",lowPassResults);
    
    //  根据音量大小选择显示图片  图片 小-》大
    if (0<lowPassResults<=0.14) {
        [micImg setImage:[UIImage imageNamed:@"chat_microphone_1"]];
    }else if (0.14<lowPassResults<=0.28) {
        [micImg setImage:[UIImage imageNamed:@"chat_microphone_2"]];
    }else if (0.28<lowPassResults<=0.42) {
        [micImg setImage:[UIImage imageNamed:@"chat_microphone_3"]];
    }else if (0.42<lowPassResults<=0.56) {
        [micImg setImage:[UIImage imageNamed:@"chat_microphone_4"]];
    }else if (0.56<lowPassResults<=0.70) {
        [micImg setImage:[UIImage imageNamed:@"chat_microphone_5"]];
    }else if (0.70<lowPassResults<=0.84) {
        [micImg setImage:[UIImage imageNamed:@"chat_microphone_6"]];
    }else if (0.84<lowPassResults) {
        [micImg setImage:[UIImage imageNamed:@"chat_microphone_7"]];
    }
    
}


-(void)voiceBtnClickCancel:(UIButton *)btn{//意外取消
    NSLog(@"意外取消");
    [btn setTitle:@"松开完成" forState:UIControlStateNormal];
    
    UIView * view = [self.view viewWithTag:101];
    [view removeFromSuperview];
    [_iFlySpeechRecognizer stopListening];
    
    //    if ([_iFlySpeechRecognizer startListening]) {
    //
    //
    //    }
    
    if (_timer.isValid) {//判断timer是否在线程中
        [_timer invalidate];
    }
    _timer=nil;
    
    
}
-(void)voiceBtnClickUpInside:(UIButton *)btn{//点击(录音完成)
    NSLog(@"点击");
    [btn setTitle:@"按住录音" forState:UIControlStateNormal];
    UIView * view = [self.view viewWithTag:101];
    [view removeFromSuperview];
    [_iFlySpeechRecognizer stopListening];
    
    //    if ([_iFlySpeechRecognizer startListening]) {
    //        [_iFlySpeechRecognizer stopListening];
    //
    //    }
    _iFlySpeechRecognizer = nil;
    if (_timer.isValid) {
        [_timer invalidate];
    }
    _timer=nil;
    
}
-(void)voiceBtnClickDragExit:(UIButton *)btn{//拖出
    NSLog(@"拖出");
    
    [btn setTitle:@"按住录音" forState:UIControlStateNormal];
    UIView * view = [self.view viewWithTag:101];
    UIImageView * micImg = [view viewWithTag:135];
    micImg.hidden = YES;
    UIImageView * micImgCan = [view viewWithTag:134];
    micImgCan.hidden = NO;
    
    UILabel * alertLab = [view viewWithTag:136];
    alertLab.backgroundColor = [UIColor colorWithRed:255/255.0 green:128/255.0 blue:158/255.0 alpha:1];
    
}
-(void)voiceBtnClickUpOutside:(UIButton *)btn{//外部手势抬起
    NSLog(@"外部手势抬起");
    
    [btn setTitle:@"按住录音" forState:UIControlStateNormal];
    
    UIView * view = [self.view viewWithTag:101];
    [view removeFromSuperview];
    
    [_iFlySpeechRecognizer stopListening];
    //    if ([_iFlySpeechRecognizer startListening]) {
    //        [_iFlySpeechRecognizer stopListening];
    //
    //    }
    _iFlySpeechRecognizer = nil;
    
    if (_timer.isValid) {
        [_timer invalidate];
    }
    _timer=nil;
    
}

-(void)voiceBtnClickDragEnter:(UIButton *)btn{//拖回
    NSLog(@"拖回");
    
    [btn setTitle:@"松开完成" forState:UIControlStateNormal];
    UIView * view = [self.view viewWithTag:101];
    UIImageView * micImg = [view viewWithTag:135];
    micImg.hidden = NO;
    UIImageView * micImgCan = [view viewWithTag:134];
    micImgCan.hidden = YES;
    UILabel * alertLab = [view viewWithTag:136];
    alertLab.backgroundColor = [UIColor clearColor];
    
}


@end

