//
//  LMJXGMVideo.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
// 

#import "LMJXGMVideo.h"

@implementation LMJXGMVideo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (void)setImage:(NSURL *)image
{
    _image = [NSURL URLWithString:[LMJXMGBaseUrl stringByAppendingPathComponent:image.absoluteString]];
}

- (void)setUrl:(NSURL *)url
{
    _url = [NSURL URLWithString:[LMJXMGBaseUrl stringByAppendingPathComponent:url.absoluteString]];
}

@end
