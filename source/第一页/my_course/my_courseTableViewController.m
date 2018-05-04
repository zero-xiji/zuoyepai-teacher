//
//  my_courseTableViewController.m
//  3
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "my_courseTableViewController.h"
@interface my_courseTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray<my_course *> *dataSource;///<describe
@end

@implementation my_courseTableViewController
my_course *select_course_cell;
static my_course *this_course_message;
static UITableView *this_tableView;
static UIView *containerView;
static NSIndexPath *tableSelection;
static int is_first_appear;
static int tapCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    //only set the line when the cell is not null
    self.tableView.tableFooterView = [[UIView alloc] init];
    this_tableView=[[UITableView alloc] initWithFrame:self.tableView.frame];
    this_tableView.frame = self.tableView.bounds;
    is_first_appear=0;
    if(![this_user_.THIS_USER_IS_LOGIN isEqual:@"1"])
    {
        _btn_add.title=@"";
        NSLog(@"you are not login");
    }
    else
    {
        _btn_add.title=@"添加课程";
        [self initdata];
        self.tableView.dataSource=self;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    is_first_appear++;
    tapCount=0;
    if(is_first_appear>1)
    {
        if(![this_user_.THIS_USER_IS_LOGIN isEqual:@"1"])
        {
            NSLog(@"you are not login");
            _btn_add.title=@"";
            _dataSource=NULL;
            [self.tableView reloadData];
        }
        else
        {
            _btn_add.title=@"添加课程";
            [self initdata];
            [self.tableView reloadData];
        }
    }
}

- (void)initdata {
    _dataSource =[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/course?operate=select&user_id=%@&user_type=teacher",this_user_.THIS_TEACHER_USER_ID]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual:@"暂无课程，请添加"])
    {
        _dataSource=NULL;
    }
    else
    {
        NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
        NSString *how_many_class=[array objectAtIndex:0];
        NSString *all_class_been_search=[array objectAtIndex:1];
        NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
        int rows=[how_many_class intValue];
        for(int i=0;i<rows;i++)
        {
            NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
            [self set_thisClass:every_class_all_message];///< class
            [_dataSource addObject:this_course_message];
        }
    }
}
-(void)set_thisClass:(NSString*) every_class_all_message
{
    //class_id class_name teacher_id
    NSArray *class_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_course_message= [my_course my_courseWithName:[class_detial objectAtIndex:0]
                                          course_name:[class_detial objectAtIndex:1]
                                           class_rows:[class_detial objectAtIndex:2]];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    my_courseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_course" forIndexPath:indexPath];
    cell.model=self.dataSource[indexPath.row];
    return cell;
}
//实现右滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        my_courseTableViewCell *this_cell_select=(my_courseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        //alert to make sure user want to exit this class
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该课程及其对应班级吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              //delete from database in mysql
                              BOOL is_success_delete=[self url_to_delete_course:this_cell_select.model.course_name];
                              if(is_success_delete)
                              {
                                  ///< delete this rows
                                  [_dataSource removeObjectAtIndex:indexPath.row];
                                  [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    return @"删除该课程";
}
-(BOOL)url_to_delete_course:(NSString *)course_name_to_exit
{
    BOOL is_success_delete=NO;
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/course?operate=delete&user_id=%@&user_type=teacher&course_name=%@",this_user_.THIS_TEACHER_USER_ID,course_name_to_exit]];
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *is_delete =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
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
    return is_success_delete;
}

//send block to else
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    my_courseTableViewCell *this_cell=[tableView cellForRowAtIndexPath:indexPath];
    
    select_course_cell= [my_course my_courseWithName:this_cell.model.course_id
                                          course_name:this_cell.model.course_name
                                           class_rows:this_cell.how_many_class.text];
    tableSelection = indexPath;
    tapCount++;
    switch (tapCount)
    {
        case 1: //single tap
            [self performSelector:@selector(singleTap) withObject: nil afterDelay: .4];
            break;
        case 2: //double tap
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
            this_cell.selected=NO;
            [self performSelector:@selector(doubleTap) withObject: nil];
            break;
        default:
            break;
    }
}
- (void)singleTap
{
    tapCount = 0;
    NSLog(@"single tap");
}

- (void)doubleTap
{
    tapCount = 0;
    NSLog(@"double tap");
}
    
- (IBAction)btn_add_course:(id)sender {
    //set the alert
    if(![this_user_.THIS_USER_IS_LOGIN isEqual:@"1"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入要添加的课程" message:@"添加后无法修改课程名!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder=@"课程名";
        }];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            UITextField *add_course = alert.textFields.firstObject;
            NSLog(@"%@",add_course.text);
            [self add_course_url:add_course.text];
            [self initdata];
            [self.tableView reloadData];
        }];
        UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:Btn_yes];
        [alert addAction:Btn_cancle];

        //
        //add this alert into the view
        //
        [self presentViewController:alert animated:true completion:nil];
    }
}
- (void)add_course_url:(NSString *)course_put_in
{
    NSString *urlString=[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/course?operate=add&user_id=%@&user_type=teacher&course_name=%@",this_user_.THIS_TEACHER_USER_ID,course_put_in];
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
//    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/course?operate=add&user_id=%@&user_type=teacher&course_name=%@",this_user_.THIS_TEACHER_USER_ID,course_put_in]];
    NSLog(@"add_course_url = %@",url);
    NSData *data_student= [NSData dataWithContentsOfURL:url];
    NSString *return_text=[[NSString alloc]initWithData:data_student encoding:NSUTF8StringEncoding];
    NSLog(@"%@",return_text);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            });
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:return_text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [self presentViewController:alert animated:true completion:nil];
}
@end
