//
//  course_1ViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/作业派-教师端/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "ViewController.h"
#import "loginViewController.h"
#import "my_courseTableViewController.h"
#import "class_belong_to_courseTableViewCell.h"
@interface course_1ViewController : ViewController
- (IBAction)back2course:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *my_bar_item;
@property NSUserDefaults *page;
@property (strong, nonatomic) IBOutlet UILabel *l_is_class_null;
- (IBAction)add_class:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *this_class_belong_to_course_table;
@property class_belong_to_course *class_source;
@end
