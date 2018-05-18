//
//  WKWebView+Smart.h
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/18.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <WebKit/WKNavigationDelegate.h>
#import "WebViewJavascriptBridge.h"
#import "SmartBridge.h"

@interface WKWebView(Smart) <WKNavigationDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *jsBridge;

@end
