//
//  QQingSTTBottomVC.m
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "QQingSTTBottomVC.h"

@interface QQingSTTBottomVC () <QQingSpeechRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *tipTitleLabel;
@property (weak, nonatomic) IBOutlet VolumeWaveView *volumeWavView;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (nonatomic, strong) BaseSTTInputHandler *inputHandler;
@property (nonatomic, strong) QQingSpeechRecognizer *speechRecognizer;

@property (nonatomic, assign) BOOL isRecognizing;

@end

@implementation QQingSTTBottomVC

#pragma mark - View life cycle

- (instancetype)initWithSTTInputHandler:(BaseSTTInputHandler *)inputHandler {
    if (self = [super init]) {
        self.inputHandler = inputHandler;
        self.speechRecognizer = [[QQingSpeechRecognizer alloc] init];
        self.speechRecognizer.delegate = self;
    }
    
    return self;
}

+ (instancetype)sttBottomVCWithSTTInputHandler:(BaseSTTInputHandler *)inputHandler {
    if (!inputHandler) {
        return nil;
    }
    
    return [[QQingSTTBottomVC alloc] initWithSTTInputHandler:inputHandler];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startSpeechRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Overriden methods

- (CGFloat)preferredContentHeight {
    return 200;
}

#pragma mark - Private methods

- (void)initUI {
    self.view.layer.shadowOffset = CGSizeMake(2, -2);
    self.view.layer.shadowOpacity = 0.1;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.volumeWavView.strokeColors = [NSArray arrayWithObjects:RGB(153, 153, 153), RGB(175, 175, 175), RGB(200, 200, 200), nil];
}

- (void)setIsRecognizing:(BOOL)isRecognizing {
    _isRecognizing = isRecognizing;
    
    if (_isRecognizing) {
        [self.startStopButton setImage:nil forState:UIControlStateNormal];
        [self.startStopButton setTitle:@"我说完了" forState:UIControlStateNormal];
        
        self.tipTitleLabel.text = @"请说出您想输入的内容";
        
        [self.volumeWavView start];
    } else {
        [self.startStopButton setImage:[UIImage imageNamed:@"icon_start.png"] forState:UIControlStateNormal];
        [self.startStopButton setTitle:nil forState:UIControlStateNormal];
        
        self.tipTitleLabel.text = @"";  // 好像没听清您说的话
        
        [self.volumeWavView stop];
    }
}

- (void)startSpeechRecognizer {
    self.isRecognizing = YES;
    
    [self.speechRecognizer start];
}

- (void)stopSpeechRecognizer {
    [self.speechRecognizer stop];
    
    [self dismissWithAnimated:YES];
}

- (void)didStopSpeechRecognizer {
    self.isRecognizing = NO;
}

#pragma mark - QQingSpeechRecognizerDelegate

- (void)speechRecognizerDidStop:(QQingSpeechRecognizer *)recognizer timeoutType:(QQingSpeechRegonizerTimeoutType)timeoutType {
    NSLog (@"==speechRecognizerDidStop:timeoutType: %ld", timeoutType);
    
    switch (timeoutType) {
        case QQingSpeechRegonizerTimeoutType_Before: {
            [self didStopSpeechRecognizer];
            
            self.tipTitleLabel.text = @"好像没听清您说的话";
        }
            break;
        case QQingSpeechRegonizerTimeoutType_After: {
            [self didStopSpeechRecognizer];
            
            self.tipTitleLabel.text = @"好像没听清您说的话";
        }
            break;
        case QQingSpeechRegonizerTimeoutType_Total: {
            [self didStopSpeechRecognizer];
            
            self.tipTitleLabel.text = @"您说的时间太久了，休息一下吧";
        }
            break;
        default: {
            [self didStopSpeechRecognizer];
            
            self.tipTitleLabel.text = @"请说出您想输入的内容";
        }
            break;
    }
}

- (void)speechRecognizer:(QQingSpeechRecognizer *)recognizer resultSegment:(NSString *)resultSegment {
    NSLog (@"==speechRecognizer:resultSegment: %@", resultSegment);
    
    [self.inputHandler handleAppendText:resultSegment];
}

- (void)speechRecognizer:(QQingSpeechRecognizer *)recognizer successWithResult:(NSString *)result timeoutType:(QQingSpeechRegonizerTimeoutType)timeoutType {
    NSLog (@"==speechRecognizer:successWithResult: %@ timeoutType:%ld", result, timeoutType);

    switch (timeoutType) {
        case QQingSpeechRegonizerTimeoutType_Before: {
            [self didStopSpeechRecognizer];
            
            self.tipTitleLabel.text = @"好像没听清您说的话";
        }
            break;
        case QQingSpeechRegonizerTimeoutType_After: {
            [self didStopSpeechRecognizer];
            
            self.tipTitleLabel.text = @"好像没听清您说的话";
        }
            break;
        case QQingSpeechRegonizerTimeoutType_Total: {
            [self didStopSpeechRecognizer];
            
            self.tipTitleLabel.text = @"您说的时间太久了，休息一下吧";
        }
            break;
        default: {
            [self didStopSpeechRecognizer];
            
            self.tipTitleLabel.text = @"请说出您想输入的内容";
        }
            break;
    }
}

- (void)speechRecognizer:(QQingSpeechRecognizer *)recognizer failedWithError:(IFlySpeechError *)error {
    NSLog (@"==speechRecognizer:failedWithError: %@", error);
    
    [self didStopSpeechRecognizer];
    
    self.tipTitleLabel.text = @"好像没听清您说的话";
}

- (void)speechRecognizer:(QQingSpeechRecognizer *)recognizer recorderVolumeChanged:(int)power {
//    NSLog (@"==speechRecognizer:recorderVolumeChanged: %d", power);
    
    self.volumeWavView.volume = power;
}

#pragma mark - IBActions

- (void)didTappedOnBackgroundView:(UIGestureRecognizer *)sender {
    [super didTappedOnBackgroundView:sender];
    
    if (self.isRecognizing) {
        [self stopSpeechRecognizer];
    }
}

- (IBAction)didClickCloseButtonAction:(id)sender {
    [self didTappedOnBackgroundView:nil];
}

- (IBAction)didClickStartStopButtonAction:(id)sender {
    if (self.isRecognizing) {
        [self stopSpeechRecognizer];
    } else {
        [self startSpeechRecognizer];
    }
}

@end


