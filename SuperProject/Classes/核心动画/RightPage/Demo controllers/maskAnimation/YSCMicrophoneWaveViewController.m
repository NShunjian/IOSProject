//
//  YSCMicrophoneWaveViewController.m
//  YSCAnimationDemo
//
//  Created by yushichao on 16/8/23.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "YSCMicrophoneWaveViewController.h"
#import "YSCMicrophoneWaveView.h"

@interface YSCMicrophoneWaveViewController ()
@property(nonatomic, strong)YSCMicrophoneWaveView *microphoneWaveView;
@end

@implementation YSCMicrophoneWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _microphoneWaveView = [[YSCMicrophoneWaveView alloc] init];
    [_microphoneWaveView showMicrophoneWaveInParentView:self.view withFrame:self.view.bounds];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_microphoneWaveView closeMicroPhoneTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
