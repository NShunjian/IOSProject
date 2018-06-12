//
//  PlaceholderTextView.m
//  StudioCommon
//
//  Created by Ben on 8/6/15.
//  Copyright © 2016年 StudioCommon. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView ()

@property (nonatomic, retain) UILabel *placeHolderLabel;

@end

@implementation PlaceholderTextView

static const CGFloat UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    [_placeHolderLabel release]; _placeHolderLabel = nil;
    [_placeholderColor release]; _placeholderColor = nil;
    [_placeholder release]; _placeholder = nil;
    [super dealloc];
#endif
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    [self setupDefaultConfiguration];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pp_textChanged:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pp_beginEdit:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pp_endEdit:) name:UITextViewTextDidEndEditingNotification object:self];
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self setupDefaultConfiguration];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pp_textChanged:) name:UITextViewTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pp_beginEdit:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pp_endEdit:) name:UITextViewTextDidEndEditingNotification object:self];
    }
    return self;
}

#pragma mark - Private methods

- (void)setupDefaultConfiguration
{
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [self setPlaceholderType:PlaceholderType_Left];
}

- (void)refreshPlaceHolderWhenIsFirstResponder
{
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        [[self viewWithTag:999] setAlpha:0];
    }];
}

- (void)refreshPlaceHolderWhenNotFirstResponder
{
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0) {
            [[self viewWithTag:999] setAlpha:1];
        } else {
            [[self viewWithTag:999] setAlpha:0];
        }
    }];
}

#pragma mark - Notification handle

- (void)pp_beginEdit:(NSNotification *)notification
{
    [self refreshPlaceHolderWhenIsFirstResponder];
}

- (void)pp_endEdit:(NSNotification *)notification
{
    if([[self placeholder] length] == 0) {
        return;
    }
    
    [self refreshPlaceHolderWhenNotFirstResponder];
}

#pragma mark - Override methods

- (void)setText:(NSString *)text
{
    [super setText:text];

    if ([self isFirstResponder]) {
        [self refreshPlaceHolderWhenIsFirstResponder];
    } else {
        [self refreshPlaceHolderWhenNotFirstResponder];
    }
}

- (void)drawRect:(CGRect)rect
{
    if([[self placeholder] length] > 0) {
        if (_placeHolderLabel == nil) {
            CGFloat heightToSet = [self.placeholder qq_boundFrameHeightWithMaxSize:CGSizeMake(self.bounds.size.width - 16, 9999)
                                                                           andFont:self.font];
            
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, self.bounds.size.width - 16, heightToSet)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        
        if (_placeholderType == PlaceholderType_Left) {
            CGFloat placeHolderHeightToSet = [self.placeholder qq_boundFrameHeightWithMaxSize:CGSizeMake(self.bounds.size.width - 16, 9999)
                                                                           andFont:self.font];
            
            _placeHolderLabel.frame = CGRectMake(3, 3, self.bounds.size.width, placeHolderHeightToSet);
            _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.layer.cornerRadius = 5.0;
            _placeHolderLabel.layer.masksToBounds = YES;
        } else if (_placeholderType == PlaceholderType_Middel) {
            _placeHolderLabel.textAlignment = NSTextAlignmentCenter;
        } else if (_placeholderType == PlaceholderType_Right) {
            _placeHolderLabel.textAlignment = NSTextAlignmentRight;
        } else if (_placeholderType == PlaceholderType_Center) {
            _placeHolderLabel.frame = CGRectMake(self.spaceForPlaceHodlerType, 0, self.bounds.size.width - 2 *self.spaceForPlaceHodlerType, self.bounds.size.height);
            _placeHolderLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 ) {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

@end
