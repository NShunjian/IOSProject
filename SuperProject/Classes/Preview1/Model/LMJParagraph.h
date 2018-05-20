//
//  LMJParagraph.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN const CGFloat KTopSpace;
UIKIT_EXTERN const CGFloat KLeftSpace;
UIKIT_EXTERN const CGFloat KRightSpace;
UIKIT_EXTERN const CGFloat KDateLabelFontSize;
UIKIT_EXTERN const CGFloat KDateMarginToText;
UIKIT_EXTERN const CGFloat KTextLabelFontSize;
UIKIT_EXTERN const CGFloat kBottomSpace;

@interface LMJParagraph : NSObject

/** <#digest#> */
@property (nonatomic, copy) NSString *words;

/** <#digest#> */
@property (nonatomic, copy) NSString *date;

/** <#digest#> */
@property (nonatomic, copy, readonly) NSAttributedString *attWords;

/** <#digest#> */
@property (nonatomic, assign, readonly) CGFloat height;

@end
