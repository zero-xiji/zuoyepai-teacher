//
//  my_courseTableViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "my_courseTableViewCell.h"
#import "loginViewController.h"

@interface my_courseTableViewController : UITableViewController
- (IBAction)btn_add_course:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btn_add;

extern my_course *select_course_cell;
@end
