//
//  jiaBaseViewController.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/14.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "SUPBaseViewController.h"

@interface JiaBaseViewController : SUPBaseViewController
//页面接收参数
@property(nonatomic,strong)NSDictionary *parameterDictionary;
//初始化参数
- (id)initWithRouterParams:(NSDictionary *)params;

@end
