//
//  LMJRefreshTableViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJRefreshTableViewController.h"


@interface LMJRefreshTableViewController ()

@end

@implementation LMJRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWeakSelf(self);
    self.tableView.mj_header = [LMJNormalRefreshHeader headerWithRefreshingBlock:^{
        
        [weakself loadIsMore:NO];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    self.tableView.mj_footer = [LMJAutoRefreshFooter footerWithRefreshingBlock:^{
        
        [weakself loadIsMore:YES];
        
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
//    self.tableView.mj_footer.automaticallyHidden = YES;
    
    
    [self.tableView.mj_header beginRefreshing];
}


// 内部方法
- (void)loadIsMore:(BOOL)isMore
{
    // 控制只能下拉或者上拉
    if (isMore) {
        ![self.tableView.mj_header isRefreshing] ?: [self.tableView.mj_header endRefreshing];
    }else
    {
        ![self.tableView.mj_footer isRefreshing] ?: [self.tableView.mj_footer endRefreshing];
    }
    [self loadMore:isMore];
}


// 结束刷新
- (void)endHeaderFooterRefreshing
{
    NSLog(@"tableview----------------endHeaderFooterRefreshing");
    // 结束刷新状态
    ![self.tableView.mj_header isRefreshing] ?: [self.tableView.mj_header endRefreshing];
    ![self.tableView.mj_footer isRefreshing] ?: [self.tableView.mj_footer endRefreshing];
    
}

// 子类需要调用调用
- (void)loadMore:(BOOL)isMore
{
    //        NSAssert(0, @"子类必须重载%s", __FUNCTION__);
}


@end











