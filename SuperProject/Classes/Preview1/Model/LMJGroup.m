//
//  LMJGroup.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJGroup.h"
#import <MJExtension.h>
#import "LMJTeam.h"

@implementation LMJGroup



+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"teams" : [LMJTeam class]};
}



- (NSMutableArray<LMJTeam *> *)teams
{
    if(_teams == nil)
    {
        _teams = [NSMutableArray array];
    }
    return _teams;
}

@end
