//
//  SmartWebViewManager.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/29.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "SmartWebViewManager.h"


@implementation SmartWebViewManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static SmartWebViewManager *smartWebViewManager;
    dispatch_once(&onceToken, ^{
        smartWebViewManager = [[SmartWebViewManager alloc] init];
    });
    return smartWebViewManager;
}

- (id)createWebView {
    SmartWKWebView *smartWebView = [[SmartWKWebView alloc] init];
    self.currentWebView = smartWebView;
    return smartWebView;
}

- (void)preloadWebView {
    SmartWKWebView *smartWebView = [[SmartWKWebView alloc] init];
    [smartWebView loadHTMLString:@"" baseURL:nil];
}

@end
