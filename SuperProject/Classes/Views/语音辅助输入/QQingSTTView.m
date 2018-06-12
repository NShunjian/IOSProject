//
//  QQingSTTView.m
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "QQingSTTView.h"

@interface QQingSTTView ()

@property (nonatomic, strong) UIButton *topButton;

@end

@implementation QQingSTTView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

#pragma mark - Private methods

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.backgroundColor = [UIColor whiteColor];
    [topButton setImage:[UIImage imageNamed:@"sound_icon"] forState:UIControlStateNormal];
    [topButton setTitle:@"" forState:UIControlStateNormal];
    topButton.contentMode = UIViewContentModeCenter;

    [topButton addTarget:self action:@selector(didClickTopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:topButton];
    self.topButton = topButton;
    
    @weakify(self);
    [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    self.hideBorder = NO;
}

- (void)setHideBorder:(BOOL)hideBorder {
    _hideBorder = hideBorder;
    
    if (self.hideBorder) {
        self.topButton.layer.borderWidth = 0;
        self.topButton.layer.borderColor = [UIColor clearColor].CGColor;
        self.topButton.layer.cornerRadius = 0;
        self.topButton.layer.masksToBounds = NO;
    } else {
        self.topButton.layer.borderWidth = 1;
        self.topButton.layer.borderColor = RGB(240, 240, 240).CGColor;
        self.topButton.layer.cornerRadius = 3;
        self.topButton.layer.masksToBounds = YES;
    }
}

#pragma mark - IBActions

- (void)didClickTopButtonAction:(UIButton *)button {
    BaseSTTInputHandler *inputHandler = [BaseSTTInputHandler inputHandlerWithInputControl:self.inputControl];
    
    QQingSTTBottomVC *sttBottomVC = [QQingSTTBottomVC sttBottomVCWithSTTInputHandler:inputHandler];
    
    [sttBottomVC showWithAnimated:YES];
}

@end


