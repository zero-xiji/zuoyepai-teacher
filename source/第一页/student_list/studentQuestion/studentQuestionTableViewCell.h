//
//  studentQuestionTableViewCell.h
//  作业派-教师端
//
//  Created by zero on 2018/4/18.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "student_question.h"
@interface studentQuestionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *question_type;
@property (weak, nonatomic) IBOutlet UILabel *question_score;
@property (weak, nonatomic) IBOutlet UILabel *question_detail;
@property (weak, nonatomic) IBOutlet UILabel *question_answer;
@property (strong, nonatomic) IBOutlet UITextField *my_score;
@property (strong, nonatomic) IBOutlet UILabel *student_my_answer;
@property (strong, nonatomic) IBOutlet UILabel *student_score;
@property NSString *question_id;
@property NSString *homework_id;
@property(nonatomic,weak) UIView *separatorView;
@property (strong, nonatomic) student_question *model;

@end
