//
//  JFCityTableViewCell.h
//  JFFootball
//
//  Created by 张志峰 on 2016/11/21.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

//选择定位城市、历史访问城市和热门城市的通知（用来修改“当前：”后面的城市名称）
extern NSString * const JFCityTableViewCellDidChangeCityNotification;

@interface JFCityTableViewCell : UITableViewCell

@property (nonatomic, copy) NSArray *cityNameArray;

@end
