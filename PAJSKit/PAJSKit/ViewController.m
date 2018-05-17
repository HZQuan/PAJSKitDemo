//
//  ViewController.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/16.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "ViewController.h"
#import "SmartWKWebView.h"

@interface ViewController ()

@property (nonatomic, strong)SmartUIWebView *smartWebView;
@property (nonatomic, strong)SmartWKWebView *smartWKWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testWKWebView];
}

- (void)testUIWebView {
    self.smartWebView = [SmartUIWebView shareManager];
    self.smartWebView.frame =CGRectMake(100, 0,[UIScreen mainScreen].bounds.size.width,500);
    [self.view addSubview:self.smartWebView ];
    NSString *url = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]];
    [self.smartWebView loadRequest:request];
  
}
- (IBAction)clickAction:(id)sender {
    //测试JS调用
//    [self.smartWKWebView callHandlerWithName:@"Test"data:@{@"name":@"黄增权",@"name2":@"凌代平"}];
    [self.smartWKWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.comfdsffadsdfsa/"]]];
}

- (void)testWKWebView {
    self.smartWKWebView = [SmartWKWebView shareManager];
    self.smartWKWebView.frame =CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 500);
    [self.view addSubview:self.smartWKWebView ];
    NSString *url = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]];
    [self.smartWKWebView loadRequest:request];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
