//
//  SUPAddressPickerViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPAddressPickerViewController.h"
#import <MOFSPickerManager.h>

@interface SUPAddressPickerViewController ()


/** <#digest#> */
@property (weak, nonatomic) UIButton *selectBtn;


@end

@implementation SUPAddressPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self selectBtn];
    
    [self chooseCityCountry];
}


- (void)chooseCityCountry
{
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *address, NSString *zipcode) {
        
    } cancelBlock:^{
        
    }];
    
//    [[MOFSPickerManager shareManger] searchAddressByZipcode:@"450000-450900-450921" block:^(NSString *address) {
//
//        NSLog(@"%@",address);
//
//    }];
    
//    [[MOFSPickerManager shareManger] searchZipCodeByAddress:@"河北省-石家庄市-长安区" block:^(NSString *zipcode) {
//
//        NSLog(@"%@",zipcode);
//
//    }];
}

- (UIButton *)selectBtn
{
    if(_selectBtn == nil)
    {
        SUPWeakSelf(self);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"选择地址" forState: UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            
            [weakself chooseCityCountry];
        }];
        
        
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(100);
            make.height.mas_equalTo(AdaptedWidth(44));
            make.left.right.offset(0);
            
        }];
        
        _selectBtn = btn;
    }
    return _selectBtn;
}




#pragma mark 重写BaseViewController设置内容

- (UIColor *)SUPNavigationBackgroundColor:(SUPNavigationBar *)navigationBar
{
    return [UIColor RandomColor];
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
    return [self changeTitle:@"省市区三级联动"];;
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
