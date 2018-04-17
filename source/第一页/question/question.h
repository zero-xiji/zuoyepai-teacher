//
//  question.h
//  作业派-教师端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface question : NSObject

@property NSString *question_id;
@property NSString *homework_id;
@property NSString *question_detail;
@property NSString *question_answer;
@property NSString *question_score;
@property NSString *question_type;

- (instancetype)initWithName:(NSString *)question_id
                 homework_id:(NSString *)homework_id
             question_detail:(NSString *)question_detail
             question_answer:(NSString *)question_answer
              question_score:(NSString *)question_score
               question_type:(NSString *)question_type;
+ (instancetype)question_in_homeworkWithName:(NSString *)question_id
                                 homework_id:(NSString *)homework_id
                             question_detail:(NSString *)question_detail
                             question_answer:(NSString *)question_answer
                              question_score:(NSString *)question_score
                               question_type:(NSString *)question_type;
@end
