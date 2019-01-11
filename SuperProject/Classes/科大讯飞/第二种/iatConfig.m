//
//  IATConfig.m
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-25.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#define PUTONGHUA   @"mandarin"
#define YUEYU       @"cantonese"
#define ENGLISH     @"en_us"
#define CHINESE     @"zh_cn";
#define SICHUANESE  @"lmz";

#import "iatConfig.h"

@implementation iatConfig

-(id)init {
    self  = [super init];
    if (self) {
        [self defaultSetting];
        return  self;
    }
    return nil;
}


+(iatConfig *)sharedInstance {
    static iatConfig  * instance = nil;
    static dispatch_once_t predict;
    dispatch_once(&predict, ^{
        instance = [[iatConfig alloc] init];
    });
    return instance;
}


-(void)defaultSetting {
    _speechTimeout = @"30000";
    _vadEos = @"100000";
    _vadBos = @"100000";
    _dot = @"1";
    _sampleRate = @"16000";
    _language = CHINESE;
    _accent = PUTONGHUA;
    _haveView = NO;
    _accentNickName = [[NSArray alloc] initWithObjects:NSLocalizedString(@"K_LangCant", nil), NSLocalizedString(@"K_LangChin", nil), NSLocalizedString(@"K_LangEng", nil), NSLocalizedString(@"K_LangSzec", nil), nil];
    
    _isTranslate = NO;
}


+(NSString *)mandarin {
    return PUTONGHUA;
}
+(NSString *)cantonese {
    return YUEYU;
}
+(NSString *)chinese {
    return CHINESE;
}
+(NSString *)english {
    return ENGLISH;
}
+(NSString *)sichuanese {
    return SICHUANESE;
}

+(NSString *)lowSampleRate {
    return @"8000";
}

+(NSString *)highSampleRate {
    return @"16000";
}

+(NSString *)isDot {
    return @"1";
}

+(NSString *)noDot {
    return @"0";
}

@end
