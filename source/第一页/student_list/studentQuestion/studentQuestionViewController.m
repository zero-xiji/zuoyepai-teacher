//
//  studentQuestionViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/4/18.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "studentQuestionViewController.h"
#import "student_listViewController.h"
@interface studentQuestionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<student_question *> *question_dataSource;///<describe
@end

@implementation studentQuestionViewController
static student_question *this_question_message;
- (void)viewDidLoad {
    [super viewDidLoad]; _question_table.tableFooterView = [[UIView alloc] init];
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
    [_question_table reloadData];
}

- (void)initdata
{
    _question_dataSource =[NSMutableArray new];
    NSString *urlString=[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select-student-question?student_id=%@",select_student_cell.user_id];
    NSURL *url =[NSURL URLWithString:urlString];
    NSLog(@"%@",urlString);
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"该作业暂无题目"])
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
            if(![this_question_message.student_score isEqualToString:@"-1"])
            {
//                if(this_question_message.student_answer.length==0)
//                {
//                    this_question_message.student_answer=@"！学生交了白卷";
//                }
                [_question_dataSource addObject:this_question_message];
            }
        }
    }
}
-(void)set_this_question:(NSString*) every_question_all_message
{
    NSArray *question_detial=[every_question_all_message componentsSeparatedByString:@"*"];
    this_question_message=[student_question question_in_homeworkWithName:[question_detial objectAtIndex:0]
                                                             homework_id:[question_detial objectAtIndex:1]
                                                         question_detail:[question_detial objectAtIndex:2]
                                                         question_answer:[question_detial objectAtIndex:3]
                                                          question_score:[question_detial objectAtIndex:4]
                                                           question_type:[question_detial objectAtIndex:5]
                                                          student_answer:[question_detial objectAtIndex:8]
                                                           student_score:[question_detial objectAtIndex:7]
                           ];
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
    NSLog(@"this is student didSelectRowAtIndexPath set");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    studentQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"student_question_cell" forIndexPath:indexPath];
    if(![cell.model.question_type isEqualToString:@"2"])
    {
        cell.my_score.hidden=YES;
    }
    if([cell.model.question_type isEqualToString:@"2"])
    {
        cell.my_score.hidden=NO;
        cell.student_score.hidden=YES;
    }
    cell.model=_question_dataSource[indexPath.row];
    return cell;
}
@end
