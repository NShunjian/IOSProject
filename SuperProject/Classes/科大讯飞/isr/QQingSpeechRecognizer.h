//
//  IATViewController.h
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-28.
//
//

#import "IATConfig.h"
#import <iflyMSC/IFlySpeechError.h>

typedef NS_ENUM(NSUInteger, QQingSpeechRegonizerTimeoutType) {
    QQingSpeechRegonizerTimeoutType_None = 0,
    QQingSpeechRegonizerTimeoutType_Before,
    QQingSpeechRegonizerTimeoutType_After,
    QQingSpeechRegonizerTimeoutType_Total,
};

@protocol QQingSpeechRecognizerDelegate;
@interface QQingSpeechRecognizer : NSObject

@property (weak,nonatomic) id<QQingSpeechRecognizerDelegate> delegate;

- (void)start;
- (void)stop;

@end

@protocol QQingSpeechRecognizerDelegate <NSObject>
@optional
-(IATConfig*)speechRecognizerWillConfig:(QQingSpeechRecognizer*)recognizer;
-(void)speechRecognizerDidStart:(QQingSpeechRecognizer*)recognizer;
-(void)speechRecognizerDidStop:(QQingSpeechRecognizer*)recognizer timeoutType:(QQingSpeechRegonizerTimeoutType)timeoutType;
-(void)speechRecognizer:(QQingSpeechRecognizer*)recognizer resultSegment:(NSString*)resultSegment;
-(void)speechRecognizer:(QQingSpeechRecognizer*)recognizer successWithResult:(NSString*)result timeoutType:(QQingSpeechRegonizerTimeoutType)timeoutType;
-(void)speechRecognizer:(QQingSpeechRecognizer*)recognizer failedWithError:(IFlySpeechError*)error;
//power:0-30
-(void)speechRecognizer:(QQingSpeechRecognizer*)recognizer recorderVolumeChanged:(int)power;

@end
