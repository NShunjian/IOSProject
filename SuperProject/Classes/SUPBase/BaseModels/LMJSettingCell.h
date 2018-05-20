//
//  LMJSettingCell.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMJWordItem;

@interface LMJSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
/** 静态单元格模型 */
@property (nonatomic, strong)  LMJWordItem *item;

@end
