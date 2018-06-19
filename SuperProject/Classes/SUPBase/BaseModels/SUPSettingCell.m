//
//  SUPSettingCell.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPSettingCell.h"
#import "SUPWordItem.h"
#import "SUPWordArrowItem.h"
#import "SUPItemSection.h"


@interface SUPSettingCell ()

@end

@implementation SUPSettingCell

static NSString *const ID = @"cellSetting";
+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style
{
    SUPSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupBaseSettingCellUI];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupBaseSettingCellUI];
}


- (void)setupBaseSettingCellUI
{
    self.detailTextLabel.numberOfLines = 0;
}

- (void)setItem:(SUPWordItem *)item
{
    _item = item;
    
    [self fillData];
    
    [self changeUI];
}

- (void)fillData
{
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.subTitle;
//    self.imageView.image = self.item.image;
    
    /** 左边的图片 UIImage 或者 NSURL 或者 URLString 或者 ImageName */
    if ([self.item.image isKindOfClass:[UIImage class]]) {
        self.imageView.image = self.item.image;
    }else if ([self.item.image isKindOfClass:[NSURL class]]) {
        [self.imageView sd_setImageWithURL:self.item.image];
    }else if ([self.item.image isKindOfClass:[NSString class]]) {
        
        if ([self.item.image hasPrefix:@"http://"] || [self.item.image hasPrefix:@"https://"] || [self.item.image hasPrefix:@"file://"]) {
            
            NSString *imageUrl = [self.item.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }else {
            self.imageView.image = [UIImage imageNamed:self.item.image];
        }
    }
}

- (void)changeUI
{
    self.textLabel.font = self.item.titleFont;
    self.textLabel.textColor = self.item.titleColor;
    
    self.detailTextLabel.font = self.item.subTitleFont;
    self.detailTextLabel.textColor = self.item.subTitleColor;
    self.detailTextLabel.numberOfLines = self.item.subTitleNumberOfLines;
    
    if ([self.item isKindOfClass:[SUPWordArrowItem class]]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else
    {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (self.item.itemOperation || [self.item isKindOfClass:[SUPWordArrowItem class]]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }else
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}



@end
