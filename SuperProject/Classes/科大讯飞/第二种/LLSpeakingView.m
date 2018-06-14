//
//  LLSpeakingView.m
//  LLMicrophone
//
//  Created by 啸峰 on 16/6/11.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LLSpeakingView.h"
#define MICROPHONE_CHANGE_COLOR [UIColor colorWithRed:102/255.0 green:229/255.0 blue:1 alpha:1.0].CGColor
#define CIRLE_CHANGE_COLOR [UIColor colorWithRed:204/255.0 green:229/255.0 blue:1.0 alpha:1.0].CGColor
#define CIRLE_CHANGE_COLOR_WIDTH_OVER200 [UIColor colorWithRed:204/255.0 green:229/255.0 blue:1  alpha:0.5].CGColor
#define CIRLE_CHANGE_COLOR_WIDTH_OVER300 [UIColor colorWithRed:204/255.0 green:229/255.0 blue:1 alpha:0.2].CGColor

//长方形初始宽，高定义
static const NSInteger micPhoneHeight = 0;
static const NSInteger micPhoneWidth = 21;
//实心圆半径
static const NSInteger cirleRadius = 35;
//水波圆半径
static const NSInteger ringRadius = 46;
//圆扩大的上限范围:
static const NSInteger maxCirleWidth = 400;
//速度变化率 越小速度越快
static const NSInteger chageSpeed = 20;

@interface LLSpeakingView()

//当前界面上的layer总层数
@property (nonatomic) NSInteger layerCount;
//固定层
@property (nonatomic) NSInteger baseCount;
//声音变化值
@property (nonatomic) NSInteger voiceVolume;
//实心圆变化定时器
@property (nonatomic, strong) NSTimer *changeFrameTimer;
//生成空心圆定时器
@property (nonatomic, strong) NSTimer *makeRingTimer;
//扩散空心圆定时器
@property (nonatomic, strong) NSTimer *changeRingTimer;
//动画收回效果定时器
@property (nonatomic ,strong) NSTimer *recoverAnimationTimer;
@end

@implementation LLSpeakingView

- (void)dealloc {
    _voiceVolume = 0;
    [_changeFrameTimer invalidate];
    [_makeRingTimer invalidate];
    [_changeRingTimer invalidate];
    [_recoverAnimationTimer invalidate];
    for (NSInteger t = _layerCount; t>=_baseCount; t--) {
        CALayer *layer = self.layer.sublayers[t];
        layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGSize size = frame.size;
        //动态圆
        CALayer *cirleLayer = [[CALayer alloc] init];
        cirleLayer.backgroundColor = CIRLE_CHANGE_COLOR;
//         cirleLayer.backgroundColor = [UIColor redColor].CGColor;
        cirleLayer.position = CGPointMake(size.width/2, size.height/2);
        cirleLayer.bounds = CGRectMake(0, 0, cirleRadius*2, cirleRadius*2);
        cirleLayer.cornerRadius = cirleRadius;
        [self.layer addSublayer:cirleLayer];
        
        //添加话筒
        CALayer *microLayer = [[CALayer alloc] init];
        microLayer.backgroundColor = MICROPHONE_CHANGE_COLOR;
//        microLayer.backgroundColor = [UIColor redColor].CGColor;
        microLayer.position = CGPointMake(size.width/2, size.height/2+15-micPhoneHeight/2);
        microLayer.bounds = CGRectMake(0, 0, micPhoneWidth, micPhoneHeight);
        [self.layer addSublayer:microLayer];
        
        //添加背景图片
        UIImage *mcImage = [UIImage imageNamed:@"microphone"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:mcImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, mcImage.size.width, mcImage.size.height);
        button.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [button addTarget:self action:@selector(microPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //画空心圆
        [self drawRing];
        
        _layerCount = 3;
        _baseCount = 3;
        _voiceVolume = -1;
    }
    return self;
}




#pragma mark Animation
- (void)startSpeak {
    _changeFrameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
    _changeRingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeRing) userInfo:nil repeats:YES];
    _makeRingTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(drawRing) userInfo:nil repeats:YES];
}

- (void)stopSpeak {
    [_changeRingTimer invalidate];
    [_changeFrameTimer invalidate];
    [_makeRingTimer invalidate];
    _recoverAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(recoverView) userInfo:nil repeats:YES];
    for (NSInteger t = _layerCount; t>=_baseCount; t--) {
        CALayer *layer = self.layer.sublayers[t];
        layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

#pragma mark Action:
- (void)microPhoneAction:(id)sender {
    
}

//声音变化
- (void)volumeChange:(CGFloat)volume {
    _voiceVolume = volume;
    SUPLog(@"_voiceVolume = %zd",_voiceVolume);
}

#pragma mark private
//实心圆和话筒震动
- (void)changeFrame {
    if (_voiceVolume < 0) return;
     SUPLog(@"================================实心圆和话筒震动");
    CGFloat v = _voiceVolume;
    CALayer *cirleLayer = self.layer.sublayers[0];
    CGFloat width;
    v = v * 150/100;
    width = v;
    if (width < 70) width = 70;
    if (width >150) width = 150;
    cirleLayer.bounds = CGRectMake(0, 0, width, width);
    cirleLayer.cornerRadius = width/2;
    
    v = _voiceVolume;
    CALayer *microLayer = self.layer.sublayers[1];
    CGFloat height;
    v = v * 29/100;
    height = v;
    microLayer.bounds = CGRectMake(0, 0, micPhoneWidth, v);
    microLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+15-height/2);
}

//水波圆扩散
- (void)changeRing {
    if (_voiceVolume < 0) return;
    SUPLog(@"================================水波圆扩散");
    NSInteger t = _layerCount;
    for (; t>=_baseCount; t--) {
        CALayer *layer = self.layer.sublayers[t];
        CGFloat width = layer.bounds.size.width;
        if (width <= maxCirleWidth) {
            layer.borderColor = CIRLE_CHANGE_COLOR;
            width = width + width/chageSpeed;
            layer.bounds = CGRectMake(0, 0, width, width);
            layer.cornerRadius = width/2;
            if (width > 200) layer.borderColor = CIRLE_CHANGE_COLOR_WIDTH_OVER200;
            if (width > 350) layer.borderColor = CIRLE_CHANGE_COLOR_WIDTH_OVER300;
        } else {
            layer.borderColor = [UIColor clearColor].CGColor;
            _baseCount += 1;
        }
    }
}

//画水波圆
- (void)drawRing {
    if (_voiceVolume < 0) return;
    
    CGSize size = self.frame.size;
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.borderColor = [UIColor clearColor].CGColor;
    layer.borderWidth = 1/[[UIScreen mainScreen]scale];
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, ringRadius*2, ringRadius*2);
    layer.cornerRadius = ringRadius;
    [self.layer addSublayer:layer];
    _layerCount += 1;
}

//动画恢复
- (void)recoverView {
    //实心圆
    CALayer *cirleLayer = self.layer.sublayers[0];
    CGFloat width = cirleLayer.frame.size.width;
    if (width > 70) {
        width -= 10;
        if (width<70) width = 70;
        cirleLayer.bounds = CGRectMake(0, 0, width, width);
        cirleLayer.cornerRadius = width/2;
    }
    //麦克风
    CALayer *microLayer = self.layer.sublayers[1];
    CGFloat height = microLayer.frame.size.height;
    if (height > 0) {
        height -= 10;
        if (height<0) height = 0;
        microLayer.bounds = CGRectMake(0, 0, micPhoneWidth, height);
        microLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+15-height/2);
    }
    
    if (height==0 && width==70) {
        [_recoverAnimationTimer invalidate];
    }
}
@end
