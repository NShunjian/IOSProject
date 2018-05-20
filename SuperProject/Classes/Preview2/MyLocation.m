//
//  MyLocation.m
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/8/16.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyLocation.h"


@implementation MyLocation

@synthesize updating = _updating;
@synthesize location = _location;
@synthesize heading = _heading;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

-(id)init
{
    self = [super init];
    if (self)
    {
        _updating = NO;
        _location = nil;
        _heading = nil;
        _title = @"我的位置";
        _subtitle = nil;
    }
    return self;
}

-(void)dealloc
{
    if (_location) {
        _location = nil;
    }
    if (_title) {
        _title = nil;
    }
    if (_subtitle) {
        _subtitle = nil;
    }
    if (_heading) {
        _heading = nil;
    }
}

-(id)initWithLocation:(CLLocation *)loc withHeading:(CLHeading *)head
{
    self = [super init];
    if (self)
    {
        _updating = NO;
        _location = loc;
        _heading = head;
        _title = @"我的位置";
        _subtitle = nil;
    }
    return self;
    
    
    
}

@end
