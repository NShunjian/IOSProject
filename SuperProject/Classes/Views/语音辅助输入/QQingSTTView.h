//
//  QQingSTTView.h
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQingSTTView : UIView

@property (nonatomic, strong) id inputControl;  // 暂时只支持UITextView和UITextField
@property (nonatomic, assign) BOOL hideBorder;

@end
