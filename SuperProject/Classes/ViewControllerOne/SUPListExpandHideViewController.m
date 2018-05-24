//
//  SUPListExpandHideViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPListExpandHideViewController.h"
#import "SUPGroup.h"
#import "SUPTeam.h"
#import "SUPListExpendHeaderView.h"

@interface SUPListExpandHideViewController ()

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<SUPGroup *> *groups;

@end

@implementation SUPListExpandHideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups[section].isOpened ? self.groups[section].teams.count : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.groups[section].name;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const ID = @"team";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
    }
    
    
    cell.textLabel.text = self.groups[indexPath.section].teams[indexPath.row].sortNumber;
    cell.detailTextLabel.text = self.groups[indexPath.section].teams[indexPath.row].name;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SUPListExpendHeaderView *headerView = [SUPListExpendHeaderView headerViewWithTableView:tableView];
    
    headerView.group = self.groups[section];
    SUPWeakSelf(self);
    [headerView setSelectGroup:^BOOL{
        
        weakself.groups[section].isOpened = !weakself.groups[section].isOpened;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakself.tableView reloadData];
            
        });
        
        return weakself.groups[section].isOpened;
    }];
    
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (NSMutableArray<SUPGroup *> *)groups
{
    if (_groups == nil) {
        
        
        _groups = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"team_dictionary" ofType:@"plist"];
        //        NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];
        NSDictionary *dictDict = [NSDictionary dictionaryWithContentsOfFile:path];
        
        [dictDict enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSArray<NSString *>  *obj, BOOL * _Nonnull stop) {
            
            SUPGroup *group = [SUPGroup new];
            
            group.isOpened = YES;
            
            group.name = key.copy;
            
            [obj enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                SUPTeam *team = [SUPTeam new];
                
                team.sortNumber = [NSString stringWithFormat:@"%zd", idx];
                team.name = [obj copy];
                
                [group.teams addObject:team];
                
            }];
            
            [_groups addObject:group];
        }];
        
        
        [_groups sortUsingComparator:^NSComparisonResult(SUPTeam * _Nonnull obj1, SUPTeam * _Nonnull obj2) {
            
            return [obj1.name compare:obj2.name] == NSOrderedAscending ? NSOrderedAscending : NSOrderedDescending;
        }];
    }
    return _groups;
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
