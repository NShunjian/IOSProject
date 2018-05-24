//
//  SUPAnnotationCustomPopView.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
// 

#import <UIKit/UIKit.h>

@interface SUPAnnotationCustomPopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *gotoButton;

+ (instancetype)popView;

@end
