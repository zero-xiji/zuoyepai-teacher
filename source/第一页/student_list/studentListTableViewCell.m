//
//  studentListTableViewCell.m
//  作业派-教师端
//
//  Created by 王培俊 on 2018/4/10.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "studentListTableViewCell.h"

@implementation studentListTableViewCell
student_in_class *select_student_cell;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (highlighted == YES)
    {
        NSLog(@"this is cell click in studentListTableViewCell");
        select_student_cell=[student_in_class student_in_classWithName:_student_name.text
                                                               user_id:_user_id
                                                              touxiang:@"0"
                                                      homework_is_done:_is_done.text
                                                           school_name:_school_name.text
                                                        homework_score:_homework_score];
//        select_student_cell.user_id=_user_id;
//        select_student_cell.user_name=_student_name.text;
//        select_student_cell.touxiang=@"0";
//        select_student_cell.homework_is_done=_homework_is_done;
//        select_student_cell.school_name=_school_name.text;
//        select_student_cell.homework_score=_homework_score;
    }
    else
    {
    }
    [super setHighlighted:highlighted animated:animated];
}
-(void)setModel:(student_in_class *)model{
    _model = model;
    _user_id=model.user_id;
    _student_name.text=model.user_name;
    _student_touxiang.image=[UIImage imageNamed:model.touxiang];
    _school_name.text=model.school_name;
    if([model.homework_is_done isEqual:@"1"])
    {
        _is_done.text=model.homework_score;
    }
    else
    {
        _is_done.text=@"未提交";
    }
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
@end
