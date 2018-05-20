//
//  LMJCountDownCell.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
// 

#import "LMJCountDownCell.h"

@implementation LMJCountDownCell

- (void)setCountDownModel:(LMJCountDownModel *)countDownModel
{
    _countDownModel = countDownModel;
    self.imageView.image = countDownModel.pruductImage;
//    self.textLabel.text = countDownModel.productName;
    
    self.userInteractionEnabled = !(countDownModel.date <= CFAbsoluteTimeGetCurrent());
    
    self.textLabel.text = [NSString stringWithFormat:@"%lu", (NSUInteger)countDownModel.date];
}




@end
