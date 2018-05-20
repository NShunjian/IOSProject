//
//  LMJAdaptFontCell.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMJParagraph.h"
@interface LMJAdaptFontCell : UITableViewCell

+ (instancetype)adaptFontCellWithTableView:(UITableView *)tableView;

/** <#digest#> */
@property (nonatomic, strong) LMJParagraph *paragraph;

@end
