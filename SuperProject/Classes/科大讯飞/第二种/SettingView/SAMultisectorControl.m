//
//  SAMultisectorControl.m
//  CustomControl
//
//  Created by Snipter on 12/31/13.
//  Copyright (c) 2013 SmartAppStudio. All rights reserved.
//

#import "SAMultisectorControl.h"

#define saCircleLineWidth 2.0
#define saMarkersLineWidth 2.0

typedef struct{
    CGPoint circleCenter;//整个绘画的center
    CGFloat radius;//半径
    
    double fullLine; //最大值最小值相减，除以周长可以得到单位长度的插值，在某一点也可以得到这一点的数值
    double circleOffset;//第一个marker，与最小值之间的距离
    double circleLine;//endvalue － startvalue
    double circleEmpty;
    
    double circleOffsetAngle;//
    double circleLineAngle;
    double circleEmptyAngle;
    
    CGPoint startMarkerCenter;//开始圈圈的center
    CGPoint endMarkerCenter;//结束圈圈的center
    
    CGFloat startMarkerRadius;//开始圈圈的半径
    CGFloat endMarkerRadius;//结束圈圈的半径
    
    CGFloat startMarkerFontSize;//开始圈圈的字体
    CGFloat endMarkerFontize;//结束圈圈的字体
    
    CGFloat startMarkerAlpha;//开始圈圈的透明度
    CGFloat endMarkerAlpha;//结束圈圈的透明度
    
} SASectorDrawingInformation;


@implementation SAMultisectorControl{
    NSMutableArray *sectorsArray;
    
    SAMultisectorSector *trackingSector;
    SASectorDrawingInformation trackingSectorDrawInf;
    BOOL trackingSectorStartMarker;
}

#pragma mark - Initializators

- (instancetype)init{
    if(self = [super init]){
        [self setupDefaultConfigurations];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupDefaultConfigurations];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupDefaultConfigurations];
    }
    return self;
}

- (void) setupDefaultConfigurations{
    sectorsArray = [NSMutableArray new];
//    self.sectorsRadius = 45.0;//默认的半径，如果有一个sector，那么这个sector半径位45，如果有两个，第二个的半径时90
    self.sectorsRadius = 40.0f;
    self.backgroundColor = [UIColor clearColor];
    self.startAngle = toRadians(270);
    self.minCircleMarkerRadius = 10.0;
    self.maxCircleMarkerRadius = 50;
}

#pragma mark - Setters

- (void)setSectorsRadius:(double)sectorsRadius{
    _sectorsRadius = sectorsRadius;
    [self setNeedsDisplay];
}

#pragma mark - Sectors manipulations

- (void)addSector:(SAMultisectorSector *)sector{
    [sectorsArray addObject:sector];
    [self setNeedsDisplay];
}

- (void)removeSector:(SAMultisectorSector *)sector{
    [sectorsArray removeObject:sector];
    [self setNeedsDisplay];
}

- (void)removeAllSectors{
    [sectorsArray removeAllObjects];
    [self setNeedsDisplay];
}

- (NSArray *)sectors{
    return sectorsArray;
}

#pragma mark - Events manipulator

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchPoint = [touch locationInView:self];
    
    for(NSUInteger i = 0; i < sectorsArray.count; i++){
        SAMultisectorSector *sector = sectorsArray[i];
        NSUInteger position = i + 1;
        SASectorDrawingInformation drawInf =[self sectorToDrawInf:sector position:position];
        
        if([self touchInCircleWithPoint:touchPoint circleCenter:drawInf.endMarkerCenter]){
            trackingSector = sector;
            trackingSectorDrawInf = drawInf;
            trackingSectorStartMarker = NO;
            return YES;
        }
        
        if([self touchInCircleWithPoint:touchPoint circleCenter:drawInf.startMarkerCenter]){
            return NO;//禁止开始的marker 滑动
//            trackingSector = sector;
//            trackingSectorDrawInf = drawInf;
//            trackingSectorStartMarker = YES;
//            return YES;
        }
        
    }
    return NO;
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint ceter = [self multiselectCenter];
    SAPolarCoordinate polar = decartToPolar(ceter, touchPoint);
    
    double correctedAngle;
    if(polar.angle < self.startAngle) correctedAngle = polar.angle + (2 * M_PI - self.startAngle);
    else correctedAngle = polar.angle - self.startAngle;
    
    double procent = correctedAngle / (M_PI * 2);
    
    double newValue = procent * (trackingSector.maxValue - trackingSector.minValue) + trackingSector.minValue;
    
    if(trackingSectorStartMarker){
        if(newValue > trackingSector.startValue){
            double diff = newValue - trackingSector.startValue;
            if(diff > ((trackingSector.maxValue - trackingSector.minValue)/2)){
                trackingSector.startValue = trackingSector.minValue;
                [self valueChangedNotification];
                [self setNeedsDisplay];
                return YES;
            }
        }
        if(newValue >= trackingSector.endValue){
            trackingSector.startValue = trackingSector.endValue;
            [self valueChangedNotification];
            [self setNeedsDisplay];
            return YES;
        }
        trackingSector.startValue = newValue;
        [self valueChangedNotification];
    }
    else{
        if(newValue < trackingSector.endValue){
            double diff = trackingSector.endValue - newValue;
            if(diff > ((trackingSector.maxValue - trackingSector.minValue)/2)){
                trackingSector.endValue = trackingSector.maxValue;
                [self valueChangedNotification];
                [self setNeedsDisplay];
                return YES;
            }
        }
        if(newValue <= trackingSector.startValue){
            trackingSector.endValue = trackingSector.startValue;
            [self valueChangedNotification];
            [self setNeedsDisplay];
            return YES;
        }
        trackingSector.endValue = newValue;
        [self valueChangedNotification];
    }
    
    [self setNeedsDisplay];
    
    return YES;
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    trackingSector = nil;
    trackingSectorStartMarker = NO;
}

- (CGPoint) multiselectCenter{
    return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}


/**
 并不是完全判断在一个marker圈圈内
 这里的判断半径，是个随意的值，选
 择的是_sectorsRaiusds/2
 ****/
- (BOOL) touchInCircleWithPoint:(CGPoint)touchPoint circleCenter:(CGPoint)circleCenter{
    SAPolarCoordinate polar = decartToPolar(circleCenter, touchPoint);
    if(polar.radius >= (self.sectorsRadius / 2)) return NO;
    else return YES;
}

- (void) valueChangedNotification{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


#pragma mark - Drawing

- (void)drawRect:(CGRect)rect{
    for(int i = 0; i < sectorsArray.count; i++){
        SAMultisectorSector *sector = sectorsArray[i];
        [self drawSector:sector atPosition:i+1];
    }
}

- (void)drawSector:(SAMultisectorSector *)sector atPosition:(NSUInteger)position{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, saCircleLineWidth);
    
    UIColor *startCircleColor = [sector.color colorWithAlphaComponent:0.3];
    UIColor *circleColor = sector.color;
    UIColor *endCircleColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
    
    SASectorDrawingInformation drawInf = [self sectorToDrawInf:sector position:position];
    
    CGFloat x = drawInf.circleCenter.x;
    CGFloat y = drawInf.circleCenter.y;
    CGFloat r = drawInf.radius;
    
    
    //start circle line
    [startCircleColor setStroke];
    CGContextAddArc(context, x, y, r, self.startAngle, drawInf.circleOffsetAngle, 0);
    CGContextStrokePath(context);
    
    //circle line
    [circleColor setStroke];
    CGContextAddArc(context, x, y, r, drawInf.circleOffsetAngle, drawInf.circleLineAngle, 0);
    CGContextStrokePath(context);
    
    //end circle line
    [endCircleColor setStroke];
    CGContextAddArc(context, x, y, r, drawInf.circleLineAngle, drawInf.circleEmptyAngle, 0);
    CGContextStrokePath(context);
    
    
    //clearing place for start marker
    CGContextSaveGState(context);
    CGContextAddArc(context, drawInf.startMarkerCenter.x, drawInf.startMarkerCenter.y, drawInf.startMarkerRadius - (saMarkersLineWidth/2.0), 0.0, 6.28, 0);
    CGContextClip(context);
    CGContextClearRect(context, self.bounds);
    CGContextRestoreGState(context);
    
    
    //clearing place for end marker
    CGContextSaveGState(context);
    CGContextAddArc(context, drawInf.endMarkerCenter.x, drawInf.endMarkerCenter.y, drawInf.endMarkerRadius - (saMarkersLineWidth/2.0), 0.0, 6.28, 0);
    CGContextClip(context);
    CGContextClearRect(context, self.bounds);
    CGContextRestoreGState(context);
    
    
    //markers
    CGContextSetLineWidth(context, saMarkersLineWidth);
    
    //drawing start marker
    [[circleColor colorWithAlphaComponent:drawInf.startMarkerAlpha] setStroke];
    CGContextAddArc(context, drawInf.startMarkerCenter.x, drawInf.startMarkerCenter.y, drawInf.startMarkerRadius, 0.0, 6.28, 0);
    CGContextStrokePath(context);
    
    //drawing end marker
    [[circleColor colorWithAlphaComponent:drawInf.endMarkerAlpha] setStroke];
    CGContextAddArc(context, drawInf.endMarkerCenter.x, drawInf.endMarkerCenter.y, drawInf.endMarkerRadius, 0.0, 6.28, 0);
    CGContextStrokePath(context);
    
    //text on markers
    NSString *startMarkerStr = [NSString stringWithFormat:@"%.0f", sector.startValue];
    NSString *endMarkerStr = [NSString stringWithFormat:@"%.0f", sector.endValue];
    
    //drawing start marker's text
    [self drawString:startMarkerStr
            withFont:[UIFont boldSystemFontOfSize:drawInf.startMarkerFontSize]
               color:[circleColor colorWithAlphaComponent:drawInf.startMarkerAlpha]
          withCenter:drawInf.startMarkerCenter];
    
    //drawing end marker's text
    [self drawString:endMarkerStr
            withFont:[UIFont boldSystemFontOfSize:drawInf.endMarkerFontize]
               color:[circleColor colorWithAlphaComponent:drawInf.endMarkerAlpha]
          withCenter:drawInf.endMarkerCenter];
}


- (SASectorDrawingInformation) sectorToDrawInf:(SAMultisectorSector *)sector position:(NSInteger)position{
    SASectorDrawingInformation drawInf;
    
    drawInf.circleCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height /2);
    drawInf.radius = self.sectorsRadius * position;//获得每一个sector的半径信息
    
    drawInf.fullLine = sector.maxValue - sector.minValue;
    drawInf.circleOffset = sector.startValue - sector.minValue;
    drawInf.circleLine = sector.endValue - sector.startValue;
    drawInf.circleEmpty = sector.maxValue - sector.endValue;//最大值和实际endvalue之间的
    
    drawInf.circleOffsetAngle = (drawInf.circleOffset/drawInf.fullLine) * M_PI * 2 + self.startAngle;
    drawInf.circleLineAngle = (drawInf.circleLine/drawInf.fullLine) * M_PI * 2 + drawInf.circleOffsetAngle;
    drawInf.circleEmptyAngle = M_PI * 2 + self.startAngle;//这个不太懂
    
    
    drawInf.startMarkerCenter = polarToDecart(drawInf.circleCenter, drawInf.radius, drawInf.circleOffsetAngle);
    drawInf.endMarkerCenter = polarToDecart(drawInf.circleCenter, drawInf.radius, drawInf.circleLineAngle);
    
    CGFloat minMarkerRadius = self.sectorsRadius / 4.0;
    CGFloat maxMarkerRadius = self.sectorsRadius / 2.0;
    
    drawInf.startMarkerRadius = ((drawInf.circleOffsetAngle/(self.startAngle + 2*M_PI)) * (maxMarkerRadius - minMarkerRadius)) + minMarkerRadius;
    drawInf.endMarkerRadius = ((drawInf.circleLineAngle/(self.startAngle + 2*M_PI)) * (maxMarkerRadius - minMarkerRadius)) + minMarkerRadius;
    
//    CGFloat minFontSize = 12.0;
//    CGFloat maxFontSize = 16.0;
    CGFloat minFontSize = 10.0;
    CGFloat maxFontSize = 13.0;
    
    drawInf.startMarkerFontSize = ((drawInf.circleOffset/drawInf.fullLine) * (maxFontSize - minFontSize)) + minFontSize;
    drawInf.endMarkerFontize = ((drawInf.circleLine/drawInf.fullLine) * (maxFontSize - minFontSize)) + minFontSize;
    
    CGFloat markersCentresSegmentLength = segmentLength(drawInf.startMarkerCenter, drawInf.endMarkerCenter);
    CGFloat markersRadiusSumm = drawInf.startMarkerRadius + drawInf.endMarkerRadius;
    
    if(markersCentresSegmentLength < markersRadiusSumm){
        
        drawInf.startMarkerAlpha = markersCentresSegmentLength / markersRadiusSumm;
    }else{
        drawInf.startMarkerAlpha = 1.0;
    }
    drawInf.endMarkerAlpha = 1.0;

    return drawInf;
}

- (void) drawString:(NSString *)s withFont:(UIFont *)font color:(UIColor *)color withCenter:(CGPoint)center{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0 // 当前支持的sdk版本是否低于7.0
    CGSize size = [s sizeWithFont:font];
#else
    NSDictionary * attrDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size = [s sizeWithAttributes:attrDic];
#endif
    
    CGFloat x = center.x - (size.width / 2);
    CGFloat y = center.y - (size.height / 2);
    CGRect textRect = CGRectMake(x, y, size.width, size.height);
    
    NSMutableDictionary *attr = [[NSMutableDictionary alloc] init];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0 // 当前支持的sdk版本是否低于7.0
    attr[UITextAttributeFont] = font;
    attr[UITextAttributeTextColor] = color;
#else
    attr[NSFontAttributeName]=font;
    attr[NSForegroundColorAttributeName]=color;
#endif

    [s drawInRect:textRect withAttributes:attr];
}



-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self)
    {
        return self;
    }
    else
    {
        return hitView;
    }
}


@end





@implementation SAMultisectorSector

- (instancetype)init{
    if(self = [super init]){
        self.minValue = 0.0;
        self.maxValue = 100.0;
        self.startValue = 0.0;
        self.endValue = 50.0;
        self.tag = 0;
        self.color = [UIColor greenColor];
    }
    return self;
}

+ (instancetype) sector{
    return [[SAMultisectorSector alloc] init];
}

+ (instancetype) sectorWithColor:(UIColor *)color{
    SAMultisectorSector *sector = [self sector];
    sector.color = color;
    return sector;
}

+ (instancetype) sectorWithColor:(UIColor *)color maxValue:(double)maxValue{
    SAMultisectorSector *sector = [self sectorWithColor:color];
    sector.maxValue = maxValue;
    return sector;
}

+ (instancetype) sectorWithColor:(UIColor *)color minValue:(double)minValue maxValue:(double)maxValue{
    SAMultisectorSector *sector = [self sectorWithColor:color maxValue:maxValue];
    sector.minValue = minValue;
    return sector;
}

@end
