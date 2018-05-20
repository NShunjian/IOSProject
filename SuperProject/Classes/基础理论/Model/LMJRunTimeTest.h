//
//  LMJRunTimeTest.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMJRunTimeTest : NSObject <NSCoding>
{
    NSString *_school_Name;
}

/** <#digest#> */
@property (nonatomic, copy) NSString *name;

/** <#digest#> */
@property (assign, nonatomic) NSInteger age;

- (NSString *)showUserName:(NSString *)userName;

@end
