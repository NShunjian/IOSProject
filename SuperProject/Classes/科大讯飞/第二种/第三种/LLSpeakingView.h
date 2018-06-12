//
//  LLSpeakingView.h
//  LLMicrophone
//
//  Created by 啸峰 on 16/6/11.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSpeakingView : UIView

- (void)startSpeak;
- (void)stopSpeak;
- (void)volumeChange:(CGFloat)volume;
@end
