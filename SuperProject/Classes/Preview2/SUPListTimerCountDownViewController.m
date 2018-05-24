//
//  SUPListTimerCountDownViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPListTimerCountDownViewController.h"
#import "SUPCountDownModel.h"
#import "SUPCountDownCell.h"

@interface SUPListTimerCountDownViewController ()

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<SUPCountDownModel *> *products;

/** <#digest#> */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SUPListTimerCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[SUPCountDownCell class] forCellReuseIdentifier:NSStringFromClass([SUPCountDownCell class])];
    
    [self products];
    
    [self startTimer];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SUPCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SUPCountDownCell class]) forIndexPath:indexPath];
    
    cell.countDownModel = self.products[indexPath.row];
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AdaptedHeight(50);
}





- (NSMutableArray<SUPCountDownModel *> *)products
{
    if(_products == nil)
    {
        NSMutableArray *products = [NSMutableArray array];
        
        for (NSInteger i = 0; i < 30; i++) {
            
            SUPCountDownModel *model = [SUPCountDownModel new];
            
            [products addObject:model];
            
            model.productName = [NSString stringWithFormat:@"产品标号%zd", i];
            
            model.date = CFAbsoluteTimeGetCurrent() + i * (10);
            
            model.pruductImage = [UIImage imageNamed:@"test_BaiDu_red"];
        }
        
        _products = products;
    }
    return _products;
}

- (void)startTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount:) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)timeCount:(NSTimer *)timer
{
    [self.products enumerateObjectsUsingBlock:^(SUPCountDownModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.date == CFAbsoluteTimeGetCurrent()) {
            
        }else {
            obj.date  = obj.date - 1;
        }
    }];
    
    
    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SUPCountDownCell *cell = (SUPCountDownCell *)obj;
        cell.countDownModel = cell.countDownModel;
    }];
}


#pragma mark - SUPNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

#pragma mark - SUPNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
