//
//  user.h
//  作业派-教师端
//
//  Created by zero on 2018/4/17.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface user : NSObject
@property NSString *THIS_TEACHER_USER_NAME;
@property NSString *THIS_TEACHER_USER_ID;
@property NSString *THIS_TEACHER_USER_PASSWORD;
@property NSString *THIS_TEACHER_USER_TOUXIANG;
@property NSString *THIS_USER_IS_LOGIN;
@property NSString *THIS_USER_BOLONG_TO_SCHOOL_ID;
@property NSString *THIS_USER_BOLONG_TO_SCHOOL_NAME;

- (instancetype)initWithName:(NSString *)THIS_TEACHER_USER_NAME
        THIS_TEACHER_USER_ID:(NSString *)THIS_TEACHER_USER_ID
  THIS_TEACHER_USER_PASSWORD:(NSString *)THIS_TEACHER_USER_PASSWORD
  THIS_TEACHER_USER_TOUXIANG:(NSString *)THIS_TEACHER_USER_TOUXIANG
          THIS_USER_IS_LOGIN:(NSString *)THIS_USER_IS_LOGIN
THIS_USER_BOLONG_TO_SCHOOL_ID:(NSString *)THIS_USER_BOLONG_TO_SCHOOL_ID
THIS_USER_BOLONG_TO_SCHOOL_NAME:(NSString *)THIS_USER_BOLONG_TO_SCHOOL_NAME;
+ (instancetype)UserWithName:(NSString *)THIS_TEACHER_USER_NAME
                    THIS_TEACHER_USER_ID:(NSString *)THIS_TEACHER_USER_ID
              THIS_TEACHER_USER_PASSWORD:(NSString *)THIS_TEACHER_USER_PASSWORD
              THIS_TEACHER_USER_TOUXIANG:(NSString *)THIS_TEACHER_USER_TOUXIANG
                      THIS_USER_IS_LOGIN:(NSString *)THIS_USER_IS_LOGIN
           THIS_USER_BOLONG_TO_SCHOOL_ID:(NSString *)THIS_USER_BOLONG_TO_SCHOOL_ID
         THIS_USER_BOLONG_TO_SCHOOL_NAME:(NSString *)THIS_USER_BOLONG_TO_SCHOOL_NAME;
@end
