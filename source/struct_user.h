//
//  struct_user.h
//  作业派-教师端
//
//  Created by zero on 2018/作业派-教师端/25.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef struct
{
    __unsafe_unretained NSString *THIS_TEACHER_USER_NAME;
    __unsafe_unretained NSString *THIS_TEACHER_USER_ID;
    __unsafe_unretained NSString *THIS_TEACHER_USER_PASSWORD;
    __unsafe_unretained NSString *THIS_TEACHER_USER_TOUXIANG;
    __unsafe_unretained NSString *THIS_USER_IS_LOGIN;
    __unsafe_unretained NSString *THIS_USER_BOLONG_TO_SCHOOL_ID;
    __unsafe_unretained NSString *THIS_USER_BOLONG_TO_SCHOOL_NAME;
}THIS_TEACHER_USER;
typedef struct
{
    __unsafe_unretained NSString *THIS_STUDENT_USER_ID;
    __unsafe_unretained NSString *THIS_STUDENT_USER_NAME;
    __unsafe_unretained NSString *THIS_STUDENT_USER_TOUXIANG;
    __unsafe_unretained NSString *THIS_HOMEWORK_IS_DONE;
    __unsafe_unretained NSString *THIS_USER_BOLONG_TO_SCHOOL_NAME;
    __unsafe_unretained NSString *THIS_HOMEWORK_SCORE;
}THIS_STUDENTS_IN_THIS_CLASS;
typedef struct
{
    __unsafe_unretained NSString *THIS_CLASS_ID;
    __unsafe_unretained NSString *THIS_CLASS_NAME;
    __unsafe_unretained NSString *THIS_TEACHER_USER_ID;
    __unsafe_unretained NSString *THIS_CLASS_TEACHER_NAME;
    __unsafe_unretained NSString *THIS_COURSE_ID;
    __unsafe_unretained NSString *THIS_CLASS_COURSR_NAME;
    __unsafe_unretained NSString *THIS_CLASS_START_TIME;
    __unsafe_unretained NSString *THIS_CLASS_SCHOOL_NAME;
    __unsafe_unretained NSString *COUNT_HOW_MANY_STUDENT;
}THIS_CLASS_MESSAGE;
typedef struct
{
    __unsafe_unretained NSString *THIS_COURSE_ID;
    __unsafe_unretained NSString *THIS_COURSR_NAME;
    __unsafe_unretained NSString *COUNT_HOW_MANY_CLASS;
}THIS_COURSE_MESSAGE;
typedef struct
{
    __unsafe_unretained NSString *THIS_CLASS_ID;
    __unsafe_unretained NSString *THIS_HOMEWORK_ID;
    __unsafe_unretained NSString *HOMEWORK_DETAIL;
    __unsafe_unretained NSString *HOMEWORK_SUBMISSION_TIME;
}THIS_HOMEWORK_MESSAGE;
typedef struct
{
    __unsafe_unretained NSString *THIS_FILE_ID;
    __unsafe_unretained NSString *THIS_FILE_NAME;
    __unsafe_unretained NSString *WHO_UPLOAD_THIS_FILE_ID;
    __unsafe_unretained NSString *WHO_UPLOAD_THIS_FILE_NAME;
}THIS_FILE_MESSAGE;
typedef struct
{
    __unsafe_unretained NSString *THIS_QUESTION_ID;
    __unsafe_unretained NSString *THIS_HOMEWORK_ID;
    __unsafe_unretained NSString *THIS_QUESTION_DETAIL;
    __unsafe_unretained NSString *THIS_QUESTION_ANSWER;
    __unsafe_unretained NSString *THIS_QUESTION_SCORE;
}THIS_QUESTION_MESSAGE;
@interface struct_user : NSObject
@property(nonatomic,retain)NSString *set_name;
@property(nonatomic,retain)NSString *set_this_password;
@property(nonatomic,retain)NSString *set_touxiang;

@end
