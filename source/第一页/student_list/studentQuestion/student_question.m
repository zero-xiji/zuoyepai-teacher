//
//  student_question.m
//  作业派-教师端
//
//  Created by zero on 2018/4/18.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "student_question.h"

@implementation student_question

- (instancetype)initWithName:(NSString *)question_id
                 homework_id:(NSString *)homework_id
             question_detail:(NSString *)question_detail
             question_answer:(NSString *)question_answer
              question_score:(NSString *)question_score
               question_type:(NSString *)question_type
              student_answer:(NSString *)student_answer
               student_score:(NSString *)student_score
{
    self = [super init];
    if (self) {
        self.question_id = question_id;
        self.homework_id=homework_id;
        self.question_detail=question_detail;
        self.question_answer=question_answer;
        self.question_score=question_score;
        self.question_type=question_type;
        self.student_answer=student_answer;
        self.student_score=student_score;
    }
    return self;
    
}
+ (instancetype)question_in_homeworkWithName:(NSString *)question_id
                                 homework_id:(NSString *)homework_id
                             question_detail:(NSString *)question_detail
                             question_answer:(NSString *)question_answer
                              question_score:(NSString *)question_score
                               question_type:(NSString *)question_type
                              student_answer:(NSString *)student_answer
                               student_score:(NSString *)student_score
{
    return [[student_question alloc] initWithName:question_id
                                      homework_id:homework_id
                                  question_detail:question_detail
                                  question_answer:question_answer
                                   question_score:question_score
                                    question_type:question_type
                                   student_answer:student_answer
                                    student_score:student_score];
}
@end
