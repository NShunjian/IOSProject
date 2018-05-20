//
//  LMJGroup.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMJTeam;
@interface LMJGroup : NSObject


/** <#digest#> */
@property (assign, nonatomic) BOOL isOpened;

/** <#digest#> */
@property (nonatomic, copy) NSString *name;

/**  */
@property (nonatomic, strong) NSMutableArray<LMJTeam *> *teams;

@end
