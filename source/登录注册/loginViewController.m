//
//  loginViewController.m
//  3
//
//  Created by zero on 2018/2/23.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "loginViewController.h"
#import "mainViewController.h"
#import "registerViewController.h"
//#import "ExternModel.h"
@interface loginViewController ()

@end

@implementation loginViewController
THIS_TEACHER_USER this_user_;
- (void)viewDidLoad {
    [super viewDidLoad];
    _touxiang.userInteractionEnabled=YES;
    _touxiang.layer.masksToBounds=YES;
    _touxiang.layer.cornerRadius=50;
    _page=[NSUserDefaults standardUserDefaults];
    this_user_.THIS_TEACHER_USER_NAME=@"";
    this_user_.THIS_TEACHER_USER_PASSWORD=@"";
    this_user_.THIS_TEACHER_USER_TOUXIANG=@"";
    //添加手势，为了关闭键盘的操作
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];

    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击空白处的手势要实现的方法
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
}

- (IBAction)is_login:(id)sender {
    this_user_.THIS_TEACHER_USER_NAME=@"";
    this_user_.THIS_TEACHER_USER_PASSWORD=@"";
    if([_username.text length]==0||[_password.text length]==0)
    {
        _tips.text=@"用户名或密码不能为空！";
    }
    else
    {
        this_user_.THIS_TEACHER_USER_NAME=_username.text;
        this_user_.THIS_TEACHER_USER_PASSWORD=_password.text;
        _tips.text=@"";
        //1.请求的网址：即请求的接口，
        NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/login?table=teacher&user_name=%@&password=%@",_username.text,_password.text];
        NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
        NSURL *url =[NSURL URLWithString:urlstringEncode];
        //        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/login?table=teacher&user_name=%@&password=%@",_username.text,_password.text]];
        //2.根据ＷＥＢ路径创建一个请求
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSData *data_teacher= [NSData dataWithContentsOfURL:url];
        NSString *set_text=[[NSString alloc]initWithData:data_teacher encoding:NSUTF8StringEncoding];
        _tips.text= set_text;
        NSLog(@"%@",_tips.text);
        if([_tips.text isEqual:@"登录成功!"])
        {
            [self setUser];
            _tips.text=@"";
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功！" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alert animated:true completion:nil];
        }
    }
}
- (IBAction)turn2register:(id)sender {
    _tips.text=@"";
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setUser
{
    NSURL *url_touxiang =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/my_view?table=teacher&user_name=%@&password=%@",this_user_.THIS_TEACHER_USER_NAME,this_user_.THIS_TEACHER_USER_PASSWORD]];
    NSData *data= [NSData dataWithContentsOfURL:url_touxiang];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    this_user_.THIS_TEACHER_USER_NAME=_username.text;
    this_user_.THIS_TEACHER_USER_PASSWORD=_password.text;
    this_user_.THIS_USER_IS_LOGIN=@"1";
    this_user_.THIS_TEACHER_USER_TOUXIANG=[array objectAtIndex:1];
    this_user_.THIS_USER_BOLONG_TO_SCHOOL_NAME=[array objectAtIndex:3];
    this_user_.THIS_TEACHER_USER_ID=[array objectAtIndex:4];
}
@end


