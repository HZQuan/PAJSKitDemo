//
//  SmartWebView.h
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/16.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"
#import "SmartBridge.h"

@interface SmartUIWebView : UIWebView

+ (instancetype)shareManager;
- (void)callHandlerWithName:(NSString *)name data:(NSDictionary *)dictionary;

@end
