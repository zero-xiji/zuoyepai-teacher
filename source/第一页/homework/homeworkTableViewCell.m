//
//  homeworkTableViewCell.m
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "homeworkTableViewCell.h"

@implementation homeworkTableViewCell
homework *select_homework_cell;
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
                                                  is_issue:_is_issue];
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
    self.homework_id=model.homework_id;
    self.class_id=model.class_id;
    self.course_name = model.course_name;
    self.is_issue=model.is_issue;
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
