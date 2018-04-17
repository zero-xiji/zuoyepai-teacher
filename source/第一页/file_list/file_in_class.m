//
//  file_in_class.m
//  作业派-学生端
//
//  Created by zerp on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "file_in_class.h"

@implementation file_in_class
- (instancetype)initWithName:(NSString *)file_name
                    class_id:(NSString *)class_id
                  class_name:(NSString *)class_name
                   course_id:(NSString *)course_id
                  who_upload:(NSString *)who_upload
                 time_upload:(NSString *)time_upload
{
    self = [super init];
    if (self) {
        self.file_name = file_name;
        self.class_id=class_id;
        self.class_name=class_name;
        self.course_id=course_id;
        self.who_upload=who_upload;
        self.time_upload=time_upload;
    }
    return self;
}
+ (instancetype)file_in_classWithName:(NSString *)file_name
                             class_id:(NSString *)class_id
                           class_name:(NSString *)class_name
                            course_id:(NSString *)course_id
                           who_upload:(NSString *)who_upload
                          time_upload:(NSString *)time_upload
{
    return [[file_in_class alloc] initWithName:file_name
                                      class_id:class_id
                                    class_name:class_name
                                     course_id:course_id
                                    who_upload:who_upload
                                   time_upload:time_upload];
}
@end
