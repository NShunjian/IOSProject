//
//  JFCityHeaderView.m
//  JFFootball
//
//  Created by 张志峰 on 2016/11/21.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFCityHeaderView.h"

#import "Masonry.h"
#import "JFButton.h"

#define JFRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

@interface JFCityHeaderView ()<UISearchBarDelegate>

@property (nonatomic, strong) UILabel *currentCityLabel;
@property (nonatomic, strong) JFButton *button;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation JFCityHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSearchBar];
        [self addLabels];
        [self addJFButton];
    }
    return self;
}

- (void)setCityName:(NSString *)cityName {
    self.currentCityLabel.text = cityName;
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    self.button.title = buttonTitle;
}

- (void)addSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.placeholder = @"输入城市名称";
    [self addSubview:searchBar];
    self.searchBar = searchBar;
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(self.bounds.size.width - 10);
        make.height.offset(40);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = JFRGBAColor(155, 155, 155, 0.5);
    [self addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(self.bounds.size.width);
        make.height.offset(0.5);
        make.top.equalTo(searchBar.mas_bottom).offset(0);
    }];
}

- (void)addLabels {
    UILabel *currentLabel = [[UILabel alloc] init];
    currentLabel.text = @"当前:";
    currentLabel.textAlignment = NSTextAlignmentLeft;
    currentLabel.textColor = [UIColor blackColor];
    currentLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:currentLabel];
    [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(40);
        make.height.offset(21);
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    self.currentCityLabel = [[UILabel alloc] init];
    _currentCityLabel.textColor  = [UIColor blackColor];
    _currentCityLabel.textAlignment = NSTextAlignmentLeft;
    _currentCityLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_currentCityLabel];
    [_currentCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.height.offset(21);
        make.left.equalTo(currentLabel.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}

- (void)addJFButton {
    self.button = [[JFButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 95, self.frame.size.height - 31, 75, 21)];
    [_button addTarget:self action:@selector(touchUpJFButtonEnevt:) forControlEvents:UIControlEventTouchUpInside];
    _button.imageName = @"down_arrow_icon1";
    _button.title = @"选择区县";
    _button.titleColor = JFRGBAColor(155, 155, 155, 1.0);
    [self addSubview:_button];
}

- (void)touchUpJFButtonEnevt:(JFButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.imageName = @"down_arrow_icon2";
    }else {
        sender.imageName = @"down_arrow_icon1";
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(cityNameWithSelected:)]) {
        [self.delegate cityNameWithSelected:sender.selected];
    }

}

#pragma mark --- UISearchBarDelegate

//// searchBar开始编辑时调用
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(beginSearch)]) {
        [self.delegate beginSearch];
    }
}

// searchBar文本改变时即调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchResult:)]) {
            [self.delegate searchResult:searchText];
        }

    }
}

// 点击键盘搜索按钮时调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchResult:)]) {
        [self.delegate searchResult:searchBar.text];
    }

    NSLog(@"点击搜索按钮编辑的结果是%@",searchBar.text);
}

//  点击searchBar取消按钮时调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self cancelSearch];
}

//  取消搜索
- (void)cancelSearch {
    [_searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    _searchBar.text = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(endSearch)]) {
        [self.delegate endSearch];
    }

}

@end
