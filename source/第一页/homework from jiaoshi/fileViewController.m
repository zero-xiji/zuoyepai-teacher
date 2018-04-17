//
//  fileViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/4/7.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "fileViewController.h"
#import "homework2ViewController.h"
#import <WebKit/WebKit.h>
#import "AFHTTPSessionManager.h"
#define KFileBoundary @"fanlu"
#define KNewLine @"\r\n"
#define KEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
@interface fileViewController ()<WKNavigationDelegate>

@end

@implementation fileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    WKWebView *webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ****************注*********************
    webView.navigationDelegate = self;
    [_main_view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://193.112.2.154:7079/SSHetet/uploadForm"];
    // 2.创建一个POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
//    request.HTTPMethod=@"POST";
    [webView loadRequest:request];
    [webView loadRequest:request];*/
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _my_bar.topItem.title=select_homework2_cell.HOMEWORK_SUBMISSION_TIME;
    [self upload_file2];
    NSLog(@"this is upload");
}
-(void)upload_file1
{
    // 1.请求路径
//    NSURL *url = [NSURL URLWithString:[@"http://193.112.2.154/SSHtet/file_upload/file.do"stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];//为了可以传递中文指定字符集
//    NSURL *url = [NSURL URLWithString:[@"http://193.112.2.154/SSHtet/upload" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];//为了可以传递中文指定字符集
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://193.112.2.154/SSHtet/upload?descripion=this_is_teacher_upload"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];//为了可以传递中文指定字符集

    // 2.创建一个POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
    
    [request setHTTPMethod:@"POST"];
    
    // 3.设置请求体
    NSMutableData *body = [NSMutableData data];
    
    //构造Content-Type
    NSString *fileName=@"\"6.jpg\"";
    NSMutableData *uData = [NSMutableData data];
    //Content-Type head
    NSString *strTop = [NSString stringWithFormat:@"------%@\r\nContent-Disposition: form-data; name=\"file1\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n",KFileBoundary,fileName,[self mimeType:fileName]];
    //Content_Type foot
    NSString *strBottom = [NSString stringWithFormat:@"\r\n------%@--\r\n",KFileBoundary];
    // 3.1.文件参数
    [body appendData:KEncode(@"--")];
    [body appendData:KEncode(KFileBoundary)];
    [body appendData:KEncode(KNewLine)];
    
    [body appendData:KEncode(@"Content-Disposition: form-data; name=\"file\"; filename=\"6.jpg\"")];
    [body appendData:KEncode(KNewLine)];
    
    [body appendData:KEncode(@"Content-Type: image/jpg")];
    [body appendData:KEncode(KNewLine)];
    
    [body appendData:KEncode(KNewLine)];
    UIImage *image = [UIImage imageNamed:@"6.jpg"];
    NSData *imageData= UIImagePNGRepresentation(image);
    [body appendData:imageData];
    [body appendData:KEncode(KNewLine)];
    
    // 3.2.用户名参数
    [body appendData:KEncode(@"--")];
    [body appendData:KEncode(KFileBoundary)];
    [body appendData:KEncode(KNewLine)];
    
    //直接复制上述字符串,将filename及类型去掉.因为不是文件参数,所以不需要filename及类型
    [body appendData:KEncode(@"Content-Disposition: form-data; name=\"username\"")];
    [body appendData:KEncode(KNewLine)];
    
    [body appendData:KEncode(KNewLine)];
    [body appendData:KEncode(@"张三")];
    [body appendData:KEncode(KNewLine)];
    
    // 3.3.结束标记
    [body appendData:KEncode(@"--")];
    [body appendData:KEncode(KFileBoundary)];
    [body appendData:KEncode(@"--")];
    [body appendData:KEncode(KNewLine)];
    
    request.HTTPBody = body;
    //文件数据
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
//    NSData *body = [NSData dataWithContentsOfFile:filePath];
    if (!body) {
        NSLog(@"no data!!");
    }
    [uData appendData:[strTop dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:body];
    [uData appendData:[strBottom dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // 4.设置请求头(告诉服务器这次传给你的是文件数据，告诉服务器现在发送的是一个文件上传请求)
    [request setHTTPMethod:@"POST"];
    //数据体
    [request setHTTPBody:body];
    //设置请求头
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)body.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=----%@",KFileBoundary] forHTTPHeaderField:@"Content-Type"];//多部分表单数据，支持浏览器访问，不进行任何编码，通常用于文件传输（此时传递的是二进制数据） 。

    NSURLSession *session = [NSURLSession sharedSession];
    // 5.发送请求
    NSURLSessionUploadTask *_task = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:dataStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:sureAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
    
    
    /*
     
     NSURL *url = [NSURL URLWithString:@"http://193.112.2.154:7079/SSHetet/uploadForm"];
     
     // 2.创建一个POST请求
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     request.HTTPMethod = @"POST";
     
     // 3.设置请求体
     NSMutableData *body = [NSMutableData data];
     
     // 3.1.文件参数
     [body appendData:KEncode(@"--")];
     [body appendData:KEncode(KFileBoundary)];
     [body appendData:KEncode(KNewLine)];
     
     [body appendData:KEncode(@"Content-Disposition: form-data; name=\"file\"; filename=\"test123.jpg\"")];
     [body appendData:KEncode(KNewLine)];
     
     [body appendData:KEncode(@"Content-Type: image/jpg")];
     [body appendData:KEncode(KNewLine)];
     
     [body appendData:KEncode(KNewLine)];
     UIImage *image = [UIImage imageNamed:@"10.jpeg"];
     NSData *imageData = UIImagejpgRepresentation(image);
     [body appendData:imageData];
     [body appendData:KEncode(KNewLine)];
     
     // 3.2.用户名参数
     [body appendData:KEncode(@"--")];
     [body appendData:KEncode(KFileBoundary)];
     [body appendData:KEncode(KNewLine)];
     
     //直接复制上述字符串,将filename及类型去掉.因为不是文件参数,所以不需要filename及类型
     [body appendData:KEncode(@"Content-Disposition: form-data; name=\"username\"")];
     [body appendData:KEncode(KNewLine)];
     
     [body appendData:KEncode(KNewLine)];
     [body appendData:KEncode(@"张三")];
     [body appendData:KEncode(KNewLine)];
     
     // 3.3.结束标记
     [body appendData:KEncode(@"--")];
     [body appendData:KEncode(KFileBoundary)];
     [body appendData:KEncode(@"--")];
     [body appendData:KEncode(KNewLine)];
     
     request.HTTPBody = body;
     
     // 4.设置请求头(告诉服务器这次传给你的是文件数据，告诉服务器现在发送的是一个文件上传请求)
     NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", KFileBoundary];
     [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
     
     // 5.发送请求
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
     NSLog(@"%@", dict);
     }];
     
     */
    /*
        NSMutableData *uData = [NSMutableData data];
        //Content-Type head
        NSString *strTop = [NSString stringWithFormat:@"------%@\r\nContent-Disposition: form-data; name=\"file1\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n",KFileBoundary,fileName,[self mimeType:fileName]];
        //Content_Type foot
        NSString *strBottom = [NSString stringWithFormat:@"\r\n------%@--\r\n",KFileBoundary];
    
        //文件数据
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSData *body = [NSData dataWithContentsOfFile:filePath];
        if (!body) {
            NSLog(@"no body!!");
        }
        [uData appendData:[strTop dataUsingEncoding:NSUTF8StringEncoding]];
        [uData appendData:body];
        [uData appendData:[strBottom dataUsingEncoding:NSUTF8StringEncoding]];*/
}
/*
 //网页即将开始加载时调用
//拦截网页加载，主动发送请求
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //获取拦截到的请求对应的URL Str
    NSString *URLStr = navigationAction.request.URL.absoluteString;
    NSLog(@"%@",URLStr);
    
    if ([URLStr isEqualToString:@"http://www.baidu.com"]) {
        NSLog(@"我点击了图片标签");
        TestTableViewController *testVC = [[TestTableViewController alloc]init];
        [self.navigationController pushViewController:testVC animated:YES];
        //不调用这个参数，程序会崩溃
        //这个参数必须调用，类似于UIWebView开始加载的时候，返回的YES.
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        NSLog(@"没有点击图片标签");
        //这个参数必须调用，类似于UIWebView开始加载的时候，返回的YES
        decisionHandler(WKNavigationActionPolicyAllow);
        
    }
    
    
}

//网页已经加载完成
//注入js
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    //拼接js的代码
    NSMutableString *stringM  = [NSMutableString string];
    //添加移除导航的js
    [stringM appendString:@"var headerTag = document.getElementsByTagName(\"header\")        [0];headerTag.parentNode.removeChild(headerTag);"];
    //添加移除橙色按钮的js
    [stringM appendString:@"var footerBtnTag = document.getElementsByClassName(\"footer-btn-fix\")[0]; footerBtnTag.parentNode.removeChild(footerBtnTag);"];
    //添加移除网页底部电脑版的js
    [stringM appendString:@"var footer = document.getElementsByClassName('footer')[0]; footer.parentNode.removeChild(footer);"];
    
    //给图片标签添加点击事件
    [stringM appendString:@"var imgTag = document.getElementsByTagName('figure')[0].children[0];imgTag.onclick=function imgClick(){window.location.href='hm://www.yaowoya.com'};"];
    //webView直接提供了注入js的方法
    //[webView stringByEvaluatingJavaScriptFromString:stringM];//UIWebView
    [webView evaluateJavaScript:stringM completionHandler:nil];//WKWebView
}
//网页已经开始加载调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//页面加载失败调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self upload];
}
//当内容开始返回时调用，即服务器已经在想客服端发送网页数据
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self upload];
}
 */

//基本构成为两个参数:文件参数与用户名参数.每个参数配置时的规则:先配置文件信息,再配置具体数据.
/*
 参数1
 参数2
 结束标记
 */

/*
 * 文件参数 :1.配置文件信息 2.配置具体文件数据
 fanlu
 Content-Disposition: form-data; name="参数名"; filename="文件名"
 Content-Type: 文件类型（MIMEType）
 
 文件具体数据
 
 * 非文件参数: 1.配置参数信息 2.配置具体参数值
 fanlu
 Content-Disposition: form-data; name="参数名"
 
 参数值
 */

-(NSString *)mimeType:(NSString*)filename
{
    NSString *type=@"image/jpge";
    return type;
}

- (void)upload_file2
{
//    NSURL *url = [NSURL URLWithString:[@"http://193.112.2.154/SSHtet/file_upload/file.do"stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];//为了可以传递中文指定字符集
    NSString *url=@"http://193.112.2.154/SSHtet/file_upload/file.do";//
//    NSString *url=@"http://193.112.2.154/SSHtet/upload";
    //此body是向后台传的参数, 因为是上传图片, 所以只给个图片名就够了, 这个和后台去问
    NSDictionary * body = @{@"category":@"user",@"file":@"HeadImg"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    UIImage *image = [UIImage imageNamed:@"6.jpg"];
    //NSData *imageData = UIImagejpgRepresentation(image);
    //ContentType设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/jpg",
                                                         @"application/octet-stream",
                                                         @"text/json", nil];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    [manager POST:url
       parameters:body
       constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //把image  转为data , POST上传只能传data
        NSData *data = UIImagePNGRepresentation(image);
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data
                                    name:@"filel"
                                fileName:@"gauge.jpg"
                                mimeType:@"image/jpg"];
        }
        progress:^(NSProgress * _Nonnull uploadProgress) {}
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功的block回调
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"上传成功%@",dic);
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error);
    }];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
