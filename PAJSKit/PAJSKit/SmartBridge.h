//
//  SmartBridge.h
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/16.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"
#import "SmartWebViewManager.h"
#import "SmartTakePhotoKit.h"

typedef void(^responseCallback)(id data);

@interface SmartBridge : NSObject <UINavigationControllerDelegate, UIPickerViewDelegate>

+ (instancetype)shareManager;
- (void)registerWithBridge:(WebViewJavascriptBridge *)bridge ;

@end
