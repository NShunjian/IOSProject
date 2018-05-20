//
//  LMJRefreshTableViewController.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJTableViewController.h"
#import "LMJAutoRefreshFooter.h"
#import "LMJNormalRefreshHeader.h"

@interface LMJRefreshTableViewController : LMJTableViewController

- (void)loadMore:(BOOL)isMore;


// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;

@end
