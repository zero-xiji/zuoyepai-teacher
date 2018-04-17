//
//  my_course.m
//  作业派-教师端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "my_course.h"

@implementation my_course
- (instancetype)initWithName:(NSString *)course_id course_name:(NSString *)course_name class_rows:(NSString *)class_rows
{
    self = [super init];
    if (self) {
        self.course_id=course_id;
        self.course_name = course_name;
        self.class_rows=class_rows;
    }
    return self;
}
+ (instancetype)my_courseWithName:(NSString *)course_id course_name:(NSString *)course_name class_rows:(NSString *)class_rows
{
    return [[my_course alloc] initWithName:course_id course_name:course_name class_rows:class_rows];
}
@end
