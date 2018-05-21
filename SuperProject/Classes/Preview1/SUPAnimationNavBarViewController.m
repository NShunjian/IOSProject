//
//  SUPAnimationNavBarViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPAnimationNavBarViewController.h"

@interface SUPAnimationNavBarViewController ()

/** <#digest#> */
@property (assign, nonatomic) UIControlState isColorChange;

@end

@implementation SUPAnimationNavBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isColorChange = YES;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollViewDidScroll:self.tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (_isColorChange) {
        CGFloat contentOffsetY = self.tableView.contentOffset.y + self.tableView.contentInset.top;
        
        if (contentOffsetY == 0) {
            
            [self changeNavigationBarTranslationY:0];
            [self changeNavgationBarBackgroundColor:[UIColor clearColor]];
            [self changeNavigationBarHeight:[self SUPNavigationHeight:nil]];
            
        }else if (contentOffsetY < 0)
        {
            [self changeNavigationBarTranslationY:-[self SUPNavigationHeight:nil]];
        }else
        {
            [self changeNavigationBarTranslationY:0];
            
            UIColor *redColor = [self SUPNavigationBackgroundColor:nil];
            
            redColor = [redColor colorWithAlphaComponent:(contentOffsetY/ (([self SUPNavigationHeight:nil] + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)) * 2.0 * 0.63))];
            
            [self changeNavigationBarHeight:[self SUPNavigationHeight:nil]];
            
            [self changeNavgationBarBackgroundColor:redColor];
        }
    }
    
    
    if (!_isColorChange) {
        
        [self changeNavgationBarBackgroundColor:[self SUPNavigationBackgroundColor:nil]];
        
        CGFloat contentOffsetY = self.tableView.contentOffset.y + self.tableView.contentInset.top;
        
        CGFloat scale = (contentOffsetY / (([self SUPNavigationHeight:nil] + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)) * 2.0 * 0.63));
        
        if (scale > 2) {
            scale = 2;
        }
        
        if (scale < 1) {
            scale = 1;
        }
        
        [self changeNavigationBarHeight:[self SUPNavigationHeight:nil] * scale];
        
    }
    
    
}


#pragma mark 重写BaseViewController设置内容

- (UIColor *)SUPNavigationBackgroundColor:(SUPNavigationBar *)navigationBar
{
    return [[UIColor purpleColor] colorWithAlphaComponent:0.63];
}

- (BOOL)SUPNavigationIsHideBottomLine:(SUPNavigationBar *)navigationBar
{
    return YES;
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    sender.selected = !sender.isSelected;
    NSLog(@"%s  ,%d", __func__,sender.selected);
    self.isColorChange = !sender.selected;
}

- (void)titleClickEvent:(UILabel *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%@", sender);
}

- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar
{
    return [self changeTitle:@"导航条颜色或者高度渐变"];;
}

- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"navigationButtonReturnClick"];
}


- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
{
    UIButton *btn = rightButton;
    btn.backgroundColor = [UIColor RandomColor];
    
    [btn setTitle:@"颜色渐变" forState:UIControlStateNormal];
    
    [btn setTitle:@"高度渐变" forState:UIControlStateSelected];
    
    [btn sizeToFit];
    
    btn.SUP_height = 44.0;
     NSLog(@"%d",btn.selected);
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


#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
    return cell;
    
}


@end
