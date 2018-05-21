//
//  SUPUsertProtocol.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPUsertProtocol.h"

@implementation SUPUsertProtocol


- (void)connectDataBase:(id<SUPDataBaseConnectionProtocol>)dataBase withIndentifier:(NSString *)Indentifier
{
    
    NSLog(@"%s", __func__);
    
    if ([dataBase respondsToSelector:@selector(start)]) {
        [dataBase start];
    }
    
    
    NSLog(@"%s", __func__);
    
}


@end
