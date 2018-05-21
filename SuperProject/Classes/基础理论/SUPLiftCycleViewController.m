//
//  SUPLiftCycleViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPLiftCycleViewController.h"

@interface SUPLiftCycleViewController ()

/** <#digest#> */
@property (weak, nonatomic) UITextView *inputTextView;

@end

@implementation SUPLiftCycleViewController


- (void)loadView
{
    [super loadView];
    
    [self life:__FUNCTION__];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%s",__FUNCTION__);
    
    UIView *oneView = [[UIView alloc] initWithFrame:CGRectMake(100, self.SUP_navgationBar.SUP_height, 100, 100)];
    
    [self.view addSubview:oneView];
    
    
    UIView *twoView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    [self.view addSubview:twoView];
    
    
    [self life:__FUNCTION__];
}


- (void)life:(const char *)func
{
    NSMutableString *strM = [NSMutableString stringWithFormat:@"%@", self.inputTextView.text ?: @""];
    
    [strM appendString:[NSString stringWithUTF8String:func]];
    
    self.inputTextView.text = [strM.copy stringByAppendingString:@"\n"];
    
}

- (UITextView *)inputTextView
{
    if(_inputTextView == nil)
    {
        UITextView *textView = [[UITextView alloc] init];
        
        [self.view addSubview:textView];
        
        //        textView.userInteractionEnabled = YES;
        //        textView.editable = YES;
        //        textView.selectable = NO;
        //        textView.scrollEnabled = YES;
        
        //        [textView addPlaceHolder:@"我是占位的"];
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(100, 0, 0, 0));
            
        }];
        
        textView.textColor = [UIColor RandomColor];
        textView.font = AdaptedFontSize(16);
        
        _inputTextView = textView;
        
    }
    return _inputTextView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self life:__FUNCTION__];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self life:__FUNCTION__];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self life:__FUNCTION__];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self life:__FUNCTION__];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self life:__FUNCTION__];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self life:__FUNCTION__];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self life:__FUNCTION__];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self life:__FUNCTION__];
}



#pragma mark 重写BaseViewController设置内容

- (UIColor *)SUPNavigationBackgroundColor:(SUPNavigationBar *)navigationBar
{
    return [UIColor yellowColor];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

- (void)titleClickEvent:(UILabel *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    NSLog(@"%@", sender);
}

- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar
{
    return [self changeTitle:@"生命周期"];
}

- (UIImage *)SUPNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"navigationButtonReturnClick"];
}


- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
{
    rightButton.backgroundColor = [UIColor RandomColor];
    
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
