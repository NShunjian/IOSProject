//
//  SUPTableSDWebImageViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
// 

#import "SUPTableSDWebImageViewController.h"
#import "VIDMoviePlayerViewController.h"
#import "SUPXGMVideo.h"

@interface SUPTableSDWebImageViewController ()
/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<SUPXGMVideo *> *videos;
@end

@implementation SUPTableSDWebImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)loadMore:(BOOL)isMore
{
    SUPWeakSelf(self);
    
    NSDictionary *parameters = @{@"type" : @"JSON"};
    
    [[SUPRequestManager sharedManager] GET:[SUPXMGBaseUrl stringByAppendingPathComponent:@"video"] parameters:parameters completion:^(SUPBaseResponse *response) {
        
        [weakself endHeaderFooterRefreshing];
        
        if (!response.error && response.responseObject) {
            weakself.videos = [SUPXGMVideo mj_objectArrayWithKeyValuesArray:response.responseObject[@"videos"]];
        } else {
            [weakself.view makeToast:response.errorMsg];
        }
        
        [weakself.tableView configBlankPage:SUPEasyBlankPageViewTypeNoData hasData:weakself.videos.count hasError:response.error reloadButtonBlock:^(id sender) {
            [weakself.tableView.mj_header beginRefreshing];
        }];
        
        [weakself.tableView.mj_footer setState:MJRefreshStateNoMoreData];
        [weakself.tableView reloadData];
    }];
}


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.imageView.SUP_size = CGSizeMake(80, 80);
    }
    
    [cell.imageView sd_setImageWithURL:self.videos[indexPath.row].image placeholderImage:[UIImage imageNamed:@"public_empty_loading"]];
    
    cell.textLabel.text = self.videos[indexPath.row].ID;
    
    cell.detailTextLabel.text = self.videos[indexPath.row].name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VIDMoviePlayerViewController *playerVc = [[VIDMoviePlayerViewController alloc] init];
    playerVc.videoURL = self.videos[indexPath.row].url.absoluteString;
    
    [self.navigationController pushViewController:playerVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSMutableArray<SUPXGMVideo *> *)videos
{
    if(!_videos)
    {
        _videos = [NSMutableArray array];
    }
    return _videos;
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
