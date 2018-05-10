//
//  student_listViewController.h
//  作业派-教师端
//
//  Created by 王培俊 on 2018/4/10.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "studentListTableViewCell.h"
@interface student_listViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *student_table;
@property (strong, nonatomic) IBOutlet UILabel *student_is_null;
- (IBAction)back2class:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *my_bar_item;

@end
