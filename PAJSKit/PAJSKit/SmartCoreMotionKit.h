//
//  SmartCoreMotionKit.h
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/30.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebViewJavascriptBridge.h>

@interface SmartCoreMotionKit : NSObject

@property (nonatomic, copy)WVJBResponseCallback callback;

+ (instancetype)shareManager;
- (NSDictionary *)pullGyMessageWithCallback:(WVJBResponseCallback)callback;
//开始监听陀螺仪
- (Boolean)startGyMotion;
- (void)stopGyMotion;
-  (void)pushGyMessageToWebWithBridge:(WebViewJavascriptBridge*)bridge;

@end
