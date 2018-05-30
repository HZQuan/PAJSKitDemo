//
//  SmartTakePhotoKit.h
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/30.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <WebViewJavascriptBridge.h>

@interface SmartTakePhotoKit : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, copy)WVJBResponseCallback callback;

+ (instancetype) shareManager;
- (void)startGetPhotoWithBridgeback:(WVJBResponseCallback)responseCallback;

@end
