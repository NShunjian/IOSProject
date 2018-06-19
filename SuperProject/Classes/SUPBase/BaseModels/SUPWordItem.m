//
//  SUPWordItem.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPWordItem.h"

@implementation SUPWordItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    SUPWordItem *item = [[self alloc] init];
    item.subTitle = subTitle;
    item.title = title;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation {
    SUPWordItem *item = [self itemWithTitle:title subTitle:subTitle];
    item.itemOperation = itemOperation;
    return item;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _titleColor = [UIColor blackColor];
        _subTitleColor = [UIColor blackColor];
        
//        _cellHeight = AdaptedHeight(50);
        _titleFont = AdaptedFontSize(16);
        _subTitleFont = AdaptedFontSize(16);
        _subTitleNumberOfLines = 1;
}
    
    return self;
}
- (CGFloat)cellHeight {
    if (!_cellHeight) {
        _cellHeight += 20;
        NSString *totalString = [NSString stringWithFormat:@"%@%@", self.title, self.subTitle];
        _cellHeight += [totalString boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : self.subTitleFont} context:nil].size.height;
        _cellHeight = MAX(_cellHeight, 50);
        _cellHeight = AdaptedWidth(_cellHeight);
    }
    return _cellHeight;
}

@end
