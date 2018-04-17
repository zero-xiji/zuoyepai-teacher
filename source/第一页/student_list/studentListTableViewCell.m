//
//  studentListTableViewCell.m
//  作业派-教师端
//
//  Created by 王培俊 on 2018/4/10.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "studentListTableViewCell.h"

@implementation studentListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(student_in_class *)model{
//    select_user_message = model;
//    _student_id=model->THIS_STUDENT_USER_ID;
//    _student_name.text=model->THIS_STUDENT_USER_NAME;
//    _student_touxiang.image=[UIImage imageNamed:model->THIS_STUDENT_USER_TOUXIANG];
//    _school_name.text=model->THIS_USER_BOLONG_TO_SCHOOL_NAME;
//
//    if([model->THIS_HOMEWORK_IS_DONE isEqual:@"1"])
//    {
//        _is_done.text=model->THIS_HOMEWORK_SCORE;
//    }
//    else
//    {
//        _is_done.text=@"未提交";
//    }
    
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
/*
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (highlighted == YES)
    {
        select_student_cell.THIS_STUDENT_USER_ID=_user_id;
        select_student_cell.THIS_STUDENT_USER_NAME=_student_name.text;
        select_student_cell.THIS_USER_BOLONG_TO_SCHOOL_NAME=_school_name.text;
        NSLog(@"select_user_id = %@",select_student_cell.THIS_STUDENT_USER_ID);
    }
    else
    {
        
    }
    [super setHighlighted:highlighted animated:animated];
}*/
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
