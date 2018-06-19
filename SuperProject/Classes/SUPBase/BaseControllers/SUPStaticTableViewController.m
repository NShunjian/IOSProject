//
//  SUPBaseSettingViewController.m
//  NetLottery
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 163. All rights reserved.
//

#import "SUPStaticTableViewController.h"
#import "SUPSettingCell.h"

//const UIEdgeInsets tableViewDefaultSeparatorInset = {0, 15, 0, 0};
//const UIEdgeInsets tableViewDefaultLayoutMargins = {8, 8, 8, 8};

@interface SUPStaticTableViewController ()

@end

@implementation SUPStaticTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"self.tableView.separatorInset = %@, self.tableView.separatorInset = %@", NSStringFromUIEdgeInsets(self.tableView.separatorInset), NSStringFromUIEdgeInsets(self.tableView.layoutMargins));
    
//    self.tableView.separatorInset = UIEdgeInsetsZero;
//    self.tableView.layoutMargins = UIEdgeInsetsZero;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SUPWordItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    SUPSettingCell *cell = [SUPSettingCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleValue1];
    
    cell.item = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SUPWordItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    // 普通的cell
    if(item.itemOperation)
    {
        item.itemOperation(indexPath);
        return;
    }
    
    // 带箭头的cell
    if([item isKindOfClass:[SUPWordArrowItem class]])
    {
        SUPWordArrowItem *arrowItem = (SUPWordArrowItem *)item;
        
        if(arrowItem.destVc)
        {
            UIViewController *vc = [[arrowItem.destVc alloc] init];
            vc.navigationItem.title = arrowItem.title;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.sections[section].footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.sections[indexPath.section].items[indexPath.row].cellHeight;
}

- (NSMutableArray<SUPItemSection *> *)sections
{
    if(_sections == nil)
    {
        _sections = [NSMutableArray array];
    }
    return _sections;
}
- (SUPStaticTableViewController *(^)(SUPWordItem *))addItem {
    
    SUPWeakSelf(self);
    if (!self.sections.firstObject) {
        [self.sections addObject:[SUPItemSection sectionWithItems:@[] andHeaderTitle:nil footerTitle:nil]];
    }
    return  ^(SUPWordItem *item) {
        [weakself.sections.firstObject.items addObject:item];
        return weakself;
    };
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

@end
