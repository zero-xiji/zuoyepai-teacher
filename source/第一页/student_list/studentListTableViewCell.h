//
//  studentListTableViewCell.h
//  作业派-教师端
//
//  Created by 王培俊 on 2018/4/10.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "struct_user.h"
#import "student_in_class.h"
@interface studentListTableViewCell : UITableViewCell
@property(nonatomic,weak) UIView *separatorView;
@property(nonatomic,strong) NSString *file_name_in_this_cell;
@property (strong, nonatomic) IBOutlet UILabel *student_name;
@property (strong, nonatomic) IBOutlet UILabel *school_name;
@property (strong, nonatomic) IBOutlet UIImageView *student_touxiang;
@property (strong, nonatomic) IBOutlet UILabel *is_done;
@property NSString *user_id;
@property NSString *homework_is_done;
@property NSString *homework_score;
@property (strong, nonatomic) student_in_class *model;
extern student_in_class *select_student_cell;
@end
