//
//  class_belong_to_course.h
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface class_belong_to_course : NSObject
@property (copy, nonatomic) NSString *class_name;
@property (copy, nonatomic) NSString *course_name;
@property (copy, nonatomic) NSString *teacher_id;
@property (copy, nonatomic) NSString *teacher_name;
@property (copy, nonatomic) NSString *school_name;
@property (copy, nonatomic) NSString *start_time;
@property (copy, nonatomic) NSString *course_id;
@property (copy, nonatomic) NSString *class_id;
@property (copy, nonatomic) NSString *count_student;
- (instancetype)initWithName:(NSString *)class_id
                 class_name:(NSString *)class_name
                   course_id:(NSString *)course_id
                 course_name:(NSString *)course_name
                  teacher_id:(NSString *)teacher_id
                teacher_name:(NSString *)teacher_name
                 school_name:(NSString *)school_name
                  start_time:(NSString *)start_time
               count_student:(NSString *)count_student;
+ (instancetype)classWithName:(NSString *)class_id
                   class_name:(NSString *)class_name
                    course_id:(NSString *)course_id
                  course_name:(NSString *)course_name
                   teacher_id:(NSString *)teacher_id
                 teacher_name:(NSString *)teacher_name
                  school_name:(NSString *)school_name
                   start_time:(NSString *)start_time
                count_student:(NSString *)count_student;
@end
