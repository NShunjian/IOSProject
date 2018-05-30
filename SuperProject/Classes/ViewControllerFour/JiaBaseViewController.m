//
//  jiaBaseViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/14.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface JiaBaseViewController()
@end

@implementation JiaBaseViewController

- (id)initWithRouterParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        _parameterDictionary=params;
        NSLog(@"当前参数：%@",params);
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    

}

-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}













@end
