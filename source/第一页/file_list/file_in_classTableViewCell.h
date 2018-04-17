//
//  file_in_classTableViewCell.h
//  作业派-学生端
//
//  Created by zerp on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "file_in_class.h"
#import "struct_user.h"
@interface file_in_classTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *file_type;
@property (weak, nonatomic) IBOutlet UILabel *file_name;
@property (weak, nonatomic) IBOutlet UILabel *who_upload;
@property (strong, nonatomic) file_in_class *model;
@property (copy, nonatomic) NSString *class_id;
@property (copy, nonatomic) NSString *class_name;
@property (copy, nonatomic) NSString *course_id;
@property (copy, nonatomic) NSString *course_name;
@property (copy, nonatomic) NSString *time_upload;
@property(nonatomic,weak) UIView *separatorView;
@property(nonatomic,strong) NSString *file_name_in_this_cell;
extern THIS_FILE_MESSAGE select_file_message;
@end
