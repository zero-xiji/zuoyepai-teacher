//
//  registerViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/2/2作业派-教师端.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "registerViewController.h"
#import "myViewController.h"
@interface registerViewController ()

@end
@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _touxiang.userInteractionEnabled=YES;
    _touxiang.layer.masksToBounds=YES;
    _touxiang.layer.cornerRadius=70;
    _now_touxiang=[_touxiang.image accessibilityIdentifier];
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
- (void)viewWillAppear:(BOOL)animated
{
    _now_touxiang=@"0.jpg";
}

//点击空白处的手势要实现的方法
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
    
}
- (IBAction)back:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)is_register:(id)sender
{
    if([_username.text length]==0||[_password.text length]==0||[_password2.text length]==0||[_school.text length]==0)
    {
        _tips.text=@"用户名、密码、就读学校不能为空！";
    }
    else if([_username.text length]==0)
    {
        _tips.text=@"请输入用户名";
    }
    else if([_password.text length]<8||[_password2.text length]<8)
    {
        _tips.text=@"密码必须大于8位";
    }
    else if(![_password.text isEqual:_password2.text])
    {
        _tips.text=@"两次输入的密码不同！";
    }
    //    if(![_username.text isEqual:@""]&&[_password.text isEqual:_password2.text]&&[_password2 isEqual:@""])
    else
    {
        _tips.text=@"";
        //1.请求的网址：即请求的接口，
        NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/register?table=teacher&user_name=%@&password=%@&touxiang=%@&school_id=%@",_username.text,_password.text,_now_touxiang,_school.text];
        NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
        NSURL *url =[NSURL URLWithString:urlstringEncode];
        NSData *data_teacher= [NSData dataWithContentsOfURL:url];
        NSString *set_text=[[NSString alloc]initWithData:data_teacher encoding:NSUTF8StringEncoding];
        if([set_text isEqual:@"注册成功!"])
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功,等待管理员审核!" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alert animated:true completion:nil];
        }
        else
        {
            _tips.text=set_text;
        }
    }
}

- (IBAction)return2login:(id)sender
{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)change_touxiang:(id)sender
{
    int num=arc4random()%9;
    NSString *imgName=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%d.jpg",num]];
    _touxiang.image=[UIImage imageNamed:imgName];
    _now_touxiang=imgName;
}

@end
