//
//  SmartBridge.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/16.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "SmartBridge.h"
#import "YYKit.h"

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
    //关闭webview
    [bridge registerHandler:@"closeWebView" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self closeWebView];
    }];
    //后退
    [bridge registerHandler:@"gobackWebView" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self gobackWebViewPage];
    }];
    
    //显示导航栏
    [bridge registerHandler:@"showNavigationBar" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self showNavigateionBar];
    }];
    [bridge registerHandler:@"hiddenNavigationBar" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self hiddenNavigationBar];
    }];
    
}

- (void)gobackWebViewPage {
    if ([[SmartWebViewManager shareManager].currentWebView canGoBack]) {
           [[SmartWebViewManager shareManager].currentWebView goBack];
    }
}

- (void)showNavigateionBar {
    if ([self topViewController].navigationController) {
        [[self topViewController].navigationController setNavigationBarHidden:NO animated:YES];
    }
    
}

- (void)hiddenNavigationBar {
    if ([self topViewController].navigationController) {
        [[self topViewController].navigationController setNavigationBarHidden:YES animated:YES];
    }
}


- (void)closeWebView {
    UIViewController *controller = [self topViewController];
    if (controller.presentingViewController) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    } else {
        [controller.navigationController popViewControllerAnimated:YES];
    }
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}



@end
