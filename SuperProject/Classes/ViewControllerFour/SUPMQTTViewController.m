//
//  SUPMQTTViewController.m
//  SuperProject
/**[self.manager connectTo:self.mqttSettings[@"host"]
port:[self.mqttSettings[@"port"] intValue]
tls:[self.mqttSettings[@"tls"] boolValue]
keepalive:60
clean:true
auth:true
user:@"admin"
pass:@"654321"
will:YES
willTopic:@"/IOTLocation/BLE_thetwo/update"
willMsg:[@"offline" dataUsingEncoding:NSUTF8StringEncoding]
willQos:0
willRetainFlag:FALSE
withClientId:@"client99999"
securityPolicy:nil
certificates:nil
protocolLevel:MQTTProtocolVersion311 connectHandler:^(NSError *error) {
    SUPLog(@"error=%@",error);
}];*/
//  Created by NShunJian on 2018/5/24.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPMQTTViewController.h"
static NSString *const ID = @"ChatCell";
@interface SUPMQTTViewController ()
/*
 * MQTTClient: keep a strong reference to your MQTTSessionManager here
 */
@property (strong, nonatomic) MQTTSessionManager *manager;
@property (strong, nonatomic) NSDictionary *mqttSettings;
@property (strong, nonatomic) NSMutableArray *chat;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMsg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *base;
@property (nonatomic, strong) NSString *Topic;
@property (weak, nonatomic) IBOutlet UIButton *connect;
@property (weak, nonatomic) IBOutlet UIButton *disconnect;


@end

@implementation SUPMQTTViewController

- (void)viewDidLoad {
    
    NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
    NSURL *mqttPlistUrl = [bundleURL URLByAppendingPathComponent:@"mqtt.plist"];
    self.mqttSettings = [NSDictionary dictionaryWithContentsOfURL:mqttPlistUrl];
    self.base = self.mqttSettings[@"base"];
    self.Topic =  self.mqttSettings[@"willTopic"];
    self.chat = [[NSMutableArray alloc] init];

//    self.tableView.estimatedRowHeight = 300;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.textFieldMsg.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    /*
     * MQTTClient: create an instance of MQTTSessionManager once and connect
     * will is set to let the broker indicate to other subscribers if the connection is lost
     */
    if (!self.manager) {
        self.manager = [[MQTTSessionManager alloc] init];
        self.manager.delegate = self;
        self.manager.subscriptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:MQTTQosLevelExactlyOnce]
                                                                 forKey:[NSString stringWithFormat:@"%@/#", self.Topic]];
        
        [self.manager connectTo:self.mqttSettings[@"host"]
            port:[self.mqttSettings[@"port"] intValue]
            tls:[self.mqttSettings[@"tls"] boolValue]
            keepalive:60
            clean:[self.mqttSettings[@"clean"] boolValue]
            auth:[self.mqttSettings[@"auth"] boolValue]
            user:self.mqttSettings[@"user"]
            pass:self.mqttSettings[@"pass"]
            will:[self.mqttSettings[@"will"] boolValue]
            willTopic:self.mqttSettings[@"willTopic"]
            willMsg:[@"offline" dataUsingEncoding:NSUTF8StringEncoding]
            willQos:[self.mqttSettings[@"willQos"] intValue]
            willRetainFlag:FALSE
            withClientId:self.mqttSettings[@"withClientId"]
            securityPolicy:nil
            certificates:nil 
            protocolLevel:MQTTProtocolVersion311 connectHandler:^(NSError *error) {
            SUPLog(@"error=%@",error);
        }];
        
    } else {
        [self.manager connectToLast:^(NSError *error) {
            SUPLog(@"connectToLast error=%@",error);
        }];
    }
    
    /*
     * MQTTCLient: observe the MQTTSessionManager's state to display the connection status
     */
    
    [self.manager addObserver:self
                   forKeyPath:@"state"
                      options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                      context:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    switch (self.manager.state) {
        case MQTTSessionManagerStateClosed:
            self.statusLab.text = @"closed";
            self.disconnect.enabled = false;
            self.connect.enabled = true;
            break;
        case MQTTSessionManagerStateClosing:
            self.statusLab.text = @"closing";
            self.disconnect.enabled = false;
            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateConnected:
            self.statusLab.text = [NSString stringWithFormat:@"connected as %@",
                                [UIDevice currentDevice].name];
            self.disconnect.enabled = true;
            self.connect.enabled = false;
            [self.manager sendData:[@"joins chat" dataUsingEncoding:NSUTF8StringEncoding]
                             topic:self.mqttSettings[@"willTopic"]
                               qos:[self.mqttSettings[@"willQos"] intValue]
                            retain:FALSE];
            
            break;
        case MQTTSessionManagerStateConnecting:
            self.statusLab.text = @"connecting";
            self.disconnect.enabled = false;
            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateError:
            self.statusLab.text = @"error";
            self.disconnect.enabled = false;
            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateStarting:
        default:
            self.statusLab.text = @"not connected";
            self.disconnect.enabled = false;
            self.connect.enabled = true;
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)clear:(id)sender {
    [self.chat removeAllObjects];
    [self.tableView reloadData];
}
- (IBAction)connect:(id)sender {
    /*
     * MQTTClient: connect to same broker again
     */
    
    [self.manager connectToLast:^(NSError *error) {
        SUPLog(@"connectToLast error=%@",error);
    }];
}

- (IBAction)disconnect:(id)sender {
    /*
     * MQTTClient: send goodby message and gracefully disconnect
     */
    [self.manager sendData:[@"leaves chat" dataUsingEncoding:NSUTF8StringEncoding]
                     topic:self.mqttSettings[@"willTopic"]
                       qos:[self.mqttSettings[@"willQos"] intValue]
                    retain:FALSE];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    [self.manager disconnect];
}

- (IBAction)send:(id)sender {
    /*
     * MQTTClient: send data to broker
     */
    
    [self.manager sendData:[self.textFieldMsg.text dataUsingEncoding:NSUTF8StringEncoding]
                     topic:self.mqttSettings[@"willTopic"]
                       qos:[self.mqttSettings[@"willQos"] intValue]
                    retain:FALSE];
}

/*
 * MQTTSessionManagerDelegate
 */
- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    /*
     * MQTTClient: process received message
     */
    NSLog(@"data  =  %@",data);
    NSLog(@"topic  =  %@",topic);
    
    
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSString *senderString = [topic substringFromIndex:self.base.length + 1];
//    SUPLog(@"senderString  ==  %@",senderString);
//    [self.chat insertObject:[NSString stringWithFormat:@"%@:\n%@", senderString, dataString] atIndex:0];
    
    /////////
     NSString *senderString1 = [topic substringFromIndex:0];
    SUPLog(@"senderString1  ==  %@",senderString1);
    [self.chat insertObject:[NSString stringWithFormat:@"%@:\n%@", senderString1, dataString] atIndex:0];
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
 
}
 
/*
 * UITableViewDelegate
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    SUPLog(@"self.chat================ = %@",self.chat);
     SUPLog(@"self.chat================ =>>>>>>>>>>>> ");
    cell.textView.text = self.chat[indexPath.row];
    return cell;
}

/*
 * UITableViewDataSource
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chat.count;
}

@end
