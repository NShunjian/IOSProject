//
//  SUPGroup.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPGroup.h"
#import <MJExtension.h>
#import "SUPTeam.h"

@implementation SUPGroup



+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"teams" : [SUPTeam class]};
}



- (NSMutableArray<SUPTeam *> *)teams
{
    if(_teams == nil)
    {
        _teams = [NSMutableArray array];
    }
    return _teams;
}

@end
