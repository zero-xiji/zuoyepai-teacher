//
//  student_in_class.m
//  作业派-教师端
//
//  Created by zero on 2018/4/16.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "student_in_class.h"

@implementation student_in_class

- (instancetype)initWithName:(NSString *)user_name
                     user_id:(NSString *)user_id
                    touxiang:(NSString *)touxiang
            homework_is_done:(NSString *)homework_is_done
                 school_name:(NSString *)school_name
              homework_score:(NSString *)homework_score
{
    self = [super init];
    if (self) {
        self.user_name = user_name;
        self.user_id=user_id;
        self.touxiang=touxiang;
        self.homework_is_done=homework_is_done;
        self.school_name=school_name;
        self.homework_score=homework_score;
    }
    return self;
}
+ (instancetype)student_in_classWithName:(NSString *)user_name
                                 user_id:(NSString *)user_id
                                touxiang:(NSString *)touxiang
                        homework_is_done:(NSString *)homework_is_done
                             school_name:(NSString *)school_name
                          homework_score:(NSString *)homework_score
{
    
    return [[student_in_class alloc] initWithName:user_name
                                          user_id:user_id
                                         touxiang:touxiang
                                 homework_is_done:homework_is_done
                                      school_name:school_name
                                   homework_score:homework_score];
}
@end
