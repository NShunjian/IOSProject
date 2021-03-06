//
//  SUPSearchBarViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/5/30.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPSearchBarViewController.h"
@interface SUPSearchBarViewController ()<JiaSearchBarDelegate>
@property(strong,nonatomic)JiaSearchBar *myJiaSearchBar;
@end

@implementation SUPSearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!_myJiaSearchBar) {
        self.myJiaSearchBar = [[JiaSearchBar alloc]initWithFrame:CGRectMake(0, 64, SUPScreenWidth, 44)];
        self.myJiaSearchBar.delegate=self;
        self.myJiaSearchBar.placeholder = @"请输入当前城市";
        self.myJiaSearchBar.placeholderColor = [UIColor purpleColor];
        
        self.myJiaSearchBar.backgroundColor = [UIColor yellowColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        view.backgroundColor = [UIColor redColor];
        self.myJiaSearchBar.keyboardType=UIKeyboardTypeDefault;
        //self.myJiaSearchBar.inputAccessoryView =view;
        [self.myJiaSearchBar.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.view addSubview:self.myJiaSearchBar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark JiaSearchBarDelegate

-(BOOL)searchBarShouldBeginEditing:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
    
}
- (void)searchBarTextDidBeginEditing:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (BOOL)searchBarShouldEndEditing:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
}
- (void)searchBarTextDidEndEditing:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (void)searchBar:(JiaSearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (BOOL)searchBar:(JiaSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
    
}
- (void)searchBarSearchButtonClicked:(JiaSearchBar *)searchBar{
    NSLog(@"输出的内容：%@",searchBar.text);
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (void)searchBarCancelButtonClicked:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
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

@end
