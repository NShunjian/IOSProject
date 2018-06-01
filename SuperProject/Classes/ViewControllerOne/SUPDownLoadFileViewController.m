//
//  SUPDownLoadFileViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPDownLoadFileViewController.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

static NSMutableArray *tasks;

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
//            [weakself uploadVideoWithEntity];
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

-(NSMutableArray *)tasks
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
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
    
//    NSString *fileDownLoadPath = @"https://s3.cn-north-1.amazonaws.com.cn/zplantest.s3.seed.meme2c.com/area/area.json";
    NSString *fileDownLoadPath = @"http://static.yizhibo.com/pc_live/static/video.swf?onPlay=YZB.play&onPause=YZB.pause&onSeek=YZB.seek&scid=pALRs7JBtTRU9TWy";
//    NSString *lastModified = [NSUserDefaults.standardUserDefaults stringForKey:@"Last-Modified"] ?: @"";
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fileDownLoadPath]];
//    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
//    服务器做对比, 不用重复下载
//    [request setValue:lastModified forHTTPHeaderField:@"If-Modified-Since"];
    
//    [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    
    SUPWeakSelf(self);
    NSLog(@"%@", request.allHTTPHeaderFields);
    MBProgressHUD *hud = [MBProgressHUD showProgressToView:weakself.view Text:@"下载中"];
    
    NSURLSessionTask *sessionTask = nil;
    
    [
     sessionTask =[[SUPRequestManager sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        hud.progress = (downloadProgress.completedUnitCount) / (CGFloat)(downloadProgress.totalUnitCount);
        NSLog(@"%lf", ((float)downloadProgress.completedUnitCount) / (downloadProgress.totalUnitCount));
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:[fileDownLoadPath lastPathComponent]]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
         [[self tasks] removeObject:sessionTask];
    
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        NSLog(@"%@", filePath);
        NSLog(@"%@", response);
        NSLog(@"%@", error);
        
        //获取Cache目录
        
        NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
        
        NSString *cachesPath = [cachesPaths objectAtIndex:0];
        
        NSLog(@"cachesPath:%@", cachesPath);
        
        
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//
//        NSString *lastModified = [httpResponse allHeaderFields][@"Last-Modified"];
//
//        if (lastModified) {
//            [NSUserDefaults.standardUserDefaults setObject:lastModified forKey:@"Last-Modified"];
//
//        }
//
//        NSLog(@"%@", lastModified);
        
        
    }] resume];
    
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    
}



//这个方法待研究  上传视频
- (void)uploadVideoWithEntity
{
    
    
    
    NSString *path1 = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents"]];
        /*! 获得视频资源 */
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:path1]  options:nil];
    
    /*! 压缩 */
    
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    
    /*! 创建日期格式化器 */
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    /*! 转化后直接写入Library---caches */
    NSString *videoWritePath = [NSString stringWithFormat:@"output-%@.mp4",[formatter stringFromDate:[NSDate date]]];
    NSString *outfilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", videoWritePath];
    
    AVAssetExportSession *avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    
    avAssetExport.outputURL = [NSURL fileURLWithPath:outfilePath];
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    
    
    /*! 检查地址中是否有中文 */
//    NSString *URLString = [NSURL URLWithString:@"/Users/cuishunjian/Desktop/百度/第31讲.mp4"] ? @"/Users/cuishunjian/Desktop/百度/第31讲.mp4" : [self strUTF8Encoding:@"/Users/cuishunjian/Desktop/百度/第31讲.mp4"];
    
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        switch ([avAssetExport status]) {
            case AVAssetExportSessionStatusCompleted:
            {
                [[SUPRequestManager sharedManager] POST:@"/Users/cuishunjian/Desktop/百度/csj.mp4" parameters:nil              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    NSURL *filePathURL2 = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", outfilePath]];
                    // 获得沙盒中的视频内容
                    [formData appendPartWithFileURL:filePathURL2 name:@"video" fileName:outfilePath mimeType:@"application/octet-stream" error:nil];
                    
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    NSLog(@"%lf", ((float)uploadProgress.completedUnitCount) / (uploadProgress.totalUnitCount));
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    NSLog(@"上传视频成功 = %@",responseObject);
                    
                   
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"上传视频失败 = %@", error);
                    
                }];
                break;
            }
            default:
                break;
        }
    }];
}
#pragma mark - url 中文格式化
- (NSString *)strUTF8Encoding:(NSString *)str
{
    /*! ios9适配的话 打开第一个 */
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0)
    {
        return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }
    else
    {
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
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
