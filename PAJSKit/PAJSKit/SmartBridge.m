//
//  SmartBridge.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/16.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "SmartBridge.h"
@implementation SmartBridge

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static SmartBridge *bridge;
    dispatch_once(&onceToken, ^{
        bridge = [[SmartBridge alloc]init];
    });
    return bridge;
}

- (void)registerWithBridge:(WebViewJavascriptBridge *)bridge {
    [bridge registerHandler:@"Test1" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        NSDictionary *dic = @{@"key1":@"valuew",@"key2":@5};
        responseCallback(dic);
        
    }];
}

@end
