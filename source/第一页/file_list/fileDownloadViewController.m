//
//  questionListViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/4/7.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "fileDownloadViewController.h"
#import "file2ViewController.h"
#import <WebKit/WebKit.h>
//#define KFileBoundary @"fanlu"
//#define KNewLine @"\r\n"
//#define KEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
@interface fileDownloadViewController ()<WKNavigationDelegate>

@end

@implementation fileDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //****************注*********************
    webView.navigationDelegate = self;
    [_main_view addSubview:webView];
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/download?file_name=%@",select_file_message.file_name];
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
//    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/download?file_name=%@",select_file_message.THIS_FILE_NAME]];
    // 2.创建一个POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [webView loadRequest:request];
    [webView loadRequest:request];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _my_bar.topItem.title=select_file_message.file_name;
    NSLog(@"this is download");
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

