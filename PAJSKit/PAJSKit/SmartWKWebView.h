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
#import "WKWebView+Smart.h"

@protocol SmartWebViewDelegate <NSObject>

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;

#pragma mark 页面加载失败时调用
-  (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error ;

@end

@interface SmartWKWebView : WKWebView <WKNavigationDelegate>

@property (nonatomic, weak)id <SmartWebViewDelegate> webViewDelegate;
@property (nonatomic, strong) WebViewJavascriptBridge *jsBridge;

+ (instancetype)createWebView;
//调用web提供的js方法 name是web端注册的方法名，dictonary 我们传给js方法的参数 ，callback调用结果回调
-  (void)callHandlerWithName:(NSString *)name data:(NSDictionary *)dictionary;

@end
