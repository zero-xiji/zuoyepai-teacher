//
//  studentHomeworkViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/4/23.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "studentHomeworkViewController.h"
#import "loginViewController.h"
#import "student_listViewController.h"
@interface studentHomeworkViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray<homework *> *student_homework_dataSource;///<describe
@end

@implementation studentHomeworkViewController
static homework *this_student_homework_message;
static int rows;
- (void)viewDidLoad {
    [super viewDidLoad];
    _student_homework_table.tableFooterView = [[UIView alloc] init];
    _student_homework_table.dataSource=self;
    _student_homework_table.delegate=self;
    [self setupRefresh];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _my_bar_item.title=select_student_cell.user_name;
    [self initdata];
    [_student_homework_table reloadData];
}

- (void)initdata
{
    _student_homework_dataSource =[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/myhomework?operate=select_student_homework_in_this_class&user_id=%@&put_id=%@",select_student_cell.user_id,select_class_cell.class_id]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"0]该课程不存在作业"])
    {
        _student_homework_is_null.text=@"该学生暂未提交作业";
        _student_homework_dataSource=NULL;
    }
    else
    {
        _student_homework_is_null.text=@"";
        NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
        NSString *how_many_class=[array objectAtIndex:0];
        NSString *all_class_been_search=[array objectAtIndex:1];
        NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
        rows=[how_many_class intValue];
        for(int i=0;i<rows;i++)
        {
            NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
            [self set_this_homework:every_class_all_message];///< class
            if([this_student_homework_message.is_submit isEqual:@"1"]
               ||([this_student_homework_message.is_submit isEqual:@"0"]&&this_student_homework_message.is_time_over==NO))
            {
                [_student_homework_dataSource addObject:this_student_homework_message];
            }
        }
    }
}
-(void)set_this_homework:(NSString*) every_class_all_message
{
    //class_id class_name teacher_id
    NSArray *class_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_student_homework_message = [homework homeworkWithName:[class_detial objectAtIndex:0]
                                                      class_id:[class_detial objectAtIndex:1]
                                                    class_name:select_class_cell.class_name
                                                   course_name:[class_detial objectAtIndex:3]
                                                        detail:[class_detial objectAtIndex:6]
                                                      end_time:[class_detial objectAtIndex:7]
                                                  is_time_over:[self is_time_over:[class_detial objectAtIndex:7]]
                                                      is_issue:[class_detial objectAtIndex:8]
                                                     is_submit:[class_detial objectAtIndex:12]
                                                 is_correcting:[class_detial objectAtIndex:9]
                                                 student_score:[class_detial objectAtIndex:10]
                                                         score:[class_detial objectAtIndex:11]];
}

-(BOOL)is_time_over:(NSString *)end_time_to_check
{
    BOOL is_time_over_return=NO;
    
    int is_end_time_now=[self junc_CompareOneDateStr:end_time_to_check];
    if(is_end_time_now==-1)
    {
        is_time_over_return=YES;
    }
    return is_time_over_return;
}
- (int)junc_CompareOneDateStr:(NSString *)oneDateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    
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

-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [_student_homework_table addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
}
/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
-(void)refreshStateChange:(UIRefreshControl *)control
{
    [self initdata];
    [_student_homework_table reloadData];
    [control endRefreshing];
}

#pragma mark -UITableView 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _student_homework_dataSource.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    studentHomeworkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"student_homework_cell" forIndexPath:indexPath];
    cell.model=self.student_homework_dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"homework tableview cell Select");
    studentHomeworkTableViewCell *select=[tableView cellForRowAtIndexPath:indexPath];
    if([select.is_submit isEqual:@"0"]&&select.is_time_over==NO)
    {
        select.selected=NO;
    }
    select_student_homework_cell = [homework homeworkWithName:[_student_homework_dataSource objectAtIndex:indexPath.row].homework_id
                                                     class_id:[_student_homework_dataSource objectAtIndex:indexPath.row].class_id
                                                   class_name:[_student_homework_dataSource objectAtIndex:indexPath.row].class_name
                                                  course_name:[_student_homework_dataSource objectAtIndex:indexPath.row].course_name
                                                       detail:[_student_homework_dataSource objectAtIndex:indexPath.row].detail
                                                     end_time:[_student_homework_dataSource objectAtIndex:indexPath.row].end_time
                                                 is_time_over:[_student_homework_dataSource objectAtIndex:indexPath.row].is_time_over
                                                     is_issue:[_student_homework_dataSource objectAtIndex:indexPath.row].is_issue
                                                    is_submit:[_student_homework_dataSource objectAtIndex:indexPath.row].is_submit
                                                is_correcting:[_student_homework_dataSource objectAtIndex:indexPath.row].is_correcting
                                                student_score:[_student_homework_dataSource objectAtIndex:indexPath.row].student_score
                                                        score:[_student_homework_dataSource objectAtIndex:indexPath.row].score];
    NSLog(@"select_student_homework_cell = %@",select_student_homework_cell.homework_id);
    select.homework_detail=select.detail.text;
}

- (IBAction)back2class:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
