//
//  student_listViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/4/10.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "student_listViewController.h"
#import "course_1ViewController.h"
@interface student_listViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray<student_in_class *> *student_dataSource;///<describe

@end

@implementation student_listViewController
static THIS_STUDENTS_IN_THIS_CLASS this_student_message;

- (void)viewDidLoad {
    [super viewDidLoad];
    _student_table.tableFooterView = [[UIView alloc] init];
    _student_table.dataSource=self;
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
    [_student_table reloadData];
}


- (void)initdata
{
    _student_dataSource =[NSMutableArray new];
    
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/students_in_class?class_id=%@",select_class_cell.THIS_CLASS_ID];
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
//    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/students_in_class?class_id=%@",select_class_cell.THIS_CLASS_ID]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"课程无学生!"])
    {
        _student_is_null.text=@"该班级暂无学生";
        _student_dataSource=NULL;
    }
    else
    {
        _student_is_null.text=@"";
        NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
        NSString *how_many_student=[array objectAtIndex:0];
        NSString *all_class_been_search=[array objectAtIndex:1];
        NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
        int rows=[how_many_student intValue];
        for(int i=0;i<rows;i++)
        {
            NSString *every_student_all_message=[class_in_one_row objectAtIndex:i];
            [self set_this_student:every_student_all_message];///< class
            student_in_class *p0 = [student_in_class student_in_classWithName:this_student_message.THIS_STUDENT_USER_NAME user_id:this_student_message.THIS_STUDENT_USER_ID touxiang:this_student_message.THIS_STUDENT_USER_TOUXIANG homework_is_done:this_student_message.THIS_HOMEWORK_IS_DONE school_name:this_student_message.THIS_USER_BOLONG_TO_SCHOOL_NAME   homework_score:this_student_message.THIS_HOMEWORK_SCORE];
            [_student_dataSource addObject:p0];
        }
    }
}
-(void)set_this_student:(NSString*) every_student_all_message
{
    NSArray *student_detial=[every_student_all_message componentsSeparatedByString:@"*"];
    this_student_message.THIS_STUDENT_USER_NAME=[student_detial objectAtIndex:0];
    this_student_message.THIS_STUDENT_USER_TOUXIANG=[student_detial objectAtIndex:1];
    this_student_message.THIS_HOMEWORK_IS_DONE=[student_detial objectAtIndex:2];
    this_student_message.THIS_HOMEWORK_SCORE=[student_detial objectAtIndex:3];
    this_student_message.THIS_STUDENT_USER_ID=[student_detial objectAtIndex:4];
    this_student_message.THIS_USER_BOLONG_TO_SCHOOL_NAME=[student_detial objectAtIndex:6];
}


- (IBAction)back2class:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UITableView 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _student_dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"this is student tableview cell set");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    studentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"student_cell" forIndexPath:indexPath];
    cell.model=self.student_dataSource[indexPath.row];
    return cell;
}
//实现右滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        studentListTableViewCell *this_cell_select=[tableView cellForRowAtIndexPath:indexPath];
        //alert to make sure user want to exit this class
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该学生吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              //delete from database in mysql
                              BOOL is_success_delete=[self url_to_delete_student:this_cell_select.model.user_id];
                              if(is_success_delete)
                              {
                                  ///< delete this rows
                                  [_student_dataSource removeObjectAtIndex:indexPath.row];
                                  [_student_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
/*


*/
@end
