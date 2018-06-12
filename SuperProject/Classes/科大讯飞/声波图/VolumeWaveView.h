//
//  VolumeWaveView.h
//  全靠浪
//
//  Created by 郭晓倩 on 17/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VolumeWaveView : UIView

@property (assign,nonatomic) int volume;
@property (strong,nonatomic) NSArray<UIColor*>* strokeColors;   // 3个颜色

//- (instancetype)initWithFrame:(CGRect)frame maxVolume:(float)maxVolume maxWaveHeight:(float)maxWaveHeight;

- (void)start;
- (void)stop;

@end


