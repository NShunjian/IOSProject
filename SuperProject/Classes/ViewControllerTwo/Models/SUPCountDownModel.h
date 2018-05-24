//
//  SUPCountDownModel.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUPCountDownModel : NSObject

/** <#digest#> */
@property (nonatomic, strong) UIImage *pruductImage;

/** <#digest#> */
@property (nonatomic, copy) NSString *productName;

/** <#digest#> */
@property (nonatomic, assign) NSTimeInterval date;

@end
