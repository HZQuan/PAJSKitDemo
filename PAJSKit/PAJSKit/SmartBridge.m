//
//  SmartBridge.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/16.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "SmartBridge.h"
#import "YYKit.h"
#import "SmartQRCodeScanningVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SmartCoreMotionKit.h"
#import "SmartCoreLocationKit.h"
#import "SmartWebViewManager.h"

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
    
    //显示导航栏
    [bridge registerHandler:@"showNavigationBar" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self showNavigateionBar];
    }];
    //隐藏导航栏
    [bridge registerHandler:@"hiddenNavigationBar" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self hiddenNavigationBar];
    }];
    //显示与隐藏导航栏头部
    [bridge registerHandler:@"changeNavBarStatus" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dic = (NSDictionary *)data;
        NSString *str = [[dic objectForKey:@"status"] stringValue];
        if ([str isEqualToString:@"1"]) {
              [self hiddenNavigationBar];
        }else {
              [self showNavigateionBar];
        }
    }];
    //设置导航栏标题
    [bridge registerHandler:@"setTitle" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dic = (NSDictionary *)data;
        NSString *title = [dic objectForKey:@"title"];
        [self setNavigationTitle:title];
    }];
    //扫描二维码
    [bridge registerHandler:@"scanQRCode" handler:^(id data, WVJBResponseCallback responseCallback) {
        SmartQRCodeScanningVC *wcQRCodeScanningVC = [[SmartQRCodeScanningVC alloc] init];
        wcQRCodeScanningVC.scanCallback = ^(NSString *scanStr) {
            responseCallback(@{@"scanStr":scanStr});
        };
        [[self topViewController].navigationController pushViewController:wcQRCodeScanningVC animated:YES ];
    }];
    //拍照
    [bridge registerHandler:@"takePhoto" handler:^(id data, WVJBResponseCallback responseCallback) {
        SmartTakePhotoKit *smartTakePhotoKit =  [SmartTakePhotoKit shareManager];
        [smartTakePhotoKit startGetPhotoWithBridgeback:responseCallback];
    }];
    //开启传感器监听
    [bridge registerHandler:@"startObserveSensor" handler:^(id data, WVJBResponseCallback responseCallback) {
        Boolean isSuccess = [[SmartCoreMotionKit shareManager] startGyMotion];
        responseCallback(@{@"isSuccess":@(isSuccess)});
    }];
    //结束传感器监听
    [bridge registerHandler:@"stopObserveSensor" handler:^(id data, WVJBResponseCallback responseCallback) {
        [[SmartCoreMotionKit shareManager] stopGyMotion];
    }];
    //实时获取传感器数据
    [bridge registerHandler:@"getSensorMessage" handler:^(id data, WVJBResponseCallback responseCallback) {
//        [[SmartCoreMotionKit shareManager] pushMessageWithCallback:responseCallback];
        [[SmartCoreMotionKit shareManager] pushGyMessageToWebWithBridge:bridge];
        
    }];
    [bridge registerHandler:@"getLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
        [[SmartCoreLocationKit shareManager] startLocationWithBridge:responseCallback];
    }];
    
}

////webview历史回退
//- (Boolean)gobackWebViewPage {
//    if ([[SmartWebViewManager shareManager].currentWebView canGoBack]) {
//           [[SmartWebViewManager shareManager].currentWebView goBack];
//           return YES;
//    }else {
//        return NO;
//    }
//}

//显示导航栏
- (void)showNavigateionBar {
    if ([self topViewController].navigationController) {
        [[self topViewController].navigationController setNavigationBarHidden:NO animated:YES];
      
    }
}
//隐藏导航栏
- (void)hiddenNavigationBar {
    if ([self topViewController].navigationController) {
        [[self topViewController].navigationController setNavigationBarHidden:YES animated:YES];
    }
}
//设置导航栏标题
-  (Boolean)setNavigationTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    if (![self topViewController].navigationItem) {
        return NO;
    }
    [self topViewController].navigationItem.titleView = titleLabel;
    return YES;
}


//关闭webview
- (void)closeWebView {
    UIViewController *controller = [self topViewController];
    if (controller.presentingViewController) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    } else {
        [controller.navigationController popViewControllerAnimated:YES];
    }
}


//获取当前视图最顶层controller，支持大部分情况
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
