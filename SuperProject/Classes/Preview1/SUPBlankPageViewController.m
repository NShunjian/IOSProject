//
//  SUPBlankPageViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPBlankPageViewController.h"

@interface SUPBlankPageViewController ()
/** <#digest#> */
@property (nonatomic, strong) NSArray *dateArray;
@end

@implementation SUPBlankPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.tableFooterView = [UIView new];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateArray.count;
}

- (void)loadMore:(BOOL)isMore
{
    SUPWeakSelf(self);
    
    [self endHeaderFooterRefreshing];
    
    [self.tableView reloadData];
    
    [self.tableView configBlankPage:SUPEasyBlankPageViewTypeNoData hasData:self.dateArray.count hasError:self.dateArray.count > 0 reloadButtonBlock:^(id sender) {
        
        [MBProgressHUD showAutoMessage:@"重新加载数据"];
        
        [weakself.tableView.mj_header beginRefreshing];
        
    }];
}



#pragma mark 重写BaseViewController设置内容

- (UIColor *)SUPNavigationBackgroundColor:(SUPNavigationBar *)navigationBar
{
    return [UIColor whiteColor];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
    
    SUPWeakSelf(self);
    [self.tableView configBlankPage:SUPEasyBlankPageViewTypeNoData hasData:self.dateArray.count > 0 hasError:YES reloadButtonBlock:^(id sender) {
        
        [weakself.tableView.mj_header beginRefreshing];
        
    }];
}

- (void)titleClickEvent:(UILabel *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%@", sender);
}

- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar
{
    return [self changeTitle:@"空白页展示"];;
}


- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"navigationButtonReturnClick"];
}


- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
{
    
    [rightButton setTitle:@"出错效果" forState:UIControlStateNormal];
    
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    rightButton.backgroundColor = [UIColor RandomColor];
    
    rightButton.SUP_size = CGSizeMake(80, 44);
    
    return nil;
}



#pragma mark 自定义代码

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor RandomColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
    
    return title;
}


@end
