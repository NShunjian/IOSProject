//
//  SUPVersionButton.m
//  不得姐
//
//  Created by NShunJian on 16/11/18.
//  Copyright © 2016年 cui. All rights reserved.
//

#import "SUPVersionButton.h"

@implementation SUPVersionButton

-(void)setup{

    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}


-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setup];
        
    }

    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];

}


-(void)layoutSubviews{
    [super layoutSubviews];
    // 调整图片
    self.imageView.SUP_x = 0;
    self.imageView.SUP_y = 0;
    self.imageView.SUP_width = self.SUP_width;
    self.imageView.SUP_height = self.imageView.SUP_width;
    
    
    // 调整文字
    self.titleLabel.SUP_x = 0;
    self.titleLabel.SUP_y = self.imageView.SUP_height;
    self.titleLabel.SUP_width = self.SUP_width;
    self.titleLabel.SUP_height = self.SUP_height - self.titleLabel.SUP_y;
}



@end
