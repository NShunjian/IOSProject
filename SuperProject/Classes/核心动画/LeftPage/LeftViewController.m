//
//  LeftViewController.m
//  侧滑菜单
//
//  Created by yixiang on 15/7/13.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "LeftViewController.h"
#import "SWRevealViewController.h"
#import "BaseAnimationController.h"
#import "KeyFrameAnimationController.h"
#import "GroupAnimationController.h"
#import "TransitionAnimationController.h"
#import "ComprehensiveCaseController.h"
#import "AffineTransformController.h"

@interface LeftViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSArray *menuArray;

@end

@implementation LeftViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"核心动画";
    [self initData];
    [self initView];
}

-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"基础动画",@"关键帧动画",@"组动画",@"过渡动画",@"仿射变换",@"综合案例", nil];
}

-(void)initView{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TABLE_VIEW_ID = @"table_view_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_VIEW_ID];
    }
    cell.textLabel.text = [_menuArray objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    SWRevealViewController *revealViewController = self.revealViewController;
    UIViewController *viewController;
    SUPLog(@"%zd",indexPath.row);
    switch (indexPath.row) {
        case 0:
            viewController = [[BaseAnimationController alloc] init];
            break;
        case 1:
            viewController = [[KeyFrameAnimationController alloc] init];
            break;
        case 2:
            viewController = [[GroupAnimationController alloc] init];
            break;
        case 3:
            viewController = [[TransitionAnimationController alloc] init];
            break;
        case 4:
            viewController = [[AffineTransformController alloc] init];
            break;
        case 5:
            viewController = [[ComprehensiveCaseController alloc] init];
            break;
        default:
            break;
    }
//    //调用pushFrontViewController进行页面切换
//    [revealViewController pushFrontViewController:viewController animated:YES];

    
    
    SUPNavigationController* nav =(SUPNavigationController*)self.mm_drawerController.centerViewController;
    SUPLog(@"%@",nav);
    SUPLog(@"centerViewController=%@",self.mm_drawerController.centerViewController);
    [nav pushViewController:viewController animated:NO];
    
    //模态
//    [self presentViewController:viewController animated:NO completion:nil];
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
    
    
    
}

@end
