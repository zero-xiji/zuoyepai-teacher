//
//  class_belong_to_course.m
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "class_belong_to_course.h"

@implementation class_belong_to_course
- (instancetype)initWithName:(NSString *)class_id
                  class_name:(NSString *)class_name
                   course_id:(NSString *)course_id
                 course_name:(NSString *)course_name
                  teacher_id:(NSString *)teacher_id
                teacher_name:(NSString *)teacher_name
                 school_name:(NSString *)school_name
                  start_time:(NSString *)start_time
               count_student:(NSString *)count_student
{
    self = [super init];
    if (self) {
        self.class_id=class_id;
        self.class_name=class_name;
        self.course_id=course_id;
        self.course_name = course_name;
        self.school_name=school_name;
        self.teacher_id=teacher_id;
        self.teacher_name=teacher_name;
        self.start_time=start_time;
        self.count_student=count_student;
    }
    return self;
}
+ (instancetype)classWithName:(NSString *)class_id
                   class_name:(NSString *)class_name
                    course_id:(NSString *)course_id
                  course_name:(NSString *)course_name
                   teacher_id:(NSString *)teacher_id
                 teacher_name:(NSString *)teacher_name
                  school_name:(NSString *)school_name
                   start_time:(NSString *)start_time
                count_student:(NSString *)count_student
{
    return [[class_belong_to_course alloc] initWithName:class_id
                                             class_name:class_name
                                              course_id:course_id
                                            course_name:course_name
                                             teacher_id:teacher_id
                                           teacher_name:teacher_name
                                            school_name:school_name
                                             start_time:start_time
                                          count_student:count_student];
}
@end
