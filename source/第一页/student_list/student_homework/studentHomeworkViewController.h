//
//  studentHomeworkViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/4/23.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"
#import "struct_user.h"
#import "course_1ViewController.h"
#import "homeworkTableViewCell.h"
@interface studentHomeworkViewController : UIViewController
- (IBAction)back2class:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *student_homework_table;
@property (weak, nonatomic) IBOutlet UINavigationBar *my_bar;
@property (weak, nonatomic) IBOutlet UILabel *student_homework_is_null;

@end
