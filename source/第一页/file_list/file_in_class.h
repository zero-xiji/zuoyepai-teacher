//
//  file_in_class.h
//  作业派-学生端
//
//  Created by zerp on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface file_in_class : NSObject
@property (copy, nonatomic) NSString *class_id;
@property (copy, nonatomic) NSString *class_name;
@property (copy, nonatomic) NSString *course_id;
@property (copy, nonatomic) NSString *course_name;
@property (copy, nonatomic) NSString *file_name;
@property (copy, nonatomic) NSString *who_upload;
@property (copy, nonatomic) NSString *time_upload;
- (instancetype)initWithName:(NSString *)file_name
                    class_id:(NSString *)class_id
                  class_name:(NSString *)class_name
                   course_id:(NSString *)course_id
                  who_upload:(NSString *)who_upload
                 time_upload:(NSString *)time_upload;
+ (instancetype)file_in_classWithName:(NSString *)file_name
                             class_id:(NSString *)class_id
                           class_name:(NSString *)class_name
                            course_id:(NSString *)course_id
                           who_upload:(NSString *)who_upload
                          time_upload:(NSString *)time_upload;
@end
