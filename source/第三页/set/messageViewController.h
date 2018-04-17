//
//  messageViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/2/25.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "ViewController.h"

@interface messageViewController : ViewController
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label_isNull;
- (IBAction)add_message:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *message_view;
- (IBAction)add_course:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *my_course_view;
- (IBAction)add_my_course:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *course_view;
@property (weak, nonatomic) IBOutlet UITableView *course_table_view;

@property Boolean isNull;
@end
