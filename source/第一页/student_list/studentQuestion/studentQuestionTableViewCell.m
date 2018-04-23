//
//  studentQuestionTableViewCell.m
//  作业派-教师端
//
//  Created by zero on 2018/4/18.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "studentQuestionTableViewCell.h"

@implementation studentQuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

-(void)setModel:(student_question *)model{
    _model = model;
    _question_id=model.question_id;
    self.homework_id=model.homework_id;
    self.question_detail.text=model.question_detail;
    self.question_answer.text=model.question_answer;
    self.score=model.student_score;
    self.question_score.text=[NSString stringWithFormat:@"满分%@分",model.question_score];
    self.question_type=model.question_type;
    if([model.question_type isEqualToString:@"0"])
    {
        _l_question_type.text=@" 单选题 ";
    }
    else if([model.question_type isEqualToString:@"1"])
    {
        _l_question_type.text=@" 判断题 ";
    }
    else
    {
        _l_question_type.text=@" 填空／简答题 ";
    }
    self.student_my_answer.text=model.student_answer;
    self.student_score.text=[NSString stringWithFormat:@"%@分/",model.student_score];
    if(model.student_score!= model.question_score)
    {
        _student_score.textColor=[UIColor redColor];
    }
    else
    {
        _student_score.textColor=[UIColor greenColor];
    }
}
@end
