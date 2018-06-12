//
//  ISRConfigViewController.m
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-25.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "TTSConfigViewController.h"
#import "TTSConfig.h"
#import "Definition.h"


@implementation TTSConfigViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    NSLog(@"%s[IN]",__func__);
    
    [super viewDidLoad];
    [self initView];
    
    NSLog(@"%s[OUT]",__func__);
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%s[IN]",__func__);
    
    [super viewWillAppear:animated];

    [self needUpdateSettings];
    
    NSLog(@"%s[OUT]",__func__);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    _backScrollView.contentSize = CGSizeMake(size.width ,size.height+300);
}

- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


#pragma mark - User interface processing

-(void)initView{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
#endif
    
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    
    _vcnPicker.delegate = self;
    _vcnPicker.dataSource = self;
    _vcnPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _vcnPicker.textColor = [UIColor whiteColor];
    _vcnPicker.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    _vcnPicker.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    _vcnPicker.highlightedTextColor = [UIColor colorWithRed:0.0 green:168.0/255.0 blue:255.0/255.0 alpha:1.0];
    _vcnPicker.interitemSpacing = 20.0;
    _vcnPicker.fisheyeFactor = 0.001;
    _vcnPicker.pickerViewStyle = AKPickerViewStyle3D;
    _vcnPicker.maskDisabled = false;
    
    _backScrollView.canCancelContentTouches = YES;
    _backScrollView.delaysContentTouches = NO;
    
    [_roundSlider addTarget:self action:@selector(onMultiSectorValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIColor *blueColor = [UIColor colorWithRed:0.0 green:168.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIColor *redColor = [UIColor colorWithRed:245.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0];
    UIColor *greenColor = [UIColor colorWithRed:29.0/255.0 green:207.0/255.0 blue:0.0 alpha:1.0];
    
    _pitchSec = [SAMultisectorSector sectorWithColor:redColor maxValue:100];//pitch
    _speedSec = [SAMultisectorSector sectorWithColor:blueColor maxValue:100];//speed
    _volumeSec = [SAMultisectorSector sectorWithColor:greenColor maxValue:100];//volume
    
    _pitchSec.endValue = instance.pitch.integerValue;
    _speedSec.endValue = instance.speed.integerValue;
    _volumeSec.endValue = instance.volume.integerValue;
    
    [_roundSlider addSector:_pitchSec];
    [_roundSlider addSector:_speedSec];
    [_roundSlider addSector:_volumeSec];
    
}

-(void)needUpdateRound{
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    
    _speedLabel.text = instance.speed;
    _volumeLabel.text = instance.volume;
    _pitchLabel.text = instance.pitch;
    
    _speedSec.endValue = instance.speed.integerValue;
    _volumeSec.endValue = instance.volume.integerValue;
    _pitchSec.endValue = instance.pitch.integerValue;
}

-(void)needUpdateEngineType{
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    
    //update engine type
    NSString *type = instance.engineType;
    if ([type isEqualToString:[IFlySpeechConstant TYPE_AUTO]]) {
        _engineTypeSeg.selectedSegmentIndex = 0;
    }else if ([type isEqualToString:[IFlySpeechConstant TYPE_CLOUD]]) {
        _engineTypeSeg.selectedSegmentIndex = 1;
    }else if ([type isEqualToString:[IFlySpeechConstant TYPE_LOCAL]]) {
        _engineTypeSeg.selectedSegmentIndex = 2;
    }
    
}

-(void)needUpdateSampleRate{
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    
    //update sample rate
    NSString *sampleRate = instance.sampleRate;
    if ([sampleRate isEqualToString:[IFlySpeechConstant SAMPLE_RATE_16K]]) {
        _sampleRateSeg.selectedSegmentIndex = 0;
        
    }else if ([sampleRate isEqualToString:[IFlySpeechConstant SAMPLE_RATE_8K]]) {
        _sampleRateSeg.selectedSegmentIndex = 1;
        
    }
}

-(void)needUpdateVcn{
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    
    //update TTS Speaker
    [_vcnPicker selectItem:0 animated:NO];
    [self.vcnPicker reloadData];
    int vcnIndex= 0;
    if([instance.engineType isEqualToString: [IFlySpeechConstant TYPE_LOCAL]] || [instance.engineType isEqualToString: [IFlySpeechConstant TYPE_AUTO]]){
        for (int i = 0;i < self.spVcnList.count; i++) {
            if([[[self.spVcnList objectAtIndex:i] objectForKey:@"name"] isEqualToString:instance.vcnName]){
                vcnIndex=i;
                break;
            }
        }
        [_vcnPicker selectItem:vcnIndex animated:NO];
    }
    else{
        for (int i = 0;i < instance.vcnIdentiferArray.count; i++) {
            if ([[instance.vcnIdentiferArray objectAtIndex:i] isEqualToString:instance.vcnName]) {
                vcnIndex=i;
                break;
            }
        }
        [_vcnPicker selectItem:vcnIndex animated:NO];
    }
}

-(void)needUpdateSettings{
    [self needUpdateRound];
    [self needUpdateEngineType];
    [self needUpdateSampleRate];
    [self needUpdateVcn];
    
}


#pragma mark - Event Handling


- (void)onMultiSectorValueChanged:(id)sender{
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    instance.speed = [NSString stringWithFormat:@"%d", (int)_speedSec.endValue];
    instance.volume = [NSString stringWithFormat:@"%d", (int)_volumeSec.endValue];
    instance.pitch = [NSString stringWithFormat:@"%d", (int)_pitchSec.endValue];
    
    
    _speedLabel.text = instance.speed;
    _volumeLabel.text = instance.volume;
    _pitchLabel.text = instance.pitch;
    
    _speedSec.endValue = [instance.speed integerValue];
    _volumeSec.endValue = [instance.volume integerValue];
    _pitchSec.endValue = [instance.pitch integerValue];
}


- (IBAction)onSampleRateSegValueChanged:(id)sender {
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    UISegmentedControl *seg = (UISegmentedControl*) sender;
    
    if (seg.selectedSegmentIndex == 0) {
        instance.sampleRate = [IFlySpeechConstant SAMPLE_RATE_16K];
    }else if (seg.selectedSegmentIndex == 1) {
        if (instance.engineType == [IFlySpeechConstant TYPE_LOCAL] || instance.engineType == [IFlySpeechConstant TYPE_AUTO]){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"T_Alter", nil)
                                                             message:NSLocalizedString(@"M_TTS_SampLimit", nil)
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"B_Ok", nil)
                                                   otherButtonTitles:nil];
            [alert show];
            
            [self needUpdateSampleRate];
            
        }else{
            instance.sampleRate = [IFlySpeechConstant SAMPLE_RATE_8K];
        }
    }
}


/*
 Set engine type
 */
- (IBAction)onEngineTypeSegValueChanged:(id)sender {
    
    NSLog(@"%s[IN]",__func__);
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    UISegmentedControl *seg = (UISegmentedControl*) sender;
    
    if (seg.selectedSegmentIndex == 0) {
        instance.engineType = [IFlySpeechConstant TYPE_AUTO];
        instance.sampleRate = [IFlySpeechConstant SAMPLE_RATE_16K];
        instance.vcnName = @"xiaoyan";
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"T_Alter", nil)
                                                         message:NSLocalizedString(@"M_TTS_ResLimit", nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"B_Ok", nil)
                                               otherButtonTitles:nil];
        [alert show];
    }else if (seg.selectedSegmentIndex == 1) {
        instance.engineType = [IFlySpeechConstant TYPE_CLOUD];
    }else if (seg.selectedSegmentIndex == 2) {
        instance.engineType = [IFlySpeechConstant TYPE_LOCAL];
        instance.sampleRate = [IFlySpeechConstant SAMPLE_RATE_16K];
        instance.vcnName = @"xiaoyan";
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"T_Alter", nil)
                                                         message:NSLocalizedString(@"M_TTS_ResLimit", nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"B_Ok", nil)
                                               otherButtonTitles:nil];
        [alert show];
    }
    
    [self needUpdateSampleRate];
    [self needUpdateVcn];
    
    NSLog(@"%s[OUT]",__func__);
}

#pragma mark - AKPickerViewDataSource and AKPickerViewDelegate

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView{
    
    //    NSLog(@"%s[IN]",__func__);
    
    NSUInteger count = 1;
    
    TTSConfig* instance = [TTSConfig sharedInstance];
    
    if(instance.engineType == [IFlySpeechConstant TYPE_LOCAL] || instance.engineType == [IFlySpeechConstant TYPE_AUTO]){
        if(self.spVcnList == nil){
            count = 1;
        }
        else{
            count = self.spVcnList.count;
        }
    }
    else{
        count = instance.vcnIdentiferArray.count;
    }
    
    //    NSLog(@"%s,count=%d[OUT]",__func__,count);
    
    return count;
}

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item{
    
    //    NSLog(@"%s[IN],item=%d",__func__,item);
    
    TTSConfig* instance = [TTSConfig sharedInstance];
    
    NSString *title = nil;
    
    if(instance.engineType == [IFlySpeechConstant TYPE_LOCAL] || instance.engineType == [IFlySpeechConstant TYPE_AUTO]){
        if(self.spVcnList.count > 0 && self.spVcnList.count > item){
            title = [[self.spVcnList objectAtIndex:item] objectForKey:@"nickname"];
        }else{
            title = NSLocalizedString(@"xiaoyan", nil);
        }
    }
    else{
        
        if(instance.vcnNickNameArray.count > item){
            title = [instance.vcnNickNameArray objectAtIndex:item];
        }
    }
    
    //    NSLog(@"%s[OUT],title=%@",__func__,title);
    
    return title;
}

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item{
    
    TTSConfig *instance = [TTSConfig sharedInstance];
    
    //    NSLog(@"%s[IN],item=%d",__func__,item);
    
    if(instance.engineType == [IFlySpeechConstant TYPE_LOCAL] || instance.engineType == [IFlySpeechConstant TYPE_AUTO])
    {
        if(self.spVcnList.count > 0 && self.spVcnList.count > item)
        {
            instance.vcnName = [[self.spVcnList objectAtIndex:item] objectForKey:@"name"];
            
        }
        else{
            instance.vcnName = @"xiaoyan";
        }
    }
    else
    {
        instance.vcnName = [instance.vcnIdentiferArray objectAtIndex:item];
    }
    
    //    NSLog(@"%s[OUT]",__func__);
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 2 && buttonIndex == 1) {
        NSString *url = [IFlySpeechUtility  componentUrl];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

@end
