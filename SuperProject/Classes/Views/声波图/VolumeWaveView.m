//
//  VolumeWaveView.m
//  全靠浪
//
//  Created by 郭晓倩 on 17/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "VolumeWaveView.h"

static const int kDefaultLineCount = 3;
static const float kDefaultMaxVolume = 30;
static const float kDefaultMaxWaveHeight = 90;

@interface VolumeWaveView ()

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

- (instancetype)initWithFrame:(CGRect)frame maxVolume:(float)maxVolume maxWaveHeight:(float)maxWaveHeight {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        
        self.maxVolume = maxVolume;
        self.maxWaveHeight = maxWaveHeight;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
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
}

- (void)setStrokeColors:(NSArray<UIColor *> *)strokeColors {
    NSAssert(strokeColors.count == self.lineCount, @"颜色数量不对");
    
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

@end


