//
//  SmartWKWebView.h
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/16.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"
#import "SmartBridge.h"
#import <WebKit/WKNavigationDelegate.h>

@interface SmartWKWebView : WKWebView <WKNavigationDelegate>

+ (instancetype)shareManager;

-  (void)callHandlerWithName:(NSString *)name data:(NSDictionary *)dictionary callBack:(responseCallback)callBack;
-  (void)callHandlerWithName:(NSString *)name data:(NSDictionary *)dictionary;

@end
