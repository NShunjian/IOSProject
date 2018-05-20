//
//  LMJItemSection.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJItemSection.h"


@implementation LMJItemSection

+ (instancetype)sectionWithItems:(NSArray<LMJWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    LMJItemSection *item = [[self alloc] init];
    item.items = items;
    
    item.headerTitle = headerTitle;
    item.footerTitle = footerTitle;
    
    return item;
}

@end
