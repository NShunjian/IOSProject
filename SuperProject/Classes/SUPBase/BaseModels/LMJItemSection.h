//
//  LMJItemSection.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMJWordItem;
@interface LMJItemSection : NSObject

/** <#digest#> */
@property (nonatomic, copy) NSString *headerTitle;

/** <#digest#> */
@property (nonatomic, copy) NSString *footerTitle;

/** <#digest#> */
@property (nonatomic, strong) NSArray<LMJWordItem *> *items;

+ (instancetype)sectionWithItems:(NSArray<LMJWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

@end
