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
@property (copy, nonatomic) NSString *is_issue;
@property (copy, nonatomic) NSString *student_homework_is_correcting;
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
- (instancetype)initWithName:(NSString *)student_homework_is_correcting;
+ (instancetype)homeworkIsCorrectWithName:(NSString *)student_homework_is_correcting;

@end
