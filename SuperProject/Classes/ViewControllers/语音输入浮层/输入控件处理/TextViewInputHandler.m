//
//  TextViewInputHandler.m
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "TextViewInputHandler.h"

@implementation TextViewInputHandler

- (instancetype)initWithInputControl:(id)inputControl {
    if (self = [super init]) {
        self.inputControl = inputControl;
        
        NSUInteger currentInputPosition = [(UITextView *)self.inputControl selectedRange].location;
            
        if (currentInputPosition == NSNotFound) {
            currentInputPosition = ((UITextView *)self.inputControl).text.length;
        }
        
        self.currentInputPosition = currentInputPosition;
    }
    
    return self;
}

- (void)handleAppendText:(NSString *)textToAppend {
    UITextView *textView = self.inputControl;
    
    NSString *originText = textView.text;
    if (textView.delegate && [textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)] &&
        ![textView.delegate textView:textView shouldChangeTextInRange:NSMakeRange(self.currentInputPosition, 0) replacementText:textToAppend]) {
        return;
    } else {
        if (self.currentInputPosition > originText.length) {
            self.currentInputPosition = originText.length;
            [textView scrollRangeToVisible:NSMakeRange(originText.length, 0)];
        }
        
        NSMutableString *stringToSet = [NSMutableString string];
        if ((self.currentInputPosition <= originText.length) && (self.currentInputPosition != 0)) {
            [stringToSet appendString:[originText substringWithRange:NSMakeRange(0, self.currentInputPosition)]];
        }
        if (textToAppend.length > 0) {
            [stringToSet appendString:textToAppend];
        }
        if (self.currentInputPosition < originText.length) {
            [stringToSet appendString:[originText substringFromIndex:self.currentInputPosition]];
        }
        
        textView.text = stringToSet;
        [textView setSelectedRange:NSMakeRange(self.currentInputPosition + textToAppend.length, 0)];
        self.currentInputPosition = self.currentInputPosition + textToAppend.length;
        
        [textView scrollRangeToVisible:NSMakeRange(self.currentInputPosition + textToAppend.length, 0)];
        
        if (textView.delegate && [textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [textView.delegate textViewDidChange:textView];
        }
    }
}

@end


