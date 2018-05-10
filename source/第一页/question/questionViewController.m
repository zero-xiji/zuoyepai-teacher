//
//  questionViewController.m
//  作业派-教师端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import "questionViewController.h"
#import "homeworkViewController.h"
#import "questionListViewController.h"
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
    if(select_type == 1)
    {
        _my_bar_tiem.title=@"修改题目";
        _question_detail.text=select_question_cell.question_detail;
        _question_answer.text=select_question_cell.question_answer;
        _question_score.text=select_question_cell.question_score;
        question_type=select_question_cell.question_type.integerValue;

        [_question_type_picker selectRow:question_type inComponent:0 animated:NO];
        [self setAnswerShow:question_type];
    }
    else
    {
        _my_bar_tiem.title=@"添加题目";
        _question_answer.hidden=YES;
        _btn_no.hidden=YES;
        _btn_yes.hidden=YES;
        
        _btn_A.hidden=NO;
        _btn_B.hidden=NO;
        _btn_C.hidden=NO;
        _btn_D.hidden=NO;
        _btn_A.selected=YES;
        [self btn_choice_A:_btn_A];
        this_question_answer=@"A";
        question_type=0;
    }
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
    else if(![self isPureInt:_question_score.text])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"警告" message:@"分数栏只能输入数字！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:Btn_yes];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        NSString *alertStr=@"";
        if(select_type==0)
        {
            alertStr=@"确认添加？";
        }
        else
        {
            alertStr=@"确认修改？";
        }
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:alertStr message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Btn_cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            if(select_type==0)
            {
                if([self add_question_url])
                {
                    UIAlertController *alert_is_success=[UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *Yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                        {
                                            [self.navigationController popViewControllerAnimated:YES];
//                                            [self dismissViewControllerAnimated:YES completion:nil];
                                        }];
                    [alert_is_success addAction:Yes];
                    [self presentViewController:alert_is_success animated:true completion:nil];
                }
            }
            else
            {
                if([self update_question_url])
                {
                    UIAlertController *alert_is_success=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *Yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                        {
                                            [self.navigationController popViewControllerAnimated:YES];

//                                            [self dismissViewControllerAnimated:YES completion:nil];
                                        }];
                    [alert_is_success addAction:Yes];
                    [self presentViewController:alert_is_success animated:true completion:nil];
                }
            }
        }];
        [alert addAction:Btn_yes];
        [alert addAction:Btn_cancel];
        [self presentViewController:alert animated:true completion:nil];
        
    }
}
- (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
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
-(BOOL)update_question_url
{
    BOOL is_update=NO;
    if(_question_answer.hidden==NO)
        this_question_answer=_question_answer.text;
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/update_question?question_id=%@&homework_id=%@&question_detail=%@&question_answer=%@&question_score=%@&question_type=%ld",
                           select_question_cell.question_id,
                           select_homework_cell.homework_id,
                           _question_detail.text,
                           this_question_answer,
                           _question_score.text,
                           (long)question_type];
    NSLog(@"%@", urlString);
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
    NSLog(@"%@",url);
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"修改成功"])
    {
        is_update=YES;
    }
    return is_update;
}

- (IBAction)back2questionTable:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
    [self setAnswerShow:row];
}
-(void)setAnswerShow:(NSInteger)row
{
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
        _btn_B.selected=NO;
        _btn_C.selected=NO;
        _btn_D.selected=NO;
        if(select_type==1)//update
        {
            if([select_question_cell.question_answer isEqualToString:@"A"])
            {
                _btn_A.selected=YES;
                [self btn_choice_A:_btn_A];
            }
            if([select_question_cell.question_answer isEqualToString:@"B"])
            {
                _btn_B.selected=YES;
                [self btn_choice_B:_btn_B];
            }
            if([select_question_cell.question_answer isEqualToString:@"C"])
            {
                _btn_C.selected=YES;
                [self btn_choice_C:_btn_C];
            }
            if([select_question_cell.question_answer isEqualToString:@"D"])
            {
                _btn_D.selected=YES;
                [self btn_choice_D:_btn_D];
            }
        }
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
        _btn_no.selected=NO;
        if(select_type==1)//update
        {
            if([select_question_cell.question_answer isEqualToString:@"Y"])
            {
                _btn_yes.selected=YES;
                [self btn_judge_yes:_btn_yes];
            }
            if([select_question_cell.question_answer isEqualToString:@"N"])
            {
                _btn_no.selected=YES;
                [self btn_judge_no:_btn_no];
            }
        }
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
