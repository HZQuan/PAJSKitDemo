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
@property (nonatomic, weak) UIProgressView *progressView;

@end

@implementation SmartWKWebView

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static SmartWKWebView *smartWebVeiw;
    dispatch_once(&onceToken, ^{
        smartWebVeiw = [[SmartWKWebView alloc] init];
        smartWebVeiw.bridge = [WebViewJavascriptBridge bridgeForWebView:smartWebVeiw];
        [smartWebVeiw createUI];
        [smartWebVeiw.bridge setWebViewDelegate:smartWebVeiw];
        [smartWebVeiw registerHandler];
    });
    return smartWebVeiw;
}

- (void)createUI {
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 10)];
    progressView.progressTintColor = [UIColor colorWithRed:0/225.0 green:191/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:progressView];
    self.progressView = progressView;
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.estimatedProgress animated:YES];
        if (self.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//name web端提供给原生调用的js方法 data:调用时候传递的参数
- (void)callHandlerWithName:(NSString *)name data:(NSDictionary *)dictionary {
    [self.bridge callHandler:name data:dictionary responseCallback:^(id responseData) {
        NSLog(@"ObjC received response: %@", responseData);
    }];
}

- (void)callHandlerWithName:(NSString *)name data:(NSDictionary *)dictionary callBack:(responseCallback)callBack {
    [self.bridge callHandler:name data:dictionary responseCallback:callBack];
}

- (void) registerHandler {
    //注册测试模块
    SmartBridge *bridge = [SmartBridge shareManager];
    [bridge  registerWithBridge:self.bridge];
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
