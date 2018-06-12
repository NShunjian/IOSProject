//
//  TTSConfigViewController.h
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-25.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMultisectorControl.h"
#import "AKPickerView.h"
#import "IFlyMSC/IFlyMSC.h"
#import "PopupView.h"


@interface TTSConfigViewController : UIViewController<AKPickerViewDataSource,AKPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (strong, nonatomic)  SAMultisectorSector *volumeSec;
@property (strong, nonatomic)  SAMultisectorSector *speedSec;
@property (strong, nonatomic)  SAMultisectorSector *pitchSec;

@property (weak, nonatomic) IBOutlet SAMultisectorControl *roundSlider;

@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;

@property (weak, nonatomic) IBOutlet AKPickerView *vcnPicker;

@property (strong, nonatomic) IBOutlet UISegmentedControl *sampleRateSeg;

@property (strong, nonatomic) IBOutlet UISegmentedControl *engineTypeSeg;

@property (nonatomic, strong) NSArray *spVcnList;

@property (nonatomic, strong) PopupView            * popUpView;

@end
