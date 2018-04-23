//
//  homework.m
//  作业派-教师端
//
//  Created by zero on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "homework.h"

@implementation homework
- (instancetype)initWithName:(NSString *)homework_id
                    class_id:(NSString *)class_id
                  class_name:(NSString *)class_name
                 course_name:(NSString *)course_name
                      detail:(NSString *)detail
                    end_time:(NSString *)end_time
                    is_issue:(NSString *)is_issue
{
    self = [super init];
    if (self) {
        self.homework_id=homework_id;
        self.class_id=class_id;
        self.class_name=class_name;
        self.course_name = course_name;
        self.detail=detail;
        self.end_time=end_time;
        self.is_issue=is_issue;
    }
    return self;
}
+ (instancetype)homeworkWithName:(NSString *)homework_id
                        class_id:(NSString *)class_id
                      class_name:(NSString *)class_name
                     course_name:(NSString *)course_name
                          detail:(NSString *)detail
                        end_time:(NSString *)end_time
                        is_issue:(NSString *)is_issue
{
    return [[homework alloc] initWithName:homework_id
                                 class_id:class_id
                               class_name:class_name
                              course_name:course_name
                                   detail:detail
                                 end_time:end_time
                                 is_issue:is_issue];
}
- (instancetype)initWithName:(NSString *)student_homework_is_correcting
{
    self = [super init];
    if (self) {
        self.homework_id=self.homework_id;
        self.class_id=self.class_id;
        self.class_name=self.class_name;
        self.course_name = self.course_name;
        self.detail=self.detail;
        self.end_time=self.end_time;
        self.is_issue=self.is_issue;
        self.student_homework_is_correcting=student_homework_is_correcting;
    }
    return self;
}
+ (instancetype)homeworkIsCorrectWithName:(NSString *)student_homework_is_correcting
{
    return [[homework alloc] initWithName:student_homework_is_correcting];
}

@end
