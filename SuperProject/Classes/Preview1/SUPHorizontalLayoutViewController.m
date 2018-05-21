//
//  SUPHorizontalLayoutViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPHorizontalLayoutViewController.h"

@interface SUPHorizontalLayoutViewController ()<SUPHorizontalFlowLayoutDelegate>

@end

@implementation SUPHorizontalLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.backgroundColor = [UIColor RandomColor];
 
    self.collectionView.contentInset = UIEdgeInsetsZero;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(100, 20, 100, 20));
    }];
    
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}


#pragma mark - SUPCollectionViewControllerDataSource

- (UICollectionViewLayout *)collectionViewController:(SUPCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView
{
    SUPHorizontalFlowLayout *layout = [[SUPHorizontalFlowLayout alloc] initWithDelegate:self];
    
    
    return layout;
}


#pragma mark - SUPHorizontalFlowLayoutDelegate

- (CGFloat)waterflowLayout:(SUPHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView widthForItemAtIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight
{
    
    return (arc4random() % 4 + 1) * itemHeight;
}


- (NSInteger)waterflowLayout:(SUPHorizontalFlowLayout *)waterflowLayout linesInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}



#pragma mark - SUPNavUIBaseViewControllerDataSource
//- (BOOL)navUIBaseViewControllerIsNeedNavBar:(SUPNavUIBaseViewController *)navUIBaseViewController
//{
//    return YES;
//}

/**头部标题*/
- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar
{
    return [self changeTitle:self.title];
}

/** 背景图片 */
//- (UIImage *)SUPNavigationBarBackgroundImage:(SUPNavigationBar *)navigationBar
//{
//
//}

/** 背景色 */
//- (UIColor *)SUPNavigationBackgroundColor:(SUPNavigationBar *)navigationBar
//{
//
//}

/** 是否隐藏底部黑线 */
//- (BOOL)SUPNavigationIsHideBottomLine:(SUPNavigationBar *)navigationBar
//{
//    return NO;
//}

/** 导航条的高度 */
//- (CGFloat)SUPNavigationHeight:(SUPNavigationBar *)navigationBar
//{
//
//}


/** 导航条的左边的 view */
//- (UIView *)SUPNavigationBarLeftView:(SUPNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的 view */
//- (UIView *)SUPNavigationBarRightView:(SUPNavigationBar *)navigationBar
//{
//
//}
/** 导航条中间的 View */
//- (UIView *)SUPNavigationBarTitleView:(SUPNavigationBar *)navigationBar
//{
//
//}
/** 导航条左边的按钮 */
- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    
    [leftButton setTitle:@"< 返回" forState:UIControlStateNormal];
    
    leftButton.SUP_width = 60;
    
    [leftButton setTitleColor:[UIColor RandomColor] forState:UIControlStateNormal];
    
    return nil;
}
/** 导航条右边的按钮 */
//- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
//{
//
//}



#pragma mark - SUPNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    
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
