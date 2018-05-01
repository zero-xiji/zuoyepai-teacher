//
//  class_belong_to_courseTableViewCell.m
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "class_belong_to_courseTableViewCell.h"

@implementation class_belong_to_courseTableViewCell
class_belong_to_course *select_class_cell;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //NSLog(@"setSelected");
    // Configure the view for the selected state
}

-(void)setModel:(class_belong_to_course *)model{
    _model = model;
    self.class_id=model.class_id;
    self.class_name.text=model.class_name;
    self.course_id=model.course_id;
    self.course_name = model.course_name;
    self.school_name=model.school_name;
    self.teacher_id=model.teacher_id;
    self.teacher_name=model.teacher_name;
    self.start_time.text=model.start_time;
    self.count_student.text=model.count_student;
    _class_id_in_this_cell=model.class_id;
}
//使用懒加载创建分割线view,保证一个cell只有一条
-(UIView *)separatorView
{
    if (_separatorView == nil) {
        UIView *separatorView = [[UIView alloc]init];
        self.separatorView = separatorView;
        separatorView.backgroundColor = [UIColor brownColor];
        [self addSubview:separatorView];
    }
    return _separatorView;
}

//重写layoutSubViews方法，设置位置及尺寸
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.separatorView.frame = CGRectMake(0, self.bounds.size.height-1,     self.bounds.size.width, 2);
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (highlighted == YES)
    {
        select_class_cell=[class_belong_to_course classWithName:_class_id
                                                     class_name:_class_name.text
                                                      course_id:_course_id
                                                    course_name:_course_name
                                                     teacher_id:_teacher_id
                                                   teacher_name:_teacher_name
                                                    school_name:_school_name
                                                     start_time:_start_time.text
                                                  count_student:_count_student.text];
        NSLog(@"class_id = %@",select_class_cell.class_id);
    }
    else
    {
        
    }
    [super setHighlighted:highlighted animated:animated];
}
@end
