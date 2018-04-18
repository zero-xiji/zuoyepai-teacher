//
//  homeworkTableViewCell.m
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "homeworkTableViewCell.h"

@implementation homeworkTableViewCell
THIS_HOMEWORK_MESSAGE select_homework_cell;
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
        select_homework_cell.THIS_CLASS_ID=_class_id;
        select_homework_cell.THIS_HOMEWORK_ID=_homework_id;
        select_homework_cell.HOMEWORK_DETAIL=_homework_detail;
        select_homework_cell.HOMEWORK_SUBMISSION_TIME=_end_time.text;
        NSLog(@"homework_id = %@",select_homework_cell.THIS_HOMEWORK_ID);
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
