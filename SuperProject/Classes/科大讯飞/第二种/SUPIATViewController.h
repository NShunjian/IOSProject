//
//  SUPIATViewController.h
//  SuperProject
//
//  Created by NShunJian on 2018/6/11.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "IFlyMSC/IFlyMSC.h"
#import "PcmPlayer.h"

@class AlertView;
@class PopupView;
@class IFlySpeechSynthesizer;
@class SUPIATViewController;
typedef NS_OPTIONS(NSInteger, SynthesizeType) {
    NomalType           = 5,    //Normal TTS
    UriType             = 6,    //URI TTS
};

//state of TTS
typedef NS_OPTIONS(NSInteger, Status) {
    NotStart            = 0,
    Playing             = 2,
    Paused              = 4,
};

@protocol SUPSpeechRecognizerDelegate <NSObject>

-(void)speechRecognizer:(SUPIATViewController*)recognizer recorderVolumeChanged:(int)power;
@end


@interface SUPIATViewController : UIViewController<IFlySpeechRecognizerDelegate,IFlyRecognizerViewDelegate,IFlyPcmRecorderDelegate,IFlySpeechSynthesizerDelegate>
//不带界面的识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic, strong) PopupView *popUpView;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//Recognition control with view
@property (nonatomic, strong) IFlyDataUploader *uploader;//upload control
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//PCM Recorder to be used to demonstrate Audio Stream Recognition.

@property (nonatomic,assign) BOOL isStreamRec;//Whether or not it is Audio Stream function
@property (nonatomic,assign) BOOL isBeginOfSpeech;//Whether or not SDK has invoke the delegate methods of beginOfSpeech.

@property (nonatomic, strong) NSString * result;

@property (nonatomic, assign) Status state;
@property (nonatomic, assign) SynthesizeType synType;
@property (nonatomic, strong) PcmPlayer *audioPlayer;
@property (nonatomic, assign) BOOL isCanceled;
@property (nonatomic, assign) BOOL hasError;
@property (nonatomic, assign) BOOL isViewDidDisappear;
@property (nonatomic, strong) AlertView *inidicateView;
@property (nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;
@property (weak,nonatomic) id<SUPSpeechRecognizerDelegate> delegate;
@end
