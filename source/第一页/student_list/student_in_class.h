//
//  student_in_class.h
//  作业派-教师端
//
//  Created by zero on 2018/4/16.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface student_in_class : NSObject

@property NSString *user_id;
@property NSString *user_name;
@property NSString *touxiang;
@property NSString *homework_is_done;
@property NSString *school_name;
@property NSString *homework_score;
- (instancetype)initWithName:(NSString *)user_name
                     user_id:(NSString *)user_id
                    touxiang:(NSString *)touxiang
            homework_is_done:(NSString *)homework_is_done
                 school_name:(NSString *)school_name
              homework_score:(NSString *)homework_score;
+ (instancetype)student_in_classWithName:(NSString *)user_name
                              user_id:(NSString *)user_id
                             touxiang:(NSString *)touxiang
                     homework_is_done:(NSString *)homework_is_done
                          school_name:(NSString *)school_name
                       homework_score:(NSString *)homework_score;
@end
