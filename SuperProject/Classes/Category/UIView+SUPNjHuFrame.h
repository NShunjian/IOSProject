//
//  UIView+SUPNjHuFrame.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SUPNjHuFrame)

@property (nonatomic) CGFloat SUP_x;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat SUP_y;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat SUP_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat SUP_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat SUP_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat SUP_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat SUP_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat SUP_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint SUP_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  SUP_size;        ///< Shortcut for frame.size.

@end
