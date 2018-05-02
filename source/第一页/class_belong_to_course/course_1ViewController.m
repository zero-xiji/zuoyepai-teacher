//
//  course_1ViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/作业派-教师端/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "course_1ViewController.h"
@interface course_1ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray<class_belong_to_course *> *class_belong_to_course_dataSource;///<describe
@end

@implementation course_1ViewController
static class_belong_to_course *this_class_message;
- (void)viewDidLoad {
    [super viewDidLoad];
    _this_class_belong_to_course_table.dataSource=self;
    _this_class_belong_to_course_table.delegate=self;
    _page=[NSUserDefaults standardUserDefaults];
    _this_class_belong_to_course_table.tableFooterView = [[UIView alloc] init];
    _this_class_belong_to_course_table.dataSource=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _my_bar.topItem.title=select_course_cell.course_name;
    [self initdata];
    [_this_class_belong_to_course_table reloadData];
    if(_class_belong_to_course_dataSource.count==0)
        _l_is_class_null.hidden=NO;
    else
        _l_is_class_null.hidden=YES;
}
- (void)initdata
{
    _class_belong_to_course_dataSource =[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/operate_class?operate=select_my_in_this_course&put_in=%@",select_course_cell.course_id]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *how_many_class=[array objectAtIndex:0];
    NSString *all_class_been_search=[array objectAtIndex:1];
    NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
    int rows=[how_many_class intValue];
    for(int i=0;i<rows;i++)
    {
        NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
        [self set_thisClass:every_class_all_message];///< class
        [_class_belong_to_course_dataSource addObject:this_class_message];
    }
}
-(void)set_thisClass:(NSString*) every_class_all_message
{
    //class_id class_name teacher_id
    NSArray *class_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_class_message= [class_belong_to_course classWithName:[class_detial objectAtIndex:5]
                                                   class_name:[class_detial objectAtIndex:3]
                                                    course_id:[class_detial objectAtIndex:6]
                                                  course_name:[class_detial objectAtIndex:2]
                                                   teacher_id:[class_detial objectAtIndex:8]
                                                 teacher_name:[class_detial objectAtIndex:0]
                                                  school_name:[class_detial objectAtIndex:1]
                                                   start_time:[class_detial objectAtIndex:4]
                                                count_student:[class_detial objectAtIndex:7]];
}


#pragma mark -UITableView 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==_this_class_belong_to_course_table)
        return 1;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_this_class_belong_to_course_table)
        return _class_belong_to_course_dataSource.count;
    return _class_belong_to_course_dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    class_belong_to_courseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_class_in_this_course_view" forIndexPath:indexPath];
    cell.model=self.class_belong_to_course_dataSource[indexPath.row];
    return cell;
}

//实现右滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        class_belong_to_courseTableViewCell *this_cell_select=[tableView cellForRowAtIndexPath:indexPath];
        //alert to make sure user want to exit this class
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该班级吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            //delete from database in mysql
            BOOL is_success_delete=[self url_to_exit:this_cell_select.model.class_id];
            if(is_success_delete)
            {
                ///< delete this rows
                [_class_belong_to_course_dataSource removeObjectAtIndex:indexPath.row];
                [_this_class_belong_to_course_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _this_class_belong_to_course_table)
    {
        return @"删除该班级";

    }
    return @"删除该班级";
}
-(BOOL)url_to_exit:(NSString *)class_id_to_exit
{
    BOOL is_success_delete=NO;
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/operate_class?operate=delete_class&put_in=%@",class_id_to_exit]];
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
        alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"课程不存在" preferredStyle:UIAlertControllerStyleAlert];
        is_success_delete=NO;
    }
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [self presentViewController:alert animated:true completion:nil];
    NSLog(@"this is delete ");
    return is_success_delete;
}

////send block to else
//-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"tableview didSelectRowAtIndexPath");
//    class_belong_to_courseTableViewCell *this_cell=[tableView cellForRowAtIndexPath:indexPath];
//    select_class_cell.THIS_COURSE_ID=this_cell.model.course_id;
//    select_class_cell.THIS_CLASS_ID=this_cell.class_id;
//    select_class_cell.THIS_CLASS_NAME=this_cell.class_name;
//    select_class_cell.THIS_CLASS_COURSR_NAME=this_cell.course_name;
//    return nil;
//}

- (IBAction)back2course:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)add_class:(id)sender {
    NSLog(@"add class");
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入要添加的班级名" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder=@"班级名称";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder=@"上课时间:时";
        textField.text=@"00";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder=@"上课时间:分";
        textField.text=@"00";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder=@"上课时间:秒";
        textField.text=@"00";
    }];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *class_name = alert.textFields.firstObject;
        NSString *start_time=[NSString stringWithFormat:@"%@%@%@",
                              alert.textFields[1].text,
                              alert.textFields[2].text,
                              alert.textFields[3].text];
        if([self is_end_time_just:alert.textFields[1].text
                           minute:alert.textFields[2].text
                           second:alert.textFields[3].text])
        {
            [self add_class_url:class_name.text :start_time];
            [self initdata];
            [_this_class_belong_to_course_table reloadData];
        }
        else
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"开始上课时间不合理！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:Btn_yes];
            [self presentViewController:alert animated:true completion:nil];
        }
    }];
    UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [alert addAction:Btn_cancle];

    //
    //add this alert into the view
    //
    [self presentViewController:alert animated:true completion:nil];
}
-(BOOL)is_end_time_just:(NSString *)hour minute:(NSString *)minute second:(NSString *)second
{
    BOOL is_just=NO;
    if(hour.intValue>=0 && hour.intValue<=24
       && minute.intValue >= 0 && minute.intValue <= 60
       && second.intValue >= 0 && second.intValue <= 60)
    {
        is_just=YES;
    }
    return is_just;
}
- (void)add_class_url:(NSString *)class_name_put_in :(NSString *)start_time_put_in
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/add_class?class_name=%@&course_id=%@&start_time=%@",
                           class_name_put_in,
                           select_course_cell.course_id,
                           start_time_put_in];
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
//    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/add_class?class_name=%@&course_id=%@&start_time=%@",
//                                      class_name_put_in,
//                                      select_course_cell.course_id,
//                                      start_time_put_in]];
    NSData *data_student= [NSData dataWithContentsOfURL:url];
    NSString *return_text=[[NSString alloc]initWithData:data_student encoding:NSUTF8StringEncoding];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    });
    NSArray *array = [return_text componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *is_success_add=[array objectAtIndex:1];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:is_success_add preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [self presentViewController:alert animated:true completion:nil];
}
@end
