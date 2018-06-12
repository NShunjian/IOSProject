//
//  TTSConfig.h
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-25.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFlyMSC/IFlyMSC.h"

@interface TTSConfig : NSObject

+(TTSConfig *)sharedInstance;

@property (nonatomic) NSString *speed;
@property (nonatomic) NSString *volume;
@property (nonatomic) NSString *pitch;
@property (nonatomic) NSString *sampleRate;
@property (nonatomic) NSString *vcnName;
@property (nonatomic) NSString *engineType;// the engine type of Text-to-Speech:"auto","local","cloud"


@property (nonatomic,strong) NSArray *vcnNickNameArray;
@property (nonatomic,strong) NSArray *vcnIdentiferArray;

@end
