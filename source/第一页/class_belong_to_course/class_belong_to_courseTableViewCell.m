//
//  class_belong_to_courseTableViewCell.m
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "class_belong_to_courseTableViewCell.h"

@implementation class_belong_to_courseTableViewCell
THIS_CLASS_MESSAGE select_class_cell;
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
        select_class_cell.THIS_CLASS_ID=_class_id;
        select_class_cell.THIS_CLASS_NAME=_class_name.text;
        select_class_cell.THIS_COURSE_ID=_course_id;
        select_class_cell.THIS_CLASS_COURSR_NAME=_course_name;
        select_class_cell.THIS_CLASS_START_TIME=_start_time.text;
        select_class_cell.COUNT_HOW_MANY_STUDENT=_count_student.text;
        select_class_cell.THIS_CLASS_SCHOOL_NAME=_school_name;
        select_class_cell.THIS_TEACHER_USER_ID=_teacher_id;
        select_class_cell.THIS_CLASS_TEACHER_NAME=_teacher_name;
        NSLog(@"class_id = %@",select_class_cell.THIS_CLASS_ID);
    }
    else
    {
        
    }
    [super setHighlighted:highlighted animated:animated];
}
@end
