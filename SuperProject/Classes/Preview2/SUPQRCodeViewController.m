//
//  SUPQRCodeViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPQRCodeViewController.h"
#import <HMScannerController.h>
#import <AVFoundation/AVFoundation.h>//调用闪光灯需要导入该框架
@interface SUPQRCodeViewController ()
/** <#digest#> */
@property (weak, nonatomic) UIImageView *myImageView;

/** <#digest#> */
@property (weak, nonatomic) UILabel *contentLabel;

@property (nonatomic,weak)UIButton *button;
/**
 @brief  闪关灯开启状态记录
 */
@property(nonatomic,assign)BOOL isOpenFlash;
@end

@implementation SUPQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOpenFlash = YES;
    
    [HMScannerController cardImageWithCardName:@"https://www.baidu.com" avatar:[UIImage imageNamed:@"cui"] scale:0.5 completion:^(UIImage *image) {
        
        self.myImageView.image = image;
        
    }];
    [self.button addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    
}




#pragma mark - settter
- (void)showScanner
{//必须的获取添加相机权限
    HMScannerController *scanner = [HMScannerController scannerWithCardName:@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=图片&hs=0&pn=4&spn=0&di=108514948320&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=4045128625%2C1915204867&os=1290015247%2C3536223022&simid=0%2C0&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=13&oriquery=&objurl=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%3Dshijue1%2C0%2C0%2C294%2C40%2Fsign%3D206fa8435c4e9258b2398eadf4ebbb2d%2Fd009b3de9c82d158e5f319968a0a19d8bc3e42a7.jpg&fromurl=ipprf_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bev2_z%26e3Bv54AzdH3Fv6jwptejAzdH3Fb8amcd8am&gsm=0" avatar:[UIImage imageNamed:@"cui"] completion:^(NSString *stringValue) {
        
        self.contentLabel.text = stringValue;
        [self closed];
        NSLog(@"%@",stringValue);
        
    }];
    
    [scanner setTitleColor:[UIColor redColor] tintColor:[UIColor yellowColor]];
    
    [self showDetailViewController:scanner sender:nil];
    
}



#pragma mark - getter

- (UIImageView *)myImageView
{
    if(_myImageView == nil)
    {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:imageView];
        _myImageView = imageView;
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(100);
            make.right.offset(-100);
            make.top.offset(100);
            
            make.height.equalTo(imageView.mas_width).multipliedBy(1);
            
        }];
        
        
    }
    return _myImageView;
}


- (UILabel *)contentLabel
{
    if(_contentLabel == nil)
    {
        UILabel *label = [[UILabel alloc] init];
        
        [self.view addSubview:label];
        
        _contentLabel = label;
        
        label.numberOfLines = 0;
        
        label.textColor = [UIColor blackColor];
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self.myImageView);
            make.top.equalTo(self.myImageView.mas_bottom).offset(20);
            
        }];
    }
    return _contentLabel;
}
-(UIButton *)button{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(120, 500, 150, 30)];
    [self.view addSubview:btn];
    self.button = btn;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"手电筒" forState:UIControlStateNormal];
    
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.equalTo(self.myImageView);
//        make.top.equalTo(self.myImageView.mas_bottom).offset(20);
//
//    }];
    return btn;
}

//开关闪光灯
- (void)openOrCloseFlash
{       NSLog(@"闪光灯");
    

        if (self.isOpenFlash == YES) { //打开闪光灯
            self.isOpenFlash = !self.isOpenFlash;
            NSLog(@"%zd",self.isOpenFlash);
            AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            NSError *error = nil;
            
            if ([captureDevice hasTorch]) {
                BOOL locked = [captureDevice lockForConfiguration:&error];
                if (locked) {
                    captureDevice.torchMode = AVCaptureTorchModeOn;
                    [captureDevice unlockForConfiguration];
                }
            }
        }else{//关闭闪光灯
            self.isOpenFlash = YES;
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if ([device hasTorch]) {
                [device lockForConfiguration:nil];
                [device setTorchMode: AVCaptureTorchModeOff];
                [device unlockForConfiguration];
            }
        
        
        
    }

}
-(void)closed{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}
#pragma mark - SUPNavUIBaseViewControllerDataSource


- (UIImage *)SUPNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(SUPNavigationBar *)navigationBar
{
    [rightButton setTitle:@"扫一扫" forState: UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    return nil;
}

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


- (void)rightButtonEvent:(UIButton *)sender navigationBar:(SUPNavigationBar *)navigationBar
{
    [self showScanner];
}

@end
