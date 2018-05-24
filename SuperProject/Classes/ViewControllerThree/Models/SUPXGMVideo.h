//
//  SUPXGMVideo.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
// 

#import <Foundation/Foundation.h>

@interface SUPXGMVideo : NSObject

//
//id: 2,
//image: "resources/images/minion_02.png",
//length: 12,
//name: "小黄人 第02部",
//url: "resources/videos/minion_02.mp4"

/** <#digest#> */
@property (nonatomic, copy) NSString *ID;

/** <#digest#> */
@property (nonatomic, strong) NSURL *image;

/** <#digest#> */
@property (nonatomic, copy) NSString *name;

/** <#digest#> */
@property (nonatomic, strong) NSURL *url;

@end
