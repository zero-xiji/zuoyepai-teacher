//
//  studentHomeworkTableViewCell.m
//  作业派-教师端
//
//  Created by zero on 2018/4/29.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "studentHomeworkTableViewCell.h"

@implementation studentHomeworkTableViewCell

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
        select_homework_cell = [homework homeworkWithName:_homework_id
                                                 class_id:_class_id
                                               class_name:_class_name
                                              course_name:_course_name
                                                   detail:_detail.text
                                                 end_time:_end_time.text
                                             is_time_over:_is_time_over
                                                 is_issue:_is_issue
                                                is_submit:_is_submit
                                            is_correcting:_is_correcting
                                            student_score:_student_score
                                                    score:_score];
        NSLog(@"homework_id = %@",select_homework_cell.homework_id);
    }
    else
    {
        
    }
    [super setHighlighted:highlighted animated:animated];
}
-(void)setModel:(homework *)model{
    _model = model;
    _class_name=model.class_name;
    _detail.text=model.detail;
    _end_time.text=model.end_time;
    if([model.is_submit isEqual:@"0"]  &&  model.is_time_over==NO)
    {
        _l_is_correcting.text=@"超时未提交";
        _l_is_correcting.textColor=[UIColor darkGrayColor];
    }
    else
    {
        if([model.is_correcting isEqualToString:@"0"])
        {
            _l_is_correcting.text=@"未批改";
            _l_is_correcting.textColor=[UIColor redColor];
        }
        if([model.is_correcting isEqualToString:@"1"])
        {
            _l_is_correcting.text=[NSString stringWithFormat:@"分数为：%@/%@",model.student_score,model.score];
            _l_is_correcting.textColor=[UIColor greenColor];
        }
    }
    self.homework_id=model.homework_id;
    self.class_id=model.class_id;
    self.course_name = model.course_name;
    self.is_time_over=model.is_time_over;
    self.is_issue=model.is_issue;
    self.is_submit=model.is_submit;
    self.is_correcting=model.is_correcting;
    self.score=model.score;
    self.student_score=model.student_score;
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
