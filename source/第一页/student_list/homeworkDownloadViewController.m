//
//  homeworkDownloadViewController.m
//  作业派-教师端
//
//  Created by 王培俊 on 2018/4/11.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "homeworkDownloadViewController.h"
#import <WebKit/WebKit.h>
@interface homeworkDownloadViewController ()<WKNavigationDelegate>

@end

@implementation homeworkDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //****************注*********************
//    webView.navigationDelegate = self;
//    [_main_view addSubview:webView];
//    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/download?file_name=%@",select_file_message.THIS_FILE_NAME]];
//    // 2.创建一个POST请求
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"POST";
//    [webView loadRequest:request];
//    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
//    _my_bar.topItem.title=select_file_message.THIS_FILE_NAME;
    NSLog(@"this is download");
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
