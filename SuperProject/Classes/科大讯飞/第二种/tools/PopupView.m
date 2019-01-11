//
//  PopupView.m
//  MSCDemo
//
//  Created by iflytek on 13-6-7.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//


#import "PopupView.h"
#import <QuartzCore/QuartzCore.h>
#ifdef __IPHONE_6_0
# define ALIGN_CENTER NSTextAlignmentCenter
#else
# define ALIGN_CENTER UITextAlignmentCenter
#endif

@implementation PopupView

@synthesize ParentView = _parentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.5f];
        self.layer.cornerRadius = 5.0f;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 10)];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:17];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = ALIGN_CENTER;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = ALIGN_CENTER;
        [self addSubview:_textLabel];
        _queueCount = 0;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withParentView:(UIView*)view
{
    if (view == nil) {
        return nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.ParentView = view;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.5f];
        self.layer.cornerRadius = 5.0f;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 10)];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:17];
//        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textColor = [UIColor greenColor];
        
        _textLabel.textAlignment = ALIGN_CENTER;
//        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.backgroundColor = [UIColor blackColor];
        _textLabel.textAlignment = ALIGN_CENTER;
        [self addSubview:_textLabel];
        _queueCount = 0;
        
        CGPoint centerPoint = CGPointMake(_parentView.center.x, self.center.y);
        self.center= centerPoint;
    }
    return self;
}

- (void) setText:(NSString *) text
{
    _textLabel.frame = CGRectMake(0, 10, 100, 10);
    _queueCount ++;
    self.alpha = 1.0f;
    _textLabel.text = text;
    [_textLabel sizeToFit];
    CGRect frame = CGRectMake(5, 0, _textLabel.frame.size.width, _textLabel.frame.size.height);
    _textLabel.frame = frame;
    _textLabel.frame = CGRectMake(_textLabel.frame.origin.x, _textLabel.frame.origin.y+10, _textLabel.frame.size.width, _textLabel.frame.size.height);
    frame =  CGRectMake((_parentView.frame.size.width - frame.size.width)/2, self.frame.origin.y, _textLabel.frame.size.width+10, _textLabel.frame.size.height+20);
    self.frame = frame;
    CGPoint centerPoint = CGPointMake(_parentView.center.x, self.center.y);
    self.center= centerPoint;
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         if (_queueCount == 1) {
                             [self removeFromSuperview];
                         }
                         _queueCount--;
                         
                     }
     ];
    
}


- (void)showText:(NSString *) text
{
    _textLabel.frame = CGRectMake(0, 10, 100, 10);
    _queueCount ++;
    self.alpha = 1.0f;
    _textLabel.text = text;
    [_textLabel sizeToFit];
    CGRect frame = CGRectMake(5, 0, _textLabel.frame.size.width, _textLabel.frame.size.height);
    _textLabel.frame = frame;
    _textLabel.frame = CGRectMake(_textLabel.frame.origin.x, _textLabel.frame.origin.y+10, _textLabel.frame.size.width, _textLabel.frame.size.height);
    frame =  CGRectMake((_parentView.frame.size.width - frame.size.width)/2, self.frame.origin.y, _textLabel.frame.size.width+10, _textLabel.frame.size.height+20);
    self.frame = frame;
    CGPoint centerPoint = CGPointMake(_parentView.center.x, self.center.y);
    self.center= centerPoint;

    if (_parentView != nil) {
        [_parentView addSubview:self];
    }
    
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         if (_queueCount == 1) {
                             [self removeFromSuperview];
                         }
                         _queueCount--;
                         
                     }
     ];
    

}


@end

