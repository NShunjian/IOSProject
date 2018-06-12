//
//  BaseSTTInputHandler.m
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "BaseSTTInputHandler.h"
#import "TextViewInputHandler.h"
#import "TextFieldSTTInputHandler.h"

@interface BaseSTTInputHandler ()

@end

@implementation BaseSTTInputHandler

+ (instancetype)inputHandlerWithInputControl:(id)inputControl {
    if ([inputControl isKindOfClass:[UITextView class]]) {
        return [[TextViewInputHandler alloc] initWithInputControl:inputControl];
    } else if ([inputControl isKindOfClass:[UITextField class]]) {
        return [[TextFieldSTTInputHandler alloc] initWithInputControl:inputControl];
    } else {
        return nil;
    }
}

- (instancetype)initWithInputControl:(id)inputControl {
    return nil;
}

- (void)handleAppendText:(NSString *)textToAppend {
    return;
}

@end


