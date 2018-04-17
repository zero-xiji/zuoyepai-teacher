//
//  messageViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/2/25.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "ViewController.h"

@interface messageViewController : ViewController
- (IBAction)back:(id)sender;
- (IBAction)reset_password:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *message_view;
@property (weak, nonatomic) IBOutlet UIView *my_course_view;
@end
