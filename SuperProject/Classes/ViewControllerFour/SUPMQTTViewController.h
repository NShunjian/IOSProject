//
//  SUPMQTTViewController.h
//  SuperProject
//
//  Created by NShunJian on 2018/5/24.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPBaseViewController.h"
/*
 * MQTTClient: imports
 * MQTTSessionManager.h is optional
 */
#import <MQTTClient/MQTTClient.h>
#import <MQTTClient/MQTTSessionManager.h>

/*
 * MQTTClient: using your main view controller as the MQTTSessionManagerDelegate
 */
@interface SUPMQTTViewController : SUPBaseViewController<MQTTSessionManagerDelegate,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@end
