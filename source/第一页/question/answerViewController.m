//
//  answerViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/4/19.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "answerViewController.h"
#import "MHRadioButton.h"
@interface answerViewController ()
@property UITextView *shortAnsertQuestion;
@property (nonatomic, strong) MHRadioButton *choiceA;
@property (nonatomic, strong) MHRadioButton *choiceB;
@property (nonatomic, strong) MHRadioButton *choiceC;
@property (nonatomic, strong) MHRadioButton *choiceD;
@end

@implementation answerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shortAnsertQuestion = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, self.view.bounds.size.width, 20)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)paramAnimated{
    [super viewWillAppear:paramAnimated];
    if([_questionType isEqualToString:@"1"])
    {
        [self.view addSubview:_shortAnsertQuestion];
    }
    else if([_questionType isEqualToString:@"2"])
    {
        [self.view addSubview:_shortAnsertQuestion];
    }
    else
    {
        [self.view addSubview:_shortAnsertQuestion];
    }
}

@end
