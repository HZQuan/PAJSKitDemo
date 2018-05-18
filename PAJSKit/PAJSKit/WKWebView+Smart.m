//
//  WKWebView+Smart.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/18.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "WKWebView+Smart.h"
#import <objc/runtime.h>
#import "SmartBridge.h"


@implementation WKWebView(Smart) 

//static char *jsBridge = "bridge";

+ (void)load {
    [self smart_hookOrigMenthod:@selector(init) NewMethod:@selector(hook_init)];
}

+ (BOOL)smart_hookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel {
    Class class = self;
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method altMethod = class_getInstanceMethod(class, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    BOOL didAddMethod = class_addMethod(class,origSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,altSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }
    
    return YES;
}

- (instancetype)hook_init {
    WKWebView *webView = [self hook_init];
   WebViewJavascriptBridge *jsBridge;
    jsBridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [jsBridge setWebViewDelegate:webView];
    SmartBridge *bridge = [SmartBridge shareManager];
    [bridge registerWithBridge:jsBridge];
    webView.jsBridge = jsBridge;
    return webView;
}

#pragma mark --wkwebviewdelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    /**
     *typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
     WKNavigationActionPolicyCancel, // 取消
     WKNavigationActionPolicyAllow,  // 继续
     }
     */
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark 身份验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    // 不要证书验证
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
}

#pragma mark WKNavigation导航错误
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}

#pragma mark WKWebView终止
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
}

#pragma mark - WKNavigationDelegate 页面加载
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
  
}

#pragma mark 页面加载失败时调用
-  (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}


@end
