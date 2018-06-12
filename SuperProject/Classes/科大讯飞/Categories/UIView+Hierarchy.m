//
//  UIView+Hierarchy.m
//  QQing
//
//  Created by 李杰 on 2/22/15.
//
//

#import "UIView+Hierarchy.h"

@implementation UIView (Hierarchy)

- (NSUInteger)getSubviewIndex {
    return [self.superview.subviews indexOfObject:self];
}

- (void)bringToFront {
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack {
    [self.superview sendSubviewToBack:self];
}

- (void)bringOneLevelUp {
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

- (void)sendOneLevelDown {
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

- (BOOL)isInFront {
    return ([self.superview.subviews lastObject]==self);
}

- (BOOL)isAtBack {
    return ([self.superview.subviews objectAtIndex:0]==self);
}

- (void)swapDepthsWithView:(UIView*)swapView {
    [self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}

- (void)removeAllSubviews {
    // Normally.
    //    for(UIView *view in [self subviews]) {
    //        [view removeFromSuperview];
    //    }
    
    // But others.
    //    [self setSubviews:[NSArray array]]; // If subviews can be written.
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)removeSubViewByTag:(NSUInteger)tag {
    UIView *v = nil;
    if ((v = [self viewWithTag:tag])) {
        [v removeFromSuperview];
    }
}

- (void)removeSubViewWithClassType:(Class)classt {
    NSArray *allSubviews = [self subviews];
    
    for (UIView *view in allSubviews) {
        if ([view isMemberOfClass:classt]) {
            [view removeFromSuperview];
        }
    }
}

- (void)removeSubViews:(NSArray *)views {
    if (views && [views count]) {
        [views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}

- (BOOL)containsSubView:(UIView *)subView {
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsSubViewOfClassType:(Class)classt {
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:classt]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Recursive Subview

- (UIView*)firstSubviewOfClass:(Class)classObj {
    NSMutableArray* allViews = [self allViewOfClass:classObj];
    [allViews removeObject:self];
    return allViews.count == 0 ? nil : allViews[0];
}

// 递归查找所有子视图（包含自身）
- (void)findAllViewWithRootView:(UIView *)rootView resultArray:(NSMutableArray*)resultArray {
    if (rootView == nil) {
        return;
    }
    [resultArray addObject:rootView];
    for (UIView *aview in [rootView subviews]){
        [self findAllViewWithRootView:aview resultArray:resultArray];
    }
}

- (NSMutableArray*)allViewOfClass:(Class)viewClass {
    NSMutableArray* resultArray = [NSMutableArray new];
    [self findAllViewWithRootView:self resultArray:resultArray];
    if (viewClass) {
        NSMutableArray* filteredArray = [NSMutableArray new];
        for (UIView* view in resultArray) {
            if ([view isMemberOfClass:viewClass]) {
                [filteredArray addObject:view];
            }
        }
        return filteredArray;
    } else {
        return resultArray;
    }
}

- (UIViewController*)firstTopViewController {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    for (UIResponder* responder = self.nextResponder; responder != window; responder = responder.nextResponder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)responder;
        }
    }
    return nil;
}

@end
