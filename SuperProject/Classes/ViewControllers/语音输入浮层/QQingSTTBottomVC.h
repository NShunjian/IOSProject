//
//  QQingSTTBottomVC.h
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "BaseBottomPopoverVC.h"
#import "BaseSTTInputHandler.h"

@interface QQingSTTBottomVC : BaseBottomPopoverVC

+ (instancetype)sttBottomVCWithSTTInputHandler:(BaseSTTInputHandler *)inputHandler;

@end


