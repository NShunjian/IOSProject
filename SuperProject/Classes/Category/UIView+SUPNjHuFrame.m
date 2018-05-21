//
//  UIView+SUPNjHuFrame.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "UIView+SUPNjHuFrame.h"

@implementation UIView (SUPNjHuFrame)

- (CGFloat)SUP_x {
    return self.frame.origin.x;
}

- (void)setSUP_x:(CGFloat)SUP_x {
    CGRect frame = self.frame;
    frame.origin.x = SUP_x;
    self.frame = frame;
}

- (CGFloat)SUP_y {
    return self.frame.origin.y;
}

- (void)setSUP_y:(CGFloat)SUP_y {
    CGRect frame = self.frame;
    frame.origin.y = SUP_y;
    self.frame = frame;
}

- (CGFloat)SUP_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSUP_right:(CGFloat)SUP_right {
    CGRect frame = self.frame;
    frame.origin.x = SUP_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)SUP_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSUP_bottom:(CGFloat)SUP_bottom {
    
    CGRect frame = self.frame;
    
    frame.origin.y = SUP_bottom - frame.size.height;
    
    self.frame = frame;
}

- (CGFloat)SUP_width {
    return self.frame.size.width;
}

- (void)setSUP_width:(CGFloat)SUP_width {
    CGRect frame = self.frame;
    frame.size.width = SUP_width;
    self.frame = frame;
}

- (CGFloat)SUP_height {
    return self.frame.size.height;
}

- (void)setSUP_height:(CGFloat)SUP_height {
    CGRect frame = self.frame;
    frame.size.height = SUP_height;
    self.frame = frame;
}

- (CGFloat)SUP_centerX {
    return self.center.x;
}

- (void)setSUP_centerX:(CGFloat)SUP_centerX {
    self.center = CGPointMake(SUP_centerX, self.center.y);
}

- (CGFloat)SUP_centerY {
    return self.center.y;
}

- (void)setSUP_centerY:(CGFloat)SUP_centerY {
    self.center = CGPointMake(self.center.x, SUP_centerY);
}

- (CGPoint)SUP_origin {
    return self.frame.origin;
}

- (void)setSUP_origin:(CGPoint)SUP_origin {
    CGRect frame = self.frame;
    frame.origin = SUP_origin;
    self.frame = frame;
}

- (CGSize)SUP_size {
    return self.frame.size;
}

- (void)setSUP_size:(CGSize)SUP_size {
    CGRect frame = self.frame;
    frame.size = SUP_size;
    self.frame = frame;
}

@end
