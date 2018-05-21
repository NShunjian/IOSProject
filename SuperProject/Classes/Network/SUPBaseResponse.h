//
//  SUPBaseResponse.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface SUPBaseResponse : NSObject


/** <#digest#> */
@property (nonatomic, strong) NSError *error;

/** <#digest#> */
@property (nonatomic, copy) NSString *errorMsg;

/** <#digest#> */
@property (assign, nonatomic) NSInteger statusCode;

/** <#digest#> */
@property (nonatomic, copy) NSMutableDictionary *headers;

/** <#digest#> */
@property (nonatomic, strong) id responseObject;

@end
