//
//  SmartWebViewManager.h
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/29.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "SmartWKWebView.h"



@interface SmartWebViewManager : NSObject


+ (instancetype)shareManager;
- (void)preloadWebView;
- (SmartWKWebView*)createWebView;


@property(nonatomic,strong)WKWebView *currentWebView;


@end
