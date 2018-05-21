//
//  SUPItemSection.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPItemSection.h"


@implementation SUPItemSection

+ (instancetype)sectionWithItems:(NSArray<SUPWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    SUPItemSection *item = [[self alloc] init];
    item.items = items;
    
    item.headerTitle = headerTitle;
    item.footerTitle = footerTitle;
    
    return item;
}

@end
