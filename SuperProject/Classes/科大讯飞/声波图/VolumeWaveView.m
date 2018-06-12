//
//  VolumeWaveView.m
//  全靠浪
//
//  Created by 郭晓倩 on 17/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "VolumeWaveView.h"
/**
    水波圆
*/

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
static const NSInteger maxCirleWidth = 210;
//速度变化率 越小速度越快
static const NSInteger chageSpeed = 20;
/////////////////////////////////////////////////

//////////////////////////////////////////////////





static const int kDefaultLineCount = 3;
static const float kDefaultMaxVolume = 30;
static const float kDefaultMaxWaveHeight = 90;

@interface VolumeWaveView ()
/**
 水波圆
 */

//当前界面上的layer总层数
@property (nonatomic) NSInteger layerCount;
//固定层
@property (nonatomic) NSInteger baseCount;
//声音变化值
@property (nonatomic) NSInteger voiceVolume;
////实心圆变化定时器
//@property (nonatomic, strong) NSTimer *schangeFrameTimer;
////生成空心圆定时器
//@property (nonatomic, strong) NSTimer *smakeRingTimer;
////扩散空心圆定时器
//@property (nonatomic, strong) NSTimer *schangeRingTimer;
////动画收回效果定时器
//@property (nonatomic ,strong) NSTimer *srecoverAnimationTimer;

@property (strong,nonatomic) CADisplayLink* schangeFrameTimer;
@property (strong,nonatomic) CADisplayLink* smakeRingTimer;
@property (strong,nonatomic) CADisplayLink* schangeRingTimer;
@property (strong,nonatomic) CADisplayLink* srecoverAnimationTimer;


/////////////////////////////////////////////////

//////////////////////////////////////////////////





@property (assign,nonatomic) int lineCount;
@property (assign,nonatomic) float maxVolume;
@property (assign,nonatomic) float maxWaveHeight;
@property (strong,nonatomic) NSMutableArray* shapeLayers;
@property (strong,nonatomic) NSArray<NSNumber*>* waveHeightRatioArray;
@property (strong,nonatomic) NSArray<NSNumber*>* speedArray;
@property (strong,nonatomic) NSArray<NSNumber*>* periodLengthArray;

@property (strong,nonatomic) CADisplayLink* displayLink;

@property (strong,nonatomic) NSMutableDictionary<NSNumber*,NSNumber*>* offsetXDic;

@property (nonatomic, assign) int displayLinkCount;

@end

@implementation VolumeWaveView
- (void)dealloc {
    _voiceVolume = 0;
    [_schangeFrameTimer invalidate];
    [_smakeRingTimer invalidate];
    [_schangeRingTimer invalidate];
    [_srecoverAnimationTimer invalidate];
    
    _srecoverAnimationTimer = nil;
    for (NSInteger t = _layerCount; t>=_baseCount; t--) {
        CALayer *layer = self.layer.sublayers[t];
        layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

//- (instancetype)initWithFrame:(CGRect)frame maxVolume:(float)maxVolume maxWaveHeight:(float)maxWaveHeight {
//    if (self = [super initWithFrame:frame]) {
//        [self commonInit];
//
//        self.maxVolume = maxVolume;
//        self.maxWaveHeight = maxWaveHeight;
//    }
//    return self;
//}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
        
        //水波圆
//        [self scommonInit];
    }
    
    return self;
}

/**
 水波圆
 */

-(void)scommonInit{
    self.backgroundColor = [UIColor whiteColor];
    //    CGSize size = frame.size;
    //动态圆
    CALayer *cirleLayer = [[CALayer alloc] init];
    cirleLayer.backgroundColor = CIRLE_CHANGE_COLOR;
    //         cirleLayer.backgroundColor = [UIColor redColor].CGColor;
    cirleLayer.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.frame.size.height/2);
    cirleLayer.bounds = CGRectMake(0, 0, cirleRadius*2, cirleRadius*2);
    cirleLayer.cornerRadius = cirleRadius;
    [self.layer addSublayer:cirleLayer];
    
    //添加话筒
    CALayer *microLayer = [[CALayer alloc] init];
    microLayer.backgroundColor = MICROPHONE_CHANGE_COLOR;
    //        microLayer.backgroundColor = [UIColor redColor].CGColor;
    microLayer.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.frame.size.height/2+15-micPhoneHeight/2);
    microLayer.bounds = CGRectMake(0, 0, micPhoneWidth, micPhoneHeight);
    [self.layer addSublayer:microLayer];
    
    
    //添加背景图片
    UIImage *mcImage = [UIImage imageNamed:@"microphone"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setImage:mcImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, mcImage.size.width, mcImage.size.height);
    button.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.frame.size.height/2);
    //    [button addTarget:self action:@selector(microPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    //画空心圆
    [self drawRing];
    
    _layerCount = 3;
    _baseCount = 3;
    _voiceVolume = -1;
}

- (void)commonInit {
    self.lineCount = kDefaultLineCount;
    self.maxVolume = kDefaultMaxVolume;
    self.maxWaveHeight = kDefaultMaxWaveHeight;
    
    for (CALayer *subLayer in self.layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
    
    self.shapeLayers = [NSMutableArray arrayWithCapacity:self.lineCount];
    self.offsetXDic = [NSMutableDictionary new];
    self.periodLengthArray = [NSMutableArray new];
    self.waveHeightRatioArray = [NSMutableArray new];
    self.speedArray = [NSMutableArray new];
    for (int i = 0; i < self.lineCount; ++i) {
        CAShapeLayer* shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 1;
        [self.layer addSublayer:shapeLayer];
        [self.shapeLayers addObject:shapeLayer];
        [self.offsetXDic setObject:@(0) forKey:@(i)];
        [(NSMutableArray*)self.periodLengthArray addObject:@(200)];
        [(NSMutableArray*)self.waveHeightRatioArray addObject:@(ABS(1 - i * 0.2))];
        [(NSMutableArray*)self.speedArray addObject:@(i * 2 + 3)];
    }
}

#pragma mark - Public

- (void)setVolume:(int)volume {
    _volume = MAX(5, volume);
     _voiceVolume = volume*13;
}

- (void)setStrokeColors:(NSArray<UIColor *> *)strokeColors {
    NSAssert(strokeColors.count == self.lineCount, @"颜色数量不对");
    
    //要想实现 水波圆 这里的东西需注解
    
    _strokeColors = strokeColors;

    for (int i=0; i < self.lineCount; ++i) {
        CAShapeLayer* shapeLayer = [self.shapeLayers objectAtIndex:i];
        UIColor* strokeColor = [strokeColors objectAtIndexIfIndexInBounds:i];
        shapeLayer.strokeColor = strokeColor.CGColor;
    }
}

- (void)start {
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(didDisplayLinkCome)];
    }
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    //水波圆
//    [self sstart];
}

- (void)stop {
    [_displayLink invalidate];
    _displayLink = nil;

    //清理视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i=0; i < self.lineCount; ++i) {
            CAShapeLayer* shapeLayer = [self.shapeLayers objectAtIndex:i];
            shapeLayer.path = NULL;
            [self.offsetXDic setObject:@(0) forKey:@(i)];
        }
    });
    
    //水波圆
//    [self sstop];
}

#pragma mark - Private

- (void)didDisplayLinkCome {
//    self.displayLinkCount++;
//    if ((self.displayLinkCount % 2) != 0) {
//        return;
//    }
//    
//    if (self.displayLinkCount >= 10000) {
//        self.displayLinkCount = (self.displayLinkCount % 2);
//    }
    
    for (int i=0; i<self.lineCount; ++i) {
        CAShapeLayer* shapeLayer = [self.shapeLayers objectAtIndex:i];
        float speed = [[self.speedArray objectAtIndex:i] floatValue];
        float offsetX = [[self.offsetXDic objectForKey:@(i)] floatValue] + speed;
        [self.offsetXDic setObject:@(offsetX) forKey:@(i)];
        float heightRatio = [[self.waveHeightRatioArray objectAtIndex:i] floatValue];
        float maxWaveHeight = self.maxWaveHeight * heightRatio;
        float waveHeight = ABS((self.volume / self.maxVolume) * MIN(maxWaveHeight, self.height/2));
        float periodWidth = [[self.periodLengthArray objectAtIndex:i] floatValue];
        CGMutablePathRef path = [self pathWithWaveWidth:self.width waveHeight:waveHeight periodWidth:periodWidth offsetX:offsetX];
        shapeLayer.path = path;
        CGPathRelease(path);
    }
}

- (CGMutablePathRef)pathWithWaveWidth:(float)waveWidth
                          waveHeight:(float)waveHeight
                          periodWidth:(float)periodWidth
                             offsetX:(float)offsetX {
    //声明第一条波曲线的路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    BOOL firstPoint = YES;
    CGFloat y = 0.f;
    //第一个波纹的公式
    for (float x = 0.f; x <= waveWidth ; x++) {
        y = (waveHeight/2) * sin(x/periodWidth * 2* M_PI - offsetX/periodWidth * 2* M_PI) + self.height / 2 ;
        if (firstPoint) {
            CGPathMoveToPoint(path, nil, x, y);
            firstPoint = NO;
        } else {
            CGPathAddLineToPoint(path, nil, x, y);
        }
        x++;
    }
    
    return path;
}



/*
 
     水波圆
 
 */

 
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
 

 #pragma mark private
 //实心圆和话筒震动
 - (void)changeFrame {
 if (_voiceVolume < 0) return;
 NSLog(@"================================实心圆和话筒震动");
 CGFloat v = _voiceVolume;
 CALayer *cirleLayer = self.layer.sublayers[0];
 CGFloat width;
 v = v * 150/100;
 width = v;
 if (width < 70) width = 70;
 if (width >150) width = 150;
 cirleLayer.bounds = CGRectMake(0, 0, width, width);
 cirleLayer.cornerRadius = width/2;
 
// v = _voiceVolume;
     v = 0;      //设置为0 说话时话筒不会出现
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
 NSLog(@"================================水波圆扩散");
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
 [_srecoverAnimationTimer invalidate];
 }
 }
- (void)sstart {
    if (_schangeFrameTimer == nil) {
        _schangeFrameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeFrame)];
    }
    [_schangeFrameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    if (_schangeRingTimer == nil) {
        _schangeRingTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeRing)];
    }
    [_schangeRingTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    if (_smakeRingTimer == nil) {
        _smakeRingTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawRing)];
    }
    [_smakeRingTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
    //    _changeFrameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
    //    _changeRingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeRing) userInfo:nil repeats:YES];
    //    _makeRingTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(drawRing) userInfo:nil repeats:YES];
    
    
    
    
    
    //        _changeFrameTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
    //        [[NSRunLoop mainRunLoop] addTimer:_changeFrameTimer forMode:NSRunLoopCommonModes];
    //        _changeRingTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(changeRing) userInfo:nil repeats:YES];
    //        [[NSRunLoop mainRunLoop] addTimer:_changeRingTimer forMode:NSRunLoopCommonModes];
    //
    //        _makeRingTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(drawRing) userInfo:nil repeats:YES];
    //        [[NSRunLoop mainRunLoop] addTimer:_makeRingTimer forMode:NSRunLoopCommonModes];
    
}

 - (void)sstop {
 
 [_schangeFrameTimer invalidate];
 [_schangeRingTimer invalidate];
 [_smakeRingTimer invalidate];
 
 _schangeRingTimer = nil;
 _schangeFrameTimer = nil;
 _smakeRingTimer = nil;
 
 _srecoverAnimationTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(recoverView)];
 [_srecoverAnimationTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
 
 //    _recoverAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(recoverView) userInfo:nil repeats:YES];
 
 for (NSInteger t = _layerCount; t>=_baseCount; t--) {
 CALayer *layer = self.layer.sublayers[t];
 layer.borderColor = [UIColor clearColor].CGColor;
 }
 }

 




@end


