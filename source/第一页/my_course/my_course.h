//
//  my_course.h
//  作业派-教师端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface my_course : NSObject
@property (copy, nonatomic) NSString *course_id;
@property (copy, nonatomic) NSString *course_name;
@property (copy, nonatomic) NSString *class_rows;
- (instancetype)initWithName:(NSString *)course_id
                 course_name:(NSString *)course_name
                  class_rows:(NSString *)class_rows;
+ (instancetype)my_courseWithName:(NSString *)course_id
                      course_name:(NSString *)course_name
                       class_rows:(NSString *)class_rows;
@end
