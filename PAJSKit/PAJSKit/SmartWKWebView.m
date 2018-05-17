//
//  SmartWKWebView.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/16.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "SmartWKWebView.h"
@interface SmartWKWebView()
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation SmartWKWebView

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static SmartWKWebView *smartWebVeiw;
    dispatch_once(&onceToken, ^{
        smartWebVeiw = [[SmartWKWebView alloc] init];
        smartWebVeiw.bridge = [WebViewJavascriptBridge bridgeForWebView:smartWebVeiw];
        [smartWebVeiw registerHandler];
    });
    return smartWebVeiw;
}

//name web端提供给原生调用的js方法 data:调用时候传递的参数
- (void)callHandlerWithName:(NSString *)name data:(NSDictionary *)dictionary {
    [self.bridge callHandler:name data:dictionary responseCallback:^(id responseData) {
        NSLog(@"ObjC received response: %@", responseData);
    }];
}

- (void)callHandlerWithName:(NSString *)name data:(NSDictionary *)dictionary callBack:(responseCallback)callBack {
    
    
}

- (void) registerHandler {
    //注册测试模块
    SmartBridge *bridge = [SmartBridge shareManager];
    [bridge  registerWithBridge:self.bridge];
}

@end
