//
//  LMJListExpendHeaderView.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMJGroup;
@interface LMJListExpendHeaderView : UITableViewHeaderFooterView

/** <#digest#> */
@property (nonatomic, strong) LMJGroup *group;


/** <#digest#> */
@property (nonatomic, copy) BOOL(^selectGroup)();


+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
