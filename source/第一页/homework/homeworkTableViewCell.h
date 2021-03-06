//
//  homeworkTableViewCell.h
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homework.h"
@interface homeworkTableViewCell : UITableViewCell
@property (copy, nonatomic) NSString *class_name;
@property (strong, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *end_time;
@property (strong, nonatomic) IBOutlet UILabel *l_is_correcting;
@property (copy, nonatomic) NSString *homework_id;
@property (copy, nonatomic) NSString *class_id;
@property (copy, nonatomic) NSString *course_name;
@property (copy, nonatomic) NSString *is_issue;
@property(nonatomic,weak) UIView *separatorView;
@property (strong, nonatomic) homework *model;
@property(nonatomic,weak) NSString *class_id_in_this_cell;
@property(nonatomic,weak) NSString *homework_detail;
extern homework *select_homework_cell;

@end
