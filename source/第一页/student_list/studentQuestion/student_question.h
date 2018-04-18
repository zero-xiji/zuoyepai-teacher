//
//  student_question.h
//  作业派-教师端
//
//  Created by zero on 2018/4/18.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface student_question : NSObject

@property NSString *question_id;
@property NSString *homework_id;
@property NSString *question_detail;
@property NSString *question_answer;
@property NSString *question_score;
@property NSString *question_type;
@property NSString *student_answer;
@property NSString *student_score;

- (instancetype)initWithName:(NSString *)question_id
                 homework_id:(NSString *)homework_id
             question_detail:(NSString *)question_detail
             question_answer:(NSString *)question_answer
              question_score:(NSString *)question_score
               question_type:(NSString *)question_type
              student_answer:(NSString *)student_answer
               student_score:(NSString *)student_score;
+ (instancetype)question_in_homeworkWithName:(NSString *)question_id
                                 homework_id:(NSString *)homework_id
                             question_detail:(NSString *)question_detail
                             question_answer:(NSString *)question_answer
                              question_score:(NSString *)question_score
                               question_type:(NSString *)question_type
                              student_answer:(NSString *)student_answer
                               student_score:(NSString *)student_score;
@end
