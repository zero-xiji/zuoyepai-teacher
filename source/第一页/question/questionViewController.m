//
//  questionViewController.m
//  作业派-教师端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import "questionViewController.h"
#import "homeworkViewController.h"
@interface questionViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic) NSArray *question_type_datasource;
@end

@implementation questionViewController
static NSInteger question_type;
- (void)viewDidLoad {
    [super viewDidLoad];
    _question_type_datasource = [[NSArray alloc] initWithObjects:@"单选题",@"判断题",@"填空/简答题",nil];
    _question_type_picker.dataSource=self;
    _question_type_picker.delegate=self;
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)add_question:(id)sender {
    if(_question_score.text.length==0||_question_detail.text.length==0||_question_answer.text.length==0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"警告" message:@"分数栏、问题、答案均不可为空！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:Btn_yes];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认添加" message:@"确认添加？" preferredStyle:UIAlertControllerStyleAlert];
//        UILabel *tip_label=[[UILabel alloc]init];
//        tip_label.text=[NSString stringWithFormat:@"题型：%@\n分值：%@"]
        UIAlertAction *Btn_cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            if([self add_question_url])
            {
                UIAlertController *alert_is_success=[UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *Yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert_is_success addAction:Yes];
                [self presentViewController:alert_is_success animated:true completion:nil];
            }
        }];
        [alert addAction:Btn_yes];
        [alert addAction:Btn_cancel];
        [self presentViewController:alert animated:true completion:nil];
        
    }
}
-(BOOL)add_question_url
{
    BOOL is_add=NO;
    
    NSString *question_Detail=_question_detail.text;
    NSString *question_Answer=_question_answer.text;
    NSString *question_Scores=_question_score.text;
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/add_question?homework_id=%@&question_detail=%@&question_answer=%@&question_score=%@&question_type=%ld",select_homework_cell.THIS_HOMEWORK_ID,question_Detail,question_Answer,question_Scores,(long)question_type];
    NSLog(@"%@", urlString);
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
    NSLog(@"%@",url);
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"0]添加成功"])
    {
        is_add=YES;
    }
    return is_add;
}
- (IBAction)back2questionTable:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:_question_type_datasource[row], row, component];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    question_type=row;
}


@end
