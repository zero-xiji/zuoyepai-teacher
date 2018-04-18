//
//  studentQuestionViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/4/18.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeworkViewController.h"
#import "studentQuestionTableViewCell.h"

@interface studentQuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *main_view;
@property (weak, nonatomic) IBOutlet UINavigationBar *my_bar;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *question_table;
@property (weak, nonatomic) IBOutlet UILabel *question_is_null;
@end
