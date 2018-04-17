//
//  messageViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/2/25.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "messageViewController.h"
#import "loginViewController.h"
@interface messageViewController ()

@end

@implementation messageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isNull=true;
    if(_isNull)
    {
        _label_isNull.text=@"暂无通知";
    }
    else
    {
        _label_isNull.text =@"通知";
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)add_message:(id)sender {
    
    //set the alert
    if(![this_user_.THIS_USER_IS_LOGIN isEqual:@"1"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入要添加的通知" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder=@"通知的班级";
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder=@"通知内容";
            //textField.secureTextEntry=YES;
        }];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:Btn_cancle];
        [alert addAction:Btn_yes];
        //
        //add this alert into the view
        //
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (IBAction)add_course:(id)sender {
    //set the alert
    if(![this_user_.THIS_USER_IS_LOGIN isEqual:@"1"])
    {
        _course_table_view.hidden=YES;
        _course_view.hidden=NO;
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入要添加的课程" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder=@"课程名";
        }];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *add_course = alert.textFields.firstObject;
            NSLog(@"%@",add_course.text);
            [self add_course_url:add_course.text];
        }];
        UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:Btn_cancle];
        [alert addAction:Btn_yes];
        //
        //add this alert into the view
        //
        [self presentViewController:alert animated:true completion:nil];
    }
}
- (void)add_course_url:(NSString *)course_put_in
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/course?operate=add&user_id=%@&user_type=teacher&course_name=%@",this_user_.THIS_TEACHER_USER_ID,course_put_in];
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
//    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/course?operate=add&user_id=%@&user_type=teacher&course_name=%@",this_user_.THIS_TEACHER_USER_ID,course_put_in]];
    NSData *data_teacher= [NSData dataWithContentsOfURL:url];
    NSString *return_text=[[NSString alloc]initWithData:data_teacher encoding:NSUTF8StringEncoding];
    if([return_text isEqual:@"add添加成功"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //[self dismissViewControllerAnimated:YES completion:nil];
            _course_table_view.hidden=NO;
            _course_view.hidden=YES;
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (IBAction)add_my_course:(id)sender {
    //set the alert
    if(![this_user_.THIS_USER_IS_LOGIN isEqual:@"1"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入要添加的作业" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder=@"班级名";
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder=@"作业内容";
            //textField.secureTextEntry=YES;
        }];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:Btn_cancle];
        [alert addAction:Btn_yes];
        //
        //add this alert into the view
        //
        [self presentViewController:alert animated:true completion:nil];
    }
    
}
-(void)add_course_click:(id)sender
{
    
}
@end
