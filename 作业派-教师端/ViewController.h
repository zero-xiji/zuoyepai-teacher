//
//  ViewController.h
//  作业派-教师端
//
//  Created by zero on 2018/2/2作业派-教师端.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong)UIScrollView *lbScrollView;//显示引导页
@property (nonatomic,strong)UIImageView *lbImageView;//图片view
@property (nonatomic,strong)UIPageControl *lbPageControl;//显示当前处于第几个引导页，小圆点
@property (nonatomic,strong)UIButton *useButton;//进入应用的按钮
@property (nonatomic,copy)NSMutableArray *palyImageArray;//要现实引导页的图片数组

@end

