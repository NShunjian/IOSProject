//
//  NSString+PlaceHolder.m
//  QQing
//
//  Created by YuanBo on 5/5/16.
//
//

#import "NSString+PlaceHolder.h"

@implementation NSString (PlaceHolder)

- (CGFloat)qq_boundFrameHeightWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    if ([self length] > 0) {
        return ceilf([self boundingRectWithSize:maxSize
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{NSFontAttributeName:font}
                                  context:NULL].size.height);
    } else {
        return 0.f;
    }
}

@end
