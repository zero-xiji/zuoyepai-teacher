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
@interface questionListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<question *> *question_dataSource;///<describe
@end

@implementation questionListViewController
static THIS_QUESTION_MESSAGE this_question_message;
- (void)viewDidLoad {
    [super viewDidLoad];
    _question_table.tableFooterView = [[UIView alloc] init];
    _question_table.dataSource=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initdata];
    [_question_table reloadData];
}

- (void)initdata
{
    _question_dataSource =[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select_question?operate=teacher_select&homework_id=%@",select_homework_cell.THIS_HOMEWORK_ID]];
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
            question *p0 = [question question_in_homeworkWithName:this_question_message.THIS_QUESTION_ID
                                                      homework_id:this_question_message.THIS_HOMEWORK_ID
                                                  question_detail:this_question_message.THIS_QUESTION_DETAIL
                                                  question_answer:this_question_message.THIS_QUESTION_ANSWER
                                                   question_score:this_question_message.THIS_QUESTION_SCORE
                                                    question_type:@"123"];
            [_question_dataSource addObject:p0];
        }
    }
}
-(void)set_this_question:(NSString*) every_question_all_message
{
    NSArray *question_detial=[every_question_all_message componentsSeparatedByString:@"*"];
    this_question_message.THIS_QUESTION_ID=[question_detial objectAtIndex:0];
    this_question_message.THIS_HOMEWORK_ID=[question_detial objectAtIndex:1];
    this_question_message.THIS_QUESTION_DETAIL=[question_detial objectAtIndex:2];
    this_question_message.THIS_QUESTION_ANSWER=[question_detial objectAtIndex:3];
    this_question_message.THIS_QUESTION_SCORE=[question_detial objectAtIndex:4];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    NSLog(@"this is student tableview cell set");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    questionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"question_cell" forIndexPath:indexPath];
    cell.model=_question_dataSource[indexPath.row];
    return cell;
}
//实现右滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        questionTableViewCell *this_cell_select=[tableView cellForRowAtIndexPath:indexPath];
        //alert to make sure user want to exit this class
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该学生吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              //delete from database in mysql
                              BOOL is_success_delete=[self url_to_delete_student:this_cell_select.model.question_id];
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
-(BOOL)url_to_delete_student:(NSString *)homework_id_to_delete
{
    BOOL is_success_delete=NO;
    //    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/myhomework?operate=delete&user_id=%@&put_id=%@",this_user_.THIS_TEACHER_USER_ID,homework_id_to_delete]];
    //    NSData *data= [NSData dataWithContentsOfURL:url];
    //    NSString *return_text =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //    NSArray *array = [return_text componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    //    NSString *is_delete=[array objectAtIndex:1];
    //    //alert
    //    UIAlertController *alert;
    //    if([is_delete isEqual:@"删除成功"])
    //    {
    //        alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功" preferredStyle:UIAlertControllerStyleAlert];
    //        is_success_delete=YES;
    //    }
    //    else
    //    {
    //        alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"作业不存在" preferredStyle:UIAlertControllerStyleAlert];
    //        is_success_delete=NO;
    //    }
    //    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    //    [alert addAction:Btn_yes];
    //    [self presentViewController:alert animated:true completion:nil];
    //    NSLog(@"this is delete ");
    return is_success_delete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除该班级";
}
@end
