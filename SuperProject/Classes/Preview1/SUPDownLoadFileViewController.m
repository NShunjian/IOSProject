//
//  SUPDownLoadFileViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPDownLoadFileViewController.h"

@interface SUPDownLoadFileViewController ()

/** <#digest#> */
@property (weak, nonatomic) UIButton *downBtn;

/** <#digest#> */
@property (weak, nonatomic) UIButton *memoryFileBtn;

/** <#digest#> */
@property (nonatomic, strong) NSArray *addressArray;

@end

@implementation SUPDownLoadFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    
    
    [self.memoryFileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
}


- (UIButton *)downBtn
{
    if(_downBtn == nil)
    {
        SUPWeakSelf(self);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44) buttonTitle:@"下载文件点击" normalBGColor:[UIColor greenColor] selectBGColor:[UIColor lightGrayColor] normalColor:[UIColor redColor] selectColor:[UIColor whiteColor] buttonFont:[UIFont systemFontOfSize:17] cornerRadius:5 doneBlock:^(UIButton *button) {
            
            [weakself downloadFile];
            
        }];
        
        
        [self.view addSubview:btn];
        
        _downBtn = btn;
        
    }
    return _downBtn;
}


- (UIButton *)memoryFileBtn
{
    if(_memoryFileBtn == nil)
    {
        SUPWeakSelf(self);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44) buttonTitle:@"加载内存文件" normalBGColor:[UIColor greenColor] selectBGColor:[UIColor lightGrayColor] normalColor:[UIColor redColor] selectColor:[UIColor whiteColor] buttonFont:[UIFont systemFontOfSize:17] cornerRadius:5 doneBlock:^(UIButton *button) {

            
            CFTimeInterval start = CFAbsoluteTimeGetCurrent();
            
            NSString *path = @"/Users/uihunian/Desktop/area.json";
//            @"/Users/huxupeng/Demo/area.json";
            NSData *data = [NSData dataWithContentsOfFile:path];
            
            //        for (NSInteger i = 0; i < 1000; i++) {
            
            if (data.length) {
                weakself.addressArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            }
            NSLog(@"%@",weakself.addressArray);
            
            //        }
            
            NSLog(@"%f", (CFAbsoluteTimeGetCurrent() - start));
            
        }];
        
        
        [self.view addSubview:btn];
        
        _memoryFileBtn = btn;
        
    }
    return _memoryFileBtn;
}

- (void)downloadFile
{
    
    NSLog(@"%s", __func__);
    
    /*
     1.NSURLRequestUseProtocolCachePolicy NSURLRequest                  默认的cache policy，使用Protocol协议定义。
     2.NSURLRequestReloadIgnoringCacheData                                        忽略缓存直接从原始地址下载。
     3.NSURLRequestReturnCacheDataDontLoad                                     只使用cache数据，如果不存在cache，请求失败；用于没有建立网络连接离线模式
     4.NSURLRequestReturnCacheDataElseLoad                                     只有在cache中不存在data时才从原始地址下载。
     5.NSURLRequestReloadIgnoringLocalAndRemoteCacheData           忽略本地和远程的缓存数据，直接从原始地址下载，与NSURLRequestReloadIgnoringCacheData类似。
     6.NSURLRequestReloadRevalidatingCacheData                              :验证本地数据与远程数据是否相同，如果不同则下载远程数据，否则使用本地数据
     
     */
    
    NSString *fileDownLoadPath = @"https://s3.cn-north-1.amazonaws.com.cn/zplantest.s3.seed.meme2c.com/area/area.json";
    
    NSString *lastModified = [NSUserDefaults.standardUserDefaults stringForKey:@"Last-Modified"] ?: @"";
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fileDownLoadPath]];
//    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
//    服务器做对比, 不用重复下载
    [request setValue:lastModified forHTTPHeaderField:@"If-Modified-Since"];
    
    [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    
    SUPWeakSelf(self);
    NSLog(@"%@", request.allHTTPHeaderFields);
    MBProgressHUD *hud = [MBProgressHUD showProgressToView:weakself.view Text:@"下载中"];
    [[[SUPRequestManager sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        hud.progress = (downloadProgress.completedUnitCount) / (CGFloat)(downloadProgress.totalUnitCount);
        NSLog(@"%lf", ((float)downloadProgress.completedUnitCount) / (downloadProgress.totalUnitCount));
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:[fileDownLoadPath lastPathComponent]]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        NSLog(@"%@", filePath);
        NSLog(@"%@", response);
        NSLog(@"%@", error);
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        NSString *lastModified = [httpResponse allHeaderFields][@"Last-Modified"];
        
        if (lastModified) {
            [NSUserDefaults.standardUserDefaults setObject:lastModified forKey:@"Last-Modified"];
            
        }
        
        NSLog(@"%@", lastModified);
        
        
    }] resume];
    
    
}



#pragma mark - SUPNavUIBaseViewControllerDataSource
//- (BOOL)navUIBaseViewControllerIsNeedNavBar:(SUPNavUIBaseViewController *)navUIBaseViewController
//{
//    return YES;
//}

//- (UIStatusBarStyle)navUIBaseViewControllerPreferStatusBarStyle:(SUPNavUIBaseViewController *)navUIBaseViewController
//{
//    return UIStatusBarStyleDefault;
//}

/**头部标题*/
- (NSMutableAttributedString*)SUPNavigationBarTitle:(SUPNavigationBar *)navigationBar
{
    return [self changeTitle:self.navigationItem.title];
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
    
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, title.length)];
    
    return title;
}

@end
