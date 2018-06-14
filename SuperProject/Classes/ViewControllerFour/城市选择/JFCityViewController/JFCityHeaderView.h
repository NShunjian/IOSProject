//
//  JFCityHeaderView.h
//  JFFootball
//
//  Created by 张志峰 on 2016/11/21.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JFCityHeaderViewDelegate <NSObject>

- (void)cityNameWithSelected:(BOOL)selected;
- (void)beginSearch;
- (void)endSearch;
- (void)searchResult:(NSString *)result;
@end

@interface JFCityHeaderView : UIView

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, weak) id<JFCityHeaderViewDelegate> delegate;

/// 取消搜索
- (void)cancelSearch;
@end
