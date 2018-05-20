//
//  LMJUsertProtocol.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMJDataBaseConnectionProtocol.h"

@interface LMJUsertProtocol : NSObject


- (void)connectDataBase:(id<LMJDataBaseConnectionProtocol>)dataBase withIndentifier:(NSString *)Indentifier;

@end
