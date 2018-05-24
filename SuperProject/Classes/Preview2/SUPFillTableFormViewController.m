//
//  SUPFillTableFormViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPFillTableFormViewController.h"
#import <MOFSPickerManager.h>
#import "SUPSettingCell.h"

@interface SUPFillTableFormViewController ()

@property (nonatomic,assign)NSInteger section;
@end

@implementation SUPFillTableFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SUPWeakSelf(self);
    SUPWordItem *item0 = [SUPWordArrowItem itemWithTitle:@"系统设置" subTitle: nil];
    item0.image = [UIImage imageNamed:@"mine-setting-icon"];
    [item0 setItemOperation:^void(NSIndexPath *indexPath){
        
        [weakself.view makeToast:@"跳转成功"];
        
    }];
    
    SUPWordItem *item1 = [SUPWordItem itemWithTitle:@"姓名" subTitle:@"请输入姓名"];
    item1.subTitleColor = [UIColor lightGrayColor];
//    SUPWeakSelf(item1);
    [item1 setItemOperation:^void(NSIndexPath *indexPath){
        // 拿到cell
        UITableViewCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPath];
        
        UITextField *textF = [cell.contentView viewWithTag:indexPath.row + 100];
        self.section = indexPath.section;
        // 创建textF
        if (!textF) {
            textF = [[UITextField alloc] init];
            textF.tag = indexPath.row + 100;
            textF.delegate = self;
            textF.textColor = [UIColor clearColor];
            [cell.contentView addSubview:textF];
        }

        [textF becomeFirstResponder];
    }];
    
    
    SUPWordItem *item2 = [SUPWordArrowItem itemWithTitle:@"性别" subTitle: @"请选择出性别"];
    item2.subTitleColor = [UIColor lightGrayColor];
    
    SUPWeakSelf(item2);
    [item2 setItemOperation:^void(NSIndexPath *indexPath){
        self.section = indexPath.section;
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"男",@"女"] tag:1 title:nil cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
            
            weakitem2.subTitle = string;
            [weakself.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
            
        } cancelBlock:^{
            
            
        }];
        
    }];
    
    SUPWordItem *item3 = [SUPWordArrowItem itemWithTitle:@"生日" subTitle: @"请选择出生日期"];
    item3.subTitleColor = [UIColor lightGrayColor];
    SUPWeakSelf(item3);
    [item3 setItemOperation:^void(NSIndexPath *indexPath){
        self.section = indexPath.section;
//        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
//        [MOFSPickerManager shareManger].datePicker.locale = locale;
        [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
            weakitem3.subTitle = [date stringWithFormat:@"yyyy-MM-dd"];
            [weakself.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
        } cancelBlock:^{
            
        }];
        
    }];
    
    
    // 占位
    SUPWordItem *item4 = [SUPWordItem itemWithTitle:@"家庭地址" subTitle:@"请输入家庭地址"];
//    SUPWeakSelf(item4);
    [item4 setItemOperation:^void(NSIndexPath *indexPath){
        self.section = indexPath.section;
        // 拿到cell
        UITableViewCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPath];
        
        UITextField *textF = [cell.contentView viewWithTag:indexPath.row + 100];
        // 创建textF
        if (!textF) {
            textF = [[UITextField alloc] init];
            textF.tag = indexPath.row + 100;
            textF.delegate = self;
            textF.textColor = [UIColor clearColor];
            [cell.contentView addSubview:textF];
        }
        
        [textF becomeFirstResponder];
    }];
    
    
    SUPItemSection *section0 = [SUPItemSection sectionWithItems:@[item4, item3, item2, item1, item0] andHeaderTitle:nil footerTitle:nil];
    
    [self.sections addObject:section0];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string].stringByTrim;
    NSLog(@"%@", current);
    SUPWordItem *item = self.sections[self.section].items[textField.tag - 100];
    item.subTitle = current;
    
    SUPSettingCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag - 100 inSection:self.section]];
//    SUPWordItem *item = self.sections.firstObject.items[textField.tag - 100];
//
//    item.subTitle = current;
//
//    SUPSettingCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag - 100 inSection:0]];
    cell.item = item;
    
    return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
