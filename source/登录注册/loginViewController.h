//
//  loginViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/2/2作业派-教师端.
//  Copyright © 2018年 zero. All rights reserved.
//
#import "user.h"
#import <UIKit/UIKit.h>
@interface loginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;//账号
@property (strong, nonatomic) IBOutlet UITextField *password;//密码
@property (strong, nonatomic) IBOutlet UIButton *btn_login;//登录
@property (strong, nonatomic) IBOutlet UIButton *btn_register;//注册
- (IBAction)is_login:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tips;
- (IBAction)turn2register:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *touxiang;
- (IBAction)back:(id)sender;
@property NSUserDefaults *page;
extern user *this_user_;
@end
