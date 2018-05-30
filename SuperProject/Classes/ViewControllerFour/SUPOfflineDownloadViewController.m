//
//  SUPOfflineDownloadViewController.m
//  iOSProject
//
//  Created by HuXuPeng on 2018/2/26.
//  Copyright © 2018年 github.com/njhu. All rights reserved.
//

#import "SUPOfflineDownloadViewController.h"
#import "MJDownload.h"
#import "VIDMoviePlayerViewController.h"
#import "SUPSettingCell.h"
@interface SUPOfflineDownloadViewController ()

@end

@implementation SUPOfflineDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<NSString *> *urls = @[
                                  @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.2.4.dmg",
                                  @"http://120.25.226.186:32812/resources/videos/minion_02.mp4",
                                  @"http://120.25.226.186:32812/resources/videos/minion_03.mp4",
                                  @"http://120.25.226.186:32812/resources/videos/minion_04.mp4",
                                  @"http://120.25.226.186:32812/resources/videos/minion_05.mp4",
                                  @"http://120.25.226.186:32812/resources/videos/minion_06.mp4",
                                  @"http://120.25.226.186:32812/resources/videos/minion_07.mp4",
                                  @"http://120.25.226.186:32812/resources/videos/minion_08.mp4",
                                  @"http://120.25.226.186:32812/resources/videos/minion_09.mp4",
                                  @"http://120.25.226.186:32812/resources/videos/minion_10.mp4"
                                  ];
    
    self.title = @"点击Cell开始/暂停下载";
    SUPWeakSelf(self);
    [urls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MJDownloadInfo *info = [[MJDownloadManager defaultManager] downloadInfoForURL:obj];
        
        NSString *subTitle = nil;
        if (info.state == MJDownloadStateCompleted) {
            subTitle = @"播放";
        }else {
            CGFloat progress = ((CGFloat)info.totalBytesWritten) / info.totalBytesExpectedToWrite * 100;
            subTitle = [NSString stringWithFormat:@"进度: %.2f%%, 点击开始", isnan(progress) ? 0 : progress];
        }
        
        self.addItem([SUPWordItem itemWithTitle:obj.lastPathComponent subTitle:subTitle itemOperation:^(NSIndexPath *indexPath) {
            
            if (info.state == MJDownloadStateResumed || info.state == MJDownloadStateWillResume) {

                [[MJDownloadManager defaultManager] suspend:info.url];
                
                CGFloat progress = ((CGFloat)info.totalBytesWritten) / info.totalBytesExpectedToWrite * 100;
                
                weakself.sections.firstObject.items[indexPath.row].subTitle = [NSString stringWithFormat:@"暂停中..进度: %.2f%%", isnan(progress) ? 0 : progress];
                
                ((SUPSettingCell *)[weakself.tableView cellForRowAtIndexPath:indexPath]).item = weakself.sections.firstObject.items[indexPath.row];
                
            } else if (info.state == MJDownloadStateSuspened || info.state == MJDownloadStateNone) {
                
                [[MJDownloadManager defaultManager] download:obj progress:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        weakself.sections.firstObject.items[indexPath.row].subTitle = [NSString stringWithFormat:@"进度: %.2f%%", (CGFloat)totalBytesWritten / totalBytesExpectedToWrite * 100.0];

                        ((SUPSettingCell *)[weakself.tableView cellForRowAtIndexPath:indexPath]).item = weakself.sections.firstObject.items[indexPath.row];
                    });
                } state:^(MJDownloadState state, NSString *file, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (state == MJDownloadStateCompleted) {
                            weakself.sections.firstObject.items[indexPath.row].subTitle = @"播放";

                            ((SUPSettingCell *)[weakself.tableView cellForRowAtIndexPath:indexPath]).item = weakself.sections.firstObject.items[indexPath.row];
                        }
                    });
                }];
                
            }else if (info.state == MJDownloadStateCompleted) {
                
                VIDMoviePlayerViewController *playerVc = [[VIDMoviePlayerViewController alloc] init];
                playerVc.videoURL = [NSString stringWithFormat:@"file://%@", info.file];
                [weakself.navigationController pushViewController:playerVc animated:YES];
                
            }
            
        }]);
    }];
    
    self.addItem([SUPWordItem itemWithTitle:@"全部开始" subTitle: nil itemOperation:^(NSIndexPath *indexPath) {
        [[MJDownloadManager defaultManager] resumeAll];
    }]).addItem([SUPWordItem itemWithTitle:@"全部暂停" subTitle: nil itemOperation:^(NSIndexPath *indexPath) {
        [[MJDownloadManager defaultManager] suspendAll];
    }]);
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
