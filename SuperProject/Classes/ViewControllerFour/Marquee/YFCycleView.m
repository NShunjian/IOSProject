//
//  YFCycleView.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/22.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFCycleView.h"

@interface YFCycleView ()
@property(nonatomic,weak) UILabel *rollLabel;
@property(nonatomic,strong) NSTimer* timer;// 定义定时器

@end

@implementation YFCycleView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeContentView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeContentView];
        
        // 启动NSTimer定时器来改变UIImageView的位置
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self selector:@selector(changePosition)
                                                    userInfo:nil repeats:YES];
    }
    return self;
}

-(void)dealloc{
    [_timer invalidate];
    _timer=nil;
}

- (void)makeContentView {
    
    UILabel *rollLabel = [[UILabel alloc] init];
    rollLabel.font = [UIFont boldSystemFontOfSize:18];
    NSString *str = @"（￣︶￣）↗ 共同学习,互帮互助 😀😀😀！";  //测试123456789abcdefghijklmnopqrstuvwxyz测试ing测试ing测试ing测试ing测试ing测试ing测试ing测试ing测试ing测试ing测试ing测试ing测试ing测试ing测试ing
    rollLabel.text = str;

    CGSize rollLabelMaxSize = CGSizeMake(MAXFLOAT, self.frame.size.height);
    CGSize rollLabelSize = [self sizeWithText:rollLabel.text andFont:rollLabel.font andMaxSize:rollLabelMaxSize];
    CGFloat rollX = self.frame.size.width;
    CGFloat rollY = 0;
    NSLog(@"width = %f", rollLabelSize.width); // 1457.18  / 2 = 728.56   + 320  =  1048.45
    rollLabel.frame = CGRectMake(rollX, rollY, rollLabelSize.width, rollLabelSize.height);
    
    
    rollLabel.backgroundColor = [UIColor blueColor];
    [rollLabel setTextColor:[UIColor redColor]];
    self.rollLabel = rollLabel;
    
    //添加视图
    [self addSubview:rollLabel];
}



//其实蝴蝶的整个移动都是————靠iv.center来去设置的
- (void)changePosition {
    
    CGPoint curPos = self.rollLabel.center;
    
//    NSLog(@"curPos.x = %f", curPos.x);
    // 当curPos的x坐标已经超过了屏幕的宽度
    if(curPos.x < -100)
    {
        CGFloat jianJu = self.rollLabel.frame.size.width/2;
        
        self.rollLabel.center = CGPointMake(self.frame.size.width + jianJu, 20);
    }
    else
    {
        self.rollLabel.center = CGPointMake(curPos.x - 4, 20);
    }

}



- (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    
    NSDictionary *atts = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:atts context:nil].size;
}


@end
