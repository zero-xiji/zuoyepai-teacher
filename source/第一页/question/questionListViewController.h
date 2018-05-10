//
//  questionListViewController.h
//  作业派-学生端
//
//  Created by zero on 2018/4/7.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeworkViewController.h"
#import "questionTableViewCell.h"
#import "questionViewController.h"

@interface questionListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *main_view;
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *my_bar_item;
@property (weak, nonatomic) IBOutlet UITableView *question_table;
@property (weak, nonatomic) IBOutlet UILabel *question_is_null;
- (IBAction)issue_homework:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btn_add_question;
@property (strong, nonatomic) IBOutlet UIButton *btn_issue_homework;
- (IBAction)btn_add_question_prause:(id)sender;
extern question *select_question_cell;
extern int select_type;
@end
