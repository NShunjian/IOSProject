//
//  SUPDownLoadFileViewControllerTWO.m
//  SuperProject
//
//  Created by NShunJian on 2018/5/28.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPDownLoadFileViewControllerTWO.h"
#import "MBProgressHUD+SUP.h"
@interface SUPDownLoadFileViewControllerTWO ()

@end

@implementation SUPDownLoadFileViewControllerTWO

- (void)viewDidLoad {
    [super viewDidLoad];
    SUPWeakSelf(self);
    self.addItem([SUPWordItem itemWithTitle:@"点击下载" subTitle:@"不会重复下载" itemOperation:^(NSIndexPath *indexPath) {
        [weakself downloadFile];
    }]);
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
    
    NSString *lastModified = [NSUserDefaults.standardUserDefaults stringForKey:@"areajson_Last_Modified"] ?: @"";
//    if (lastModified) {
//
//    }else{
//        lastModified = @"";
//    }
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fileDownLoadPath]];
    //    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    //    服务器做对比, 不用重复下载  (服务器接收到进行对比,后台处理)
    [request setValue:lastModified forHTTPHeaderField:@"If-Modified-Since"];
    
    [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    
    SUPWeakSelf(self);
    NSLog(@"%@", request);
    NSLog(@"%@", request.allHTTPHeaderFields);
    MBProgressHUD *hud = [MBProgressHUD showProgressToView:weakself.view Text:@"下载中"];
    [[[SUPRequestManager sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        hud.progress = (downloadProgress.completedUnitCount) / (CGFloat)(downloadProgress.totalUnitCount);
        NSLog(@"%lf", ((float)downloadProgress.completedUnitCount) / (downloadProgress.totalUnitCount));
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:[fileDownLoadPath lastPathComponent]]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        NSLog(@"filePath=%@", filePath);
        NSLog(@"response=%@", response);
        NSLog(@"error=%@", error);
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        [self.view makeToast:[NSString stringWithFormat:@"statuscode: %zd, \n200是下载成功, 304是不用下载", httpResponse.statusCode]];
        
        NSString *lastModified = [httpResponse allHeaderFields][@"Last-Modified"];
        SUPLog(@"%@",httpResponse.allHeaderFields);
        if (lastModified && !error) {
            [NSUserDefaults.standardUserDefaults setObject:lastModified forKey:@"areajson_Last_Modified"];
        }
        
        NSLog(@"%@", lastModified);
        
    }] resume];
    
    
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
