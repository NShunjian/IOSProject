//
//  SUPItemSection.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUPWordItem;
@interface SUPItemSection : NSObject

/** <#digest#> */
@property (nonatomic, copy) NSString *headerTitle;

/** <#digest#> */
@property (nonatomic, copy) NSString *footerTitle;

/** <#digest#> */
//@property (nonatomic, strong) NSArray<SUPWordItem *> *items;
@property (nonatomic, strong) NSMutableArray<SUPWordItem *> *items;
+ (instancetype)sectionWithItems:(NSArray<SUPWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

@end
