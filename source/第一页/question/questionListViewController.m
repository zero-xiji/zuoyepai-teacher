//
//  questionListViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/4/7.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "questionListViewController.h"
#import "homeworkViewController.h"
#import "questionTableViewCell.h"
#import "questionViewController.h"
@interface questionListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<question *> *question_dataSource;///<describe
@end

@implementation questionListViewController
static question *this_question_message;
static int can_change;
- (void)viewDidLoad {
    [super viewDidLoad];
    _question_table.tableFooterView = [[UIView alloc] init];
    _question_table.dataSource=self;
    _question_table.delegate=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initdata];
    _my_bar_item.title=select_homework_cell.detail;
    _my_bar_item.leftBarButtonItem.tintColor=[UIColor grayColor];
    if([select_homework_cell.is_issue isEqualToString:@"1"])
    {
        _btn_issue_homework.hidden=YES;
        _btn_add_question.title=@"";
        _btn_add_question.action=nil;
        can_change=0;
    }
    else
    {
        can_change=1;
    }
    [_question_table reloadData];
    _question_table.estimatedRowHeight = 44.0f;//推测高度，必须有，可以随便写多少
    _question_table.rowHeight =UITableViewAutomaticDimension;//iOS8之后默认就是这个值，可以省略
}

- (void)initdata
{
    _question_dataSource =[NSMutableArray new];
    
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select_question?operate=teacher_select&homework_id=%@",select_homework_cell.homework_id];
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
//    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select_question?operate=teacher_select&homework_id=%@",select_homework_cell.THIS_HOMEWORK_ID]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"0]该作业暂无题目"])
    {
        _question_is_null.text=@"该作业暂无题目";
        _question_dataSource=NULL;
    }
    else
    {
        _question_is_null.text=@"";
        NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
        NSString *how_many_question=[array objectAtIndex:0];
        NSString *all_class_been_search=[array objectAtIndex:1];
        NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
        int rows=[how_many_question intValue];
        for(int i=0;i<rows;i++)
        {
            NSString *every_question_all_message=[class_in_one_row objectAtIndex:i];
            [self set_this_question:every_question_all_message];///< class
            [_question_dataSource addObject:this_question_message];
        }
    }
}
-(void)set_this_question:(NSString*) every_question_all_message
{
    NSArray *question_detial=[every_question_all_message componentsSeparatedByString:@"*"];
    this_question_message=[question question_in_homeworkWithName:[question_detial objectAtIndex:0]
                                                     homework_id:[question_detial objectAtIndex:1]
                                                 question_detail:[question_detial objectAtIndex:2]
                                                 question_answer:[question_detial objectAtIndex:3]
                                                  question_score:[question_detial objectAtIndex:4]
                                                   question_type:[question_detial objectAtIndex:5]];  
}

#pragma mark -UITableView 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _question_dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"this is student tableview cell select");
    questionViewController *updateView=[[questionViewController alloc]init];
    updateView.tabBarItem.title=@"修改题目";
    updateView.question_answer.text=[_question_dataSource objectAtIndex:indexPath.row].question_answer;
    updateView.question_detail.text=[_question_dataSource objectAtIndex:indexPath.row].question_detail;
    [updateView.question_type_picker selectRow:[[_question_dataSource objectAtIndex:indexPath.row].question_type intValue] inComponent:0 animated:YES];
    [self.navigationController pushViewController:updateView animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    questionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"question_cell" forIndexPath:indexPath];
    cell.model=_question_dataSource[indexPath.row];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(can_change == 1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        questionTableViewCell *this_cell_select=[tableView cellForRowAtIndexPath:indexPath];
        //alert to make sure user want to exit this class
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该题目吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              //delete from database in mysql
                              BOOL is_success_delete=[self url_to_delete_question:this_cell_select.model.question_id];
                              if(is_success_delete)
                              {
                                  ///< delete this rows
                                  [_question_dataSource removeObjectAtIndex:indexPath.row];
                                  [_question_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                              }
                          }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除该题目";
}
-(BOOL)url_to_delete_question:(NSString *)question_id_to_delete
{
    BOOL is_success_delete=NO;
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/delete_question?question_id=%@",question_id_to_delete]];
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *return_text =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [return_text componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *is_delete=[array objectAtIndex:1];
    //alert
    UIAlertController *alert;
    if([is_delete isEqual:@"删除成功"])
    {
        alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功" preferredStyle:UIAlertControllerStyleAlert];
        is_success_delete=YES;
    }
    else
    {
        alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"发生错误" preferredStyle:UIAlertControllerStyleAlert];
        is_success_delete=NO;
    }
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [self presentViewController:alert animated:true completion:nil];
    NSLog(@"this is delete ");
    return is_success_delete;
}


- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)issue_homework:(id)sender
{
    if(_question_dataSource.count==0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"作业中无题目，不可发布！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:Btn_yes];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        int is_end_time_now=[self junc_CompareOneDateStr:select_homework_cell.end_time :1];
        if(is_end_time_now!=-1)
        {
            UIAlertController *alert_set_time=[UIAlertController alertControllerWithTitle:@"现在的时间已超过原设定提交时间，请重新设置提交时间" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert_set_time addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.text=select_homework_cell.detail;
            }];
            [alert_set_time addTextFieldWithConfigurationHandler:^(UITextField *textField){
                NSDateFormatter *now_time_f = [[NSDateFormatter alloc] init];
                [now_time_f setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSDate *datenow = [NSDate date];
                NSString *nowtimeStr = [now_time_f stringFromDate:datenow];
                textField.text=nowtimeStr;
            }];
            [alert_set_time addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                NSString *homework_name=alert_set_time.textFields.firstObject.text;
                NSString *submission_time=alert_set_time.textFields.lastObject.text;
                //recheck is time just?
                int is_end_time_now=[self junc_CompareOneDateStr:submission_time :0];
                if(is_end_time_now==-1)
                {
                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认修改提交时间并发布作业吗？" message:@"发布作业后不可修改" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                    {
                        _question_table.allowsSelection=NO;
                        [self issue_homework_url:select_homework_cell.homework_id
                                          detail:homework_name
                                 submission_time:submission_time];
                    }];                        
                    UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:Btn_yes];
                    [alert addAction:Btn_cancle];
                    [self presentViewController:alert animated:true completion:nil];
                }
                else
                {
                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提交时间不合理" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:Btn_yes];
                    [self presentViewController:alert animated:true completion:nil];
                }
            }]];
            [alert_set_time addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert_set_time animated:true completion:nil];
        }
        else
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"发布作业" message:@"发布作业后不可修改，是否确认发布？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                _question_table.allowsSelection=NO;
                [self issue_homework_url:select_homework_cell.homework_id
                                  detail:select_homework_cell.detail
                         submission_time:select_homework_cell.end_time];
            }];
            UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:Btn_yes];
            [alert addAction:Btn_cancle];
            [self presentViewController:alert animated:true completion:nil];
        }
    }
}
- (int)junc_CompareOneDateStr:(NSString *)oneDateStr :(int)is_submit_time
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    if(is_submit_time==0)
    {
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else
    {
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    }
    NSDate *dateA = [[NSDate alloc]init];
    dateA = [df dateFromString:oneDateStr];

    NSDateFormatter *now_time_f = [[NSDateFormatter alloc] init];
    [now_time_f setDateFormat:@"YYYY-MM-dd HH:mm:ss.S"];
    NSDate *dateB = [NSDate date];
    
    NSString *dateAStr = [df stringFromDate:dateA];
    NSString *dateBStr = [df stringFromDate:dateB];
    NSLog(@"\n dataA = %@ \n dataB = %@",dateAStr,dateBStr);
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedAscending)
    {  // end_time < nowtimeStr
        return 1;
        
    }
    else if (result == NSOrderedDescending)
    {  // end_time > nowtimeStr
        return -1;
    }
    
    // oneDateStr = anotherDateStr
    return 0;
}

-(void)issue_homework_url:(NSString *)homework_id_to_issue
                   detail:(NSString *)detail
          submission_time:(NSString *)submission_time
{
    NSString *urlString=[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/issue_homework?teacher_id=%@&homework_id=%@&submission_time=%@&detail=%@",
                         this_user_.THIS_TEACHER_USER_ID,
                         select_homework_cell.homework_id,
                         submission_time,
                         detail];
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
    //2.根据ＷＥＢ路径创建一个请求
    NSLog(@"this is issue_homework_url \n url = %@",urlString);
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          [self.navigationController popToRootViewControllerAnimated:YES];
//                          [self dismissViewControllerAnimated:YES completion:nil];
                      }]];
    [self presentViewController:alert animated:true completion:nil];
}
@end
