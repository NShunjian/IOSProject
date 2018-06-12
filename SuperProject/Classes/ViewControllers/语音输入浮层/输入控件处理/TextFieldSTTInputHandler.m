//
//  TextFieldSTTInputHandler.m
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "TextFieldSTTInputHandler.h"

@implementation TextFieldSTTInputHandler

- (instancetype)initWithInputControl:(id)inputControl {
    if (self = [super init]) {
        self.inputControl = inputControl;
        
        NSUInteger currentInputPosition = [(UITextField *)self.inputControl selectedRange].location;
        
        if (currentInputPosition == NSNotFound) {
            currentInputPosition = ((UITextField *)self.inputControl).text.length;
        }
        
        self.currentInputPosition = currentInputPosition;
    }
    
    return self;
}

- (void)handleAppendText:(NSString *)textToAppend {
    UITextField *textField = self.inputControl;
    
    NSString *originText = textField.text;
    if (textField.delegate && [textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] &&
        ![textField.delegate textField:textField shouldChangeCharactersInRange:NSMakeRange(self.currentInputPosition, 0) replacementString:textToAppend]) {
        return;
    } else {
        if (self.currentInputPosition > originText.length) {
            self.currentInputPosition = originText.length;
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
        
        textField.text = stringToSet;
        [textField setSelectedRange:NSMakeRange(self.currentInputPosition + textToAppend.length, 0)];
        self.currentInputPosition = self.currentInputPosition + textToAppend.length;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification
                                                            object:textField];
    }
}

@end


