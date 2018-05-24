//
//  SUPListExpendHeaderView.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SUPGroup;
@interface SUPListExpendHeaderView : UITableViewHeaderFooterView

/** <#digest#> */
@property (nonatomic, strong) SUPGroup *group;


/** <#digest#> */
@property (nonatomic, copy) BOOL(^selectGroup)();


+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
