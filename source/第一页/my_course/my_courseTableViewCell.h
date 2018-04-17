//
//  my_courseTableViewCell.h
//  作业派-教师端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "my_course.h"
@interface my_courseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *course_name;
@property (weak, nonatomic) IBOutlet UILabel *how_many_class;
@property (strong, nonatomic) my_course *model;
@property(nonatomic,weak) UIView *separatorView;
@property(nonatomic,weak) NSString *course_id_in_this_cell;
@end
