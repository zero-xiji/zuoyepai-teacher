//
//  questionViewController.h
//  作业派-教师端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import "ViewController.h"

@interface questionViewController : ViewController
@property (weak, nonatomic) IBOutlet UIPickerView *question_type_picker;
- (IBAction)add_question:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *question_detail;
@property (weak, nonatomic) IBOutlet UITextField *question_score;
@property (weak, nonatomic) IBOutlet UITextView *question_answer;
- (IBAction)back2questionTable:(id)sender;

@end
