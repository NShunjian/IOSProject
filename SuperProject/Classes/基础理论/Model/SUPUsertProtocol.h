//
//  SUPUsertProtocol.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPDataBaseConnectionProtocol.h"

@interface SUPUsertProtocol : NSObject


- (void)connectDataBase:(id<SUPDataBaseConnectionProtocol>)dataBase withIndentifier:(NSString *)Indentifier;

@end
