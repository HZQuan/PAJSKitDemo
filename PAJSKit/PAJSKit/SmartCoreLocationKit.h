//
//  SmartCoreLocationKit.h
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/31.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <WebViewJavascriptBridge.h>

@interface SmartCoreLocationKit : NSObject

@property (nonatomic, copy)WVJBResponseCallback responseCallback;

+ (instancetype)shareManager;
- (void)startLocationWithBridge:(WVJBResponseCallback) responseCallback;


@end
