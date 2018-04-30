//
//  myViewController.m
//  3
//
//  Created by zero on 2018/2/23.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "myViewController.h"
#import "loginViewController.h"
@interface myViewController ()

@end

@implementation myViewController
int count_how_many_time_appear=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    _touxiang.userInteractionEnabled=YES;
    _touxiang.layer.masksToBounds=YES;
    _touxiang.layer.cornerRadius=70;
    _touxiang.contentMode = UIViewContentModeScaleAspectFill;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    count_how_many_time_appear++;
    if([this_user_.THIS_USER_IS_LOGIN isEqualToString:@"1"])
    {
        _btn_login.hidden=YES;//set btn can't be used
        _touxiang.image=[UIImage imageNamed:this_user_.THIS_TEACHER_USER_TOUXIANG];
        _l_userName.text=this_user_.THIS_TEACHER_USER_NAME;
        _l_school.text=this_user_.THIS_USER_BOLONG_TO_SCHOOL_NAME;
        _touxiang.contentMode = UIViewContentModeScaleAspectFill;
    }
    else
    {
        _btn_login.hidden=NO;//set btn can't be used
        _touxiang.image=[UIImage imageNamed:@"我.jpg"];
        _l_userName.text=@"登录名";
        _l_school.text=@"学校名";
        _touxiang.contentMode = UIViewContentModeScaleAspectFill;
    }
//    NSLog(@"this is view will appear %d",count_how_many_time_appear);
}
- (IBAction)btn_logout:(id)sender {
    if([this_user_.THIS_USER_IS_LOGIN isEqual: @"1"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/logout?table=teacher&user_name=%@&password=%@",this_user_.THIS_TEACHER_USER_NAME,this_user_.THIS_TEACHER_USER_PASSWORD];
            NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
            NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
            NSURL *url =[NSURL URLWithString:urlstringEncode];
            NSData *data= [NSData dataWithContentsOfURL:url];
            NSString *is_logout=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if([is_logout isEqual:@"退出成功!"])
            {
                [self set_logout_user];
                [self viewWillAppear:YES];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登录！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
    [self viewWillAppear:YES];
}
-(void)set_logout_user
{
    this_user_.THIS_USER_IS_LOGIN=@"0";
    this_user_.THIS_TEACHER_USER_NAME=nil;
    this_user_.THIS_TEACHER_USER_ID=nil;
    this_user_.THIS_TEACHER_USER_PASSWORD=nil;
    this_user_.THIS_TEACHER_USER_TOUXIANG=nil;
    this_user_.THIS_USER_BOLONG_TO_SCHOOL_ID=nil;
    this_user_.THIS_USER_BOLONG_TO_SCHOOL_NAME=nil;
}

- (IBAction)about_us:(id)sender {
    
}

- (IBAction)safaty:(id)sender {
    
}
@end
