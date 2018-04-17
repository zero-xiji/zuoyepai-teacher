//
//  questionTableViewCell.h
//  作业派-教师端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "question.h"
@interface questionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *question_type;
@property (weak, nonatomic) IBOutlet UILabel *question_score;
@property (weak, nonatomic) IBOutlet UILabel *question_detail;
@property (weak, nonatomic) IBOutlet UILabel *question_answer;
@property NSString *question_id;
@property NSString *homework_id;
@property(nonatomic,weak) UIView *separatorView;
@property (strong, nonatomic) question *model;
@end
