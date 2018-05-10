//
//  homeworkViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/4/6.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"
#import "course_1ViewController.h"
#import "homeworkTableViewCell.h"
@interface homeworkViewController : UIViewController
- (IBAction)back2class:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *homework_table;
@property (strong, nonatomic) IBOutlet UINavigationItem *my_bar_item;
- (IBAction)add_homework:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *homework_is_null;

@end
