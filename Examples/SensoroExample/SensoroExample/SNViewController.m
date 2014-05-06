//
//  SNViewController.m
//  SensoroExample
//
//  Created by David Yang on 14-4-21.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "SNViewController.h"
#import "SNSensoroSenseWatcher.h"

@interface SNViewController () <SensoroSenseDelegate>

@property (strong, nonatomic) IBOutlet UISwitch *serviceSwitch;
@property (strong, nonatomic) IBOutlet UILabel *serviceState;
- (IBAction)serviceAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *enterState;
@property (weak, nonatomic) IBOutlet UILabel *goodsState;
@property (strong, nonatomic) IBOutlet UILabel *creditState;
@property (strong, nonatomic) IBOutlet UILabel *creditTimes;
@property (strong, nonatomic) IBOutlet UILabel *fixedcornerState;
@property (strong, nonatomic) IBOutlet UILabel *verifyState;

@end

@implementation SNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[SNSensoroSenseWatcher sharedInstance] addObserver:self];
    if ([SNSensoroSenseWatcher sharedInstance].isEntering) {
        self.enterState.text = @"已进场";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark SensoroSenseDelegate

- (void) shopEnter:(NSDictionary*)retInfo{
    if ([SNSensoroSenseWatcher sharedInstance].isEntering) {
        self.enterState.text = @"已进场";
    }
}

- (void) shopLeave:(NSDictionary*)retInfo{
    if ([SNSensoroSenseWatcher sharedInstance].isEntering == NO) {
        self.enterState.text = @"已离场";
    }
}

- (void) goodsOk:(NSDictionary*)retInfo{
    if ([SNSensoroSenseWatcher sharedInstance].goodsInfo != nil) {
        self.goodsState.text = @"已触发";
    }
}

- (void) creditOk:(NSDictionary*)retInfo{
    if ([SNSensoroSenseWatcher sharedInstance].creditTimes > 0) {
        self.creditState.text = @"已触发";
        self.creditTimes.text = [NSString stringWithFormat:@"%ld次",[SNSensoroSenseWatcher sharedInstance].creditTimes];
    }
}

- (void) fixedCornerEnter:(NSDictionary*)retInfo{
    if ([SNSensoroSenseWatcher sharedInstance].isFixedCorner) {
        self.fixedcornerState.text = @"已进入";
    }else{
        self.fixedcornerState.text = @"已离开";
    }
}

- (void) fixedCornerLeave:(NSDictionary*)retInfo{
    if ([SNSensoroSenseWatcher sharedInstance].isFixedCorner) {
        self.fixedcornerState.text = @"已进入";
    }else{
        self.fixedcornerState.text = @"已离开";
    }
}

- (void) payAreaEnter:(NSDictionary*)retInfo{
    if ([SNSensoroSenseWatcher sharedInstance].isVerifyArea) {
        self.verifyState.text = @"已激活";
    }else{
        self.verifyState.text = @"未激活";
    }
}

- (void) payAreaLeave:(NSDictionary*)retInfo{
    if ([SNSensoroSenseWatcher sharedInstance].isVerifyArea) {
        self.verifyState.text = @"已激活";
    }else{
        self.verifyState.text = @"未激活";
    }
}

- (IBAction)serviceAction:(id)sender {
    if (_serviceSwitch.isOn) {
        self.serviceState.text = @"服务已开启";
        [[SNSensoroSenseWatcher sharedInstance] startService];
    }else{
        self.serviceState.text = @"服务已停止";
        [[SNSensoroSenseWatcher sharedInstance] stopService];
    }
    
}
@end
