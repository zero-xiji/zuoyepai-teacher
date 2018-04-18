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
    
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select_question?operate=teacher_select&homework_id=%@",select_homework_cell.THIS_HOMEWORK_ID];
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
            question *p0 = [question question_in_homeworkWithName:this_question_message.THIS_QUESTION_ID
                                                      homework_id:this_question_message.THIS_HOMEWORK_ID
                                                  question_detail:this_question_message.THIS_QUESTION_DETAIL
                                                  question_answer:this_question_message.THIS_QUESTION_ANSWER
                                                   question_score:this_question_message.THIS_QUESTION_SCORE
                                                    question_type:this_question_message.THIS_QUESTION_TYPE];
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
    this_question_message.THIS_QUESTION_TYPE=[question_detial objectAtIndex:5];
    if([this_question_message.THIS_QUESTION_TYPE isEqualToString:@"0"])
    {
        this_question_message.THIS_QUESTION_TYPE=@" 单选题 ";
    }
    else     if([this_question_message.THIS_QUESTION_TYPE isEqualToString:@"1"])
    {
        this_question_message.THIS_QUESTION_TYPE=@" 判断题 ";
    }
    else
    {
        this_question_message.THIS_QUESTION_TYPE=@" 填空／简答题 ";
    }
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
@end
