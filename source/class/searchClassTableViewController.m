//
//  searchClassTableViewController.m
//  3
//
//  Created by 王培俊 on 2018/4/3.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "searchClassTableViewController.h"
#import "loginViewController.h"

@interface searchClassTableViewController ()<UISearchResultsUpdating>

@end

@implementation searchClassTableViewController
THIS_CLASS_MESSAGE this_class_message_search;
int search_rows;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self search_from_url];
    [self initdata];

    //添加手势，为了关闭键盘的操作
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击空白处的手势要实现的方法
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
}

- (void)initdata {
    _dataSource =[NSMutableArray new];
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select_class?put_in=%@",_search_putin]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *how_many_class=[array objectAtIndex:0];
    NSString *all_class_been_search=[array objectAtIndex:1];
    NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
    search_rows =[how_many_class intValue];
    for(int i=0;i<search_rows;i++)
    {
        NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
        [self set_thisClass:every_class_all_message];///< class
        class_message *p0 = [class_message classWithName:this_class_message_search.THIS_CLASS_NAME course_name:this_class_message_search.THIS_CLASS_COURSR_NAME teacher_name:this_class_message_search.THIS_CLASS_TEACHER_NAME school_name:this_class_message_search.THIS_CLASS_TEACHER_NAME start_time:this_class_message_search.THIS_CLASS_START_TIME course_id:@"4"];
        [_dataSource addObject:p0];
    }
}
-(void)set_thisClass:(NSString*) every_class_all_message
{
    NSArray *class_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_class_message_search.THIS_CLASS_TEACHER_NAME=[class_detial objectAtIndex:0];
    this_class_message_search.THIS_CLASS_SCHOOL_NAME=[class_detial objectAtIndex:1];
    this_class_message_search.THIS_CLASS_COURSR_NAME=[class_detial objectAtIndex:2];
    this_class_message_search.THIS_CLASS_NAME=[class_detial objectAtIndex:3];
    this_class_message_search.THIS_CLASS_START_TIME=[class_detial objectAtIndex:4];
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"搜索教师名／课程名／学校名";
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil] forState:UIControlStateFocused];//设置取消键的颜色
        [_searchController.searchBar sizeToFit];
    }
    _search_putin=@"";
    return _searchController;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    classTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_class" forIndexPath:indexPath];
    
    cell.model=self.dataSource[indexPath.row];
    
    for(int i=0;i<_dataSource.count;i++)
    {
        
    }
    // Configure the cell...
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return _searchController.searchBar;
//}
#pragma mark - UISearchDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}
//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchController.searchBar.text=@"";
    [_searchController.searchBar setShowsCancelButton:NO animated:YES]; // 隐藏取消按钮
    //点击取消按钮调用结束编辑方法需要让加上这句代码
    [_searchController.searchBar resignFirstResponder];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [_searchController.searchBar setShowsCancelButton:YES animated:YES]; // 动画效果显示取消按钮
    //修改取消按钮
    UIButton *cancleBtn = [_searchController.searchBar valueForKey:@"cancelButton"];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:_searchController.searchBar];
    if(search_rows==0)
    {
        [self initdata];
    }
    else
    {
        NSArray *class_message=[[self search_from_url] componentsSeparatedByString:@"%"];
        for(int i=0;i<search_rows;i++)
        {
            NSString *every_class_all_message=[class_message objectAtIndex:i];
            [self set_thisClass:every_class_all_message];///< class_message
            [self initdata];
            [self.tableView reloadData];
            
            NSLog(@"every_class_all_message = %@\n",every_class_all_message);
            NSLog(@"teacher name = %@\n",this_class_message_search.THIS_CLASS_TEACHER_NAME);
            NSLog(@"school name = %@\n",this_class_message_search.THIS_CLASS_SCHOOL_NAME);
            NSLog(@"course name = %@\n",this_class_message_search.THIS_CLASS_COURSR_NAME);
            NSLog(@"class_message name = %@\n",this_class_message_search.THIS_CLASS_NAME);
            NSLog(@"class_message start time = %@\n",this_class_message_search.THIS_CLASS_START_TIME);
        }
    }
}
-(NSString *)search_from_url
{
    _search_putin=_searchController.searchBar.text;
    NSLog(@"搜索对象：%@",_search_putin);
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select_class?put_in=%@",_search_putin]];
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *how_many_class=[array objectAtIndex:0];
    NSString *class1=[array objectAtIndex:1];
    search_rows=[how_many_class intValue];
    return class1;
}
-(void)viewWillDisappear:(BOOL)animated
{
    _searchController.searchBar.text=@"";
    [_searchController.searchBar setShowsCancelButton:NO animated:YES]; // 隐藏取消按钮
}
@end
