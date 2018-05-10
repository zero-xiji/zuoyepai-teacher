//
//  questionListViewController.h
//  作业派-学生端
//
//  Created by 王培俊 on 2018/4/10.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"
#import "course_1ViewController.h"
#import "homeworkTableViewCell.h"
#import "file_in_classTableViewCell.h"
@interface file2ViewController : UIViewController
- (IBAction)back2class:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *file_table;
@property (weak, nonatomic) IBOutlet UILabel *file_in_class_is_null;
@property (strong, nonatomic) IBOutlet UINavigationItem *my_bar_item;
@end
