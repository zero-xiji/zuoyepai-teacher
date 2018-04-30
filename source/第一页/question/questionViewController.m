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
static NSString *this_question_answer;
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
-(void)viewWillAppear:(BOOL)animated
{
    _question_answer.hidden=YES;
    _btn_no.hidden=YES;
    _btn_yes.hidden=YES;
    
    _btn_A.hidden=NO;
    _btn_B.hidden=NO;
    _btn_C.hidden=NO;
    _btn_D.hidden=NO;
    _btn_A.selected=YES;
    this_question_answer=@"A";
    question_type=0;
}

- (IBAction)add_question:(id)sender {
    if(_question_score.text.length==0||_question_detail.text.length==0||_question_answer.text.length==0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"警告" message:@"分数栏、问题、答案均不可为空！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:Btn_yes];
        [self presentViewController:alert animated:true completion:nil];
    }
    else if(_question_score.text.intValue<0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"警告" message:@"分数栏不可为负数！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:Btn_yes];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认添加？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
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
    
    if(_question_answer.hidden==NO)
        this_question_answer=_question_answer.text;
    
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/add_question?homework_id=%@&question_detail=%@&question_answer=%@&question_score=%@&question_type=%ld",select_homework_cell.homework_id,_question_detail.text,this_question_answer,_question_score.text,(long)question_type];
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

- (IBAction)btn_judge_yes:(id)sender {
    _btn_no.selected=NO;
    this_question_answer =@"Y";
    NSLog(@"%@",this_question_answer);
}
- (IBAction)btn_judge_no:(id)sender {
    _btn_yes.selected=NO;
    this_question_answer =@"N";
    NSLog(@"%@",this_question_answer);
}

- (IBAction)btn_choice:(RadioButton *)sender
{
    this_question_answer =sender.titleLabel.text;
    NSLog(@"%@",this_question_answer);
}
- (IBAction)btn_choice_A:(id)sender {
    _btn_B.selected=NO;
    _btn_C.selected=NO;
    _btn_D.selected=NO;
}
- (IBAction)btn_choice_B:(id)sender {
    _btn_A.selected=NO;
    _btn_C.selected=NO;
    _btn_D.selected=NO;
}
- (IBAction)btn_choice_C:(id)sender {
    _btn_A.selected=NO;
    _btn_B.selected=NO;
    _btn_D.selected=NO;
}
- (IBAction)btn_choice_D:(id)sender {
    _btn_A.selected=NO;
    _btn_B.selected=NO;
    _btn_C.selected=NO;
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
    if( row == 0 )
    {
        _question_answer.hidden=YES;
        _btn_no.hidden=YES;
        _btn_yes.hidden=YES;
        
        this_question_answer=@"A";
        _btn_A.hidden=NO;
        _btn_B.hidden=NO;
        _btn_C.hidden=NO;
        _btn_D.hidden=NO;
        _btn_A.selected=YES;
//        this_question_message.THIS_QUESTION_TYPE=@" 单选题 ";
    }
    else if( row == 1 )
    {
        _question_answer.hidden=YES;
        _btn_A.hidden=YES;
        _btn_B.hidden=YES;
        _btn_C.hidden=YES;
        _btn_D.hidden=YES;
        
        this_question_answer=@"Y";
        _btn_no.hidden=NO;
        _btn_yes.hidden=NO;
        _btn_yes.selected=YES;
//        this_question_message.THIS_QUESTION_TYPE=@" 判断题 ";
    }
    else
    {
        _question_answer.hidden=NO;

        _btn_no.hidden=YES;
        _btn_yes.hidden=YES;
        _btn_A.hidden=YES;
        _btn_B.hidden=YES;
        _btn_C.hidden=YES;
        _btn_D.hidden=YES;
//        this_question_message.THIS_QUESTION_TYPE=@" 填空／简答题 ";
    }
}


@end
