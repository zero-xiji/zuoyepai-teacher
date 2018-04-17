//
//  ViewController.m
//  作业派-教师端
//
//  Created by zero on 2018/2/2作业派-教师端.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *left=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doSwipe)];
    left.direction=UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:left];
    UISwipeGestureRecognizer *right=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doSwipe)];
    right.direction=UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:right];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)doSwipe:(UISwipeGestureRecognizer *)sender
{
    if(sender.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        UIImage *img = [UIImage imageNamed:@"1.png"];
        _imageView=[[UIImageView alloc] initWithImage:img];
    }
    else
    {
        UIImage *img = [UIImage imageNamed:@"0.png"];
        _imageView=[[UIImageView alloc] initWithImage:img];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
