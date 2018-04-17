//
//  searchClassTableViewController.h
//  3
//
//  Created by 王培俊 on 2018/4/3.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classTableViewCell.h"
@interface searchClassTableViewController : UITableViewController
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *dataSource;/**<排序前的整个数据源*/
@property NSString *search_putin;

@end
