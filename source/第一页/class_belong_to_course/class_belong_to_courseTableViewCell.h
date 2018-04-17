//
//  class_belong_to_courseTableViewCell.h
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "class_belong_to_course.h"
#import "struct_user.h"
@interface class_belong_to_courseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *file_type;
@property (weak, nonatomic) IBOutlet UILabel *class_name;
@property (weak, nonatomic) IBOutlet UILabel *count_student;
@property (weak, nonatomic) IBOutlet UILabel *start_time;
@property (copy, nonatomic) NSString *course_name;
@property (copy, nonatomic) NSString *teacher_id;
@property (copy, nonatomic) NSString *teacher_name;
@property (copy, nonatomic) NSString *school_name;
@property (copy, nonatomic) NSString *course_id;
@property (copy, nonatomic) NSString *class_id;
@property(nonatomic,weak) UIView *separatorView;
@property(nonatomic,weak) NSString *class_id_in_this_cell;
@property (strong, nonatomic) class_belong_to_course *model;
extern THIS_CLASS_MESSAGE select_class_cell;
@end
