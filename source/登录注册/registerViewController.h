//
//  registerViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/2/2作业派-教师端.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerViewController : UIViewController
@property NSString *now_touxiang;
@property (strong, nonatomic) IBOutlet UIImageView *touxiang;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *password2;
@property (strong, nonatomic) IBOutlet UITextField *school;
@property (strong, nonatomic) IBOutlet UILabel *tips;
- (IBAction)back:(id)sender;
- (IBAction)is_register:(id)sender;
- (IBAction)return2login:(id)sender;
- (IBAction)change_touxiang:(id)sender;

@end
