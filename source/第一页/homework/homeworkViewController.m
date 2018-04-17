//
//  homeworkViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/4/6.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "homeworkViewController.h"
#import "homeworkTableViewCell.h"
#import "loginViewController.h"
@interface homeworkViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray<homework *> *homework_dataSource;///<describe
@end

@implementation homeworkViewController
static THIS_HOMEWORK_MESSAGE this_homework_message;
- (void)viewDidLoad {
    [super viewDidLoad];
    _homework_table.tableFooterView = [[UIView alloc] init];
    _homework_table.dataSource=self;
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _my_bar.topItem.title=select_class_cell.THIS_CLASS_NAME;
    [self initdata];
    [_homework_table reloadData];
}

#pragma mark -UITableView 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _homework_dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"this is homework tableview cell set");
    homeworkTableViewCell *select=[tableView cellForRowAtIndexPath:indexPath];
    select.homework_detail=select.detail.text;
    
}

//实现右滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        homeworkTableViewCell *this_cell_select=[tableView cellForRowAtIndexPath:indexPath];
        //alert to make sure user want to exit this class
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该班级吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              //delete from database in mysql
                              BOOL is_success_delete=[self url_to_delete_homework:this_cell_select.model.homework_id];
                              if(is_success_delete)
                              {
                                  ///< delete this rows
                                  [_homework_dataSource removeObjectAtIndex:indexPath.row];
                                  [_homework_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    return @"删除该班级";
}
-(BOOL)url_to_delete_homework:(NSString *)homework_id_to_delete
{
    BOOL is_success_delete=NO;
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/myhomework?operate=delete&user_id=%@&put_id=%@",this_user_.THIS_TEACHER_USER_ID,homework_id_to_delete]];
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
        alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"作业不存在" preferredStyle:UIAlertControllerStyleAlert];
        is_success_delete=NO;
    }
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [self presentViewController:alert animated:true completion:nil];
    NSLog(@"this is delete ");
    return is_success_delete;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeworkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homework_cell" forIndexPath:indexPath];
    cell.model=self.homework_dataSource[indexPath.row];
    return cell;
}

- (void)initdata
{
    _homework_dataSource =[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/myhomework?operate=select&user_id=%@&put_id=%@",this_user_.THIS_TEACHER_USER_ID,select_class_cell.THIS_CLASS_ID]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"该课程不存在作业"])
    {
        _homework_is_null.text=@"该班级暂无作业";
        _homework_dataSource=NULL;
    }
    else
    {
        _homework_is_null.text=@"";
        NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
        NSString *how_many_class=[array objectAtIndex:0];
        NSString *all_class_been_search=[array objectAtIndex:1];
        NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
        int rows=[how_many_class intValue];
        for(int i=0;i<rows;i++)
        {
            NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
            [self set_this_homework:every_class_all_message];///< class
            homework *p0 = [homework homeworkWithName:this_homework_message.THIS_HOMEWORK_ID class_id:this_homework_message.THIS_CLASS_ID class_name:select_class_cell.THIS_CLASS_NAME  course_name:select_class_cell.THIS_CLASS_NAME detail:this_homework_message.HOMEWORK_DETAIL end_time:this_homework_message.HOMEWORK_SUBMISSION_TIME];
            [_homework_dataSource addObject:p0];
        }
    }
}
-(void)set_this_homework:(NSString*) every_class_all_message
{
    //class_id class_name teacher_id
    NSArray *class_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_homework_message.THIS_HOMEWORK_ID=[class_detial objectAtIndex:0];
    this_homework_message.THIS_CLASS_ID=[class_detial objectAtIndex:1];
    select_class_cell.THIS_CLASS_COURSR_NAME=[class_detial objectAtIndex:3];
    this_homework_message.HOMEWORK_DETAIL=[class_detial objectAtIndex:6];
    this_homework_message.HOMEWORK_SUBMISSION_TIME=[class_detial objectAtIndex:7];
}

- (IBAction)back2class:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)add_homework:(id)sender {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入要添加的作业" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder=@"作业标题";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder=@"作业提交日期时间";
    }];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self setAdataPicker];
        UITextField *detail = alert.textFields.firstObject;
        UITextField *submission_time = alert.textFields.lastObject;
        [self add_homework_url:detail.text :submission_time.text];
        [self initdata];
        [_homework_table reloadData];
    }];
    UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_cancle];
    [alert addAction:Btn_yes];
    //
    //add this alert into the view
    //
    [self presentViewController:alert animated:true completion:nil];
}
-(void)add_homework_url:(NSString *)detail :(NSString *)submission_time
{
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/teacher_homework?operate=add&submission_time=%@&detail=%@&put_id=%@",submission_time,detail,select_class_cell.THIS_CLASS_ID]];
    NSData *data_student= [NSData dataWithContentsOfURL:url];
    NSString *return_text=[[NSString alloc]initWithData:data_student encoding:NSUTF8StringEncoding];
    NSArray *array = [return_text componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *is_success_add=[array objectAtIndex:1];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:is_success_add preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [self presentViewController:alert animated:true completion:nil];
}
-(void)setAdataPicker
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"作业提交日期时间" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //set datePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [alert.view addSubview:datePicker];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //实例化一个NSDateFormatter对象
        [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
        //求出当天的时间字符串
        NSLog(@"%@",dateString);
    }];
    UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_cancle];
    [alert addAction:Btn_yes];
    //
    //add this alert into the view
    //
    [self presentViewController:alert animated:true completion:nil];
}
@end
