//
//  questionViewController.h
//  作业派-教师端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import "ViewController.h"
#import "RadioButton.h"
@interface questionViewController : ViewController
@property (weak, nonatomic) IBOutlet UIPickerView *question_type_picker;
- (IBAction)add_question:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *question_detail;
@property (weak, nonatomic) IBOutlet UITextField *question_score;
@property (weak, nonatomic) IBOutlet UITextView *question_answer;
- (IBAction)back2questionTable:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *my_bar_item;

- (IBAction)btn_choice_A:(id)sender;
- (IBAction)btn_choice_B:(id)sender;
- (IBAction)btn_choice_C:(id)sender;
- (IBAction)btn_choice_D:(id)sender;

- (IBAction)btn_judge_yes:(id)sender;
- (IBAction)btn_judge_no:(id)sender;
@property (strong, nonatomic) IBOutlet RadioButton *btn_A;
@property (strong, nonatomic) IBOutlet RadioButton *btn_B;
@property (strong, nonatomic) IBOutlet RadioButton *btn_C;
@property (strong, nonatomic) IBOutlet RadioButton *btn_D;
@property (strong, nonatomic) IBOutlet RadioButton *btn_yes;
@property (strong, nonatomic) IBOutlet RadioButton *btn_no;

@end
