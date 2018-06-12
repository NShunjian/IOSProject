//
//  Definition.h
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#define Margin  5
#define Padding 10
#define iOS7TopMargin 64
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending )
#define ButtonHeight 44
#define NavigationBarHeight 44

#define APPID_VALUE           @"5b1a83ac"
#define URL_VALUE             @""                 // url
#define TIMEOUT_VALUE         @"20000"            // timeout, Unit:ms
#define BEST_URL_VALUE        @"1"                // best_search_url

#define SEARCH_AREA_VALUE     @"Hefei,Anhui"
#define ASR_PTT_VALUE         @"1"
#define VAD_BOS_VALUE         @"5000"
#define VAD_EOS_VALUE         @"1800"
#define PLAIN_RESULT_VALUE    @"1"
#define ASR_SCH_VALUE         @"1"

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_CENTER NSTextAlignmentCenter
#else
# define IFLY_ALIGN_CENTER UITextAlignmentCenter
#endif

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_LEFT NSTextAlignmentLeft
#else
# define IFLY_ALIGN_LEFT UITextAlignmentLeft
#endif
