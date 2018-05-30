//
//  SmartCoreMotionKit.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/30.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "SmartCoreMotionKit.h"
#import <CoreMotion/CoreMotion.h>

@interface SmartCoreMotionKit()

@property (nonatomic, strong)CMMotionManager *motionManager;

@end

@implementation SmartCoreMotionKit

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static SmartCoreMotionKit *kit = nil;
    dispatch_once(&onceToken, ^{
        kit = [[SmartCoreMotionKit alloc] init];
    });
    return kit;
}

- (CMMotionManager *)motionManager {
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

- (Boolean)startGyMotion {
    if (!self.motionManager.isGyroAvailable) {
        NSLog(@"加速计不可用，请跟换手机");
        return NO;
    }
    [self.motionManager startGyroUpdates];
    return YES;
}

- (void)stopGyMotion {
    [self.motionManager stopGyroUpdates];
}


- (NSDictionary *)pullGyMessageWithCallback:(WVJBResponseCallback)callback {
    self.callback = callback;
    CMRotationRate rate = self.motionManager.gyroData.rotationRate;
    if (self.callback) {
         self.callback(@{@"x":@(rate.x),@"y":@(rate.y),@"z":@(rate.z)});
    }
    return @{@"x":@(rate.x),@"y":@(rate.y),@"z":@(rate.z)};
}

//主动给web推送，web端需要在制定JS方法内获取
- (void)pushGyMessageToWebWithBridge:(WebViewJavascriptBridge*)bridge {
    // 2.设置采样间隔
    self.motionManager.gyroUpdateInterval = 1.4;
    // 3.开始采集数据
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
        CMRotationRate rate = gyroData.rotationRate;
        [bridge callHandler:@"receiveMotionMessage" data:@{@"x":@(rate.x),@"y":@(rate.y),@"z":@(rate.z)} responseCallback:^(id responseData) {
            NSLog(@"%@",responseData);
        }];
       
    }];
    
    
}

@end
