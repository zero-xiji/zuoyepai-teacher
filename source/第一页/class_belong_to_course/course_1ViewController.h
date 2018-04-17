//
//  course_1ViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/作业派-教师端/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "ViewController.h"
#import "loginViewController.h"
#import "struct_user.h"
#import "my_courseTableViewController.h"
#import "class_belong_to_courseTableViewCell.h"
@interface course_1ViewController : ViewController
- (IBAction)back2course:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *my_bar;
@property NSUserDefaults *page;
- (IBAction)add_class:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *this_class_belong_to_course_table;
@property THIS_CLASS_MESSAGE *class_source;
@end
