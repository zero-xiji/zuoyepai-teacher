//
//  homework.h
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homework : NSObject

@property (copy, nonatomic) NSString *homework_id;
@property (copy, nonatomic) NSString *class_id;
@property (copy, nonatomic) NSString *class_name;
@property (copy, nonatomic) NSString *course_name;
@property (copy, nonatomic) NSString *detail;
@property (copy, nonatomic) NSString *end_time;
@property BOOL is_time_over;
@property (copy, nonatomic) NSString *is_issue;
@property (copy, nonatomic) NSString *is_submit;
@property (copy, nonatomic) NSString *is_correcting;
@property (copy, nonatomic) NSString *score;
@property (copy, nonatomic) NSString *student_score;
- (instancetype)initWithName:(NSString *)homework_id
                    class_id:(NSString *)class_id
                  class_name:(NSString *)class_name
                 course_name:(NSString *)course_name
                      detail:(NSString *)detail
                    end_time:(NSString *)end_time
                    is_issue:(NSString *)is_issue;
+ (instancetype)homeworkWithName:(NSString *)homework_id
                        class_id:(NSString *)class_id
                      class_name:(NSString *)class_name
                     course_name:(NSString *)course_name
                          detail:(NSString *)detail
                        end_time:(NSString *)end_time
                        is_issue:(NSString *)is_issue;

- (instancetype)initWithName:(NSString *)homework_id
                    class_id:(NSString *)class_id
                  class_name:(NSString *)class_name
                 course_name:(NSString *)course_name
                      detail:(NSString *)detail
                    end_time:(NSString *)end_time
                is_time_over:(BOOL)is_time_over
                    is_issue:(NSString *)is_issue
                   is_submit:(NSString *)is_submit
               is_correcting:(NSString *)is_correcting
               student_score:(NSString *)student_score
                       score:(NSString *)score;

+ (instancetype)homeworkWithName:(NSString *)homework_id
                        class_id:(NSString *)class_id
                      class_name:(NSString *)class_name
                     course_name:(NSString *)course_name
                          detail:(NSString *)detail
                        end_time:(NSString *)end_time
                    is_time_over:(BOOL)is_time_over
                        is_issue:(NSString *)is_issue
                       is_submit:(NSString *)is_submit
                   is_correcting:(NSString *)is_correcting
                   student_score:(NSString *)student_score
                           score:(NSString *)score;



//is_correcting:(NSString *)is_correcting;
@end
