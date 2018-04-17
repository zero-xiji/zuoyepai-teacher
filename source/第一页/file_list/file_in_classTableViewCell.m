//
//  file_in_classTableViewCell.m
//  作业派-学生端
//
//  Created by zerp on 2018/4/5.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "file_in_classTableViewCell.h"

@implementation file_in_classTableViewCell
 THIS_FILE_MESSAGE select_file_message;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (highlighted == YES)
    {
        NSLog(@"this is cell click in file_in_classTableView");
        _file_name_in_this_cell=_file_name.text;
//        select_file_message.THIS_FILE_ID=_
        select_file_message.THIS_FILE_NAME=_file_name.text;
        select_file_message.WHO_UPLOAD_THIS_FILE_NAME=_who_upload.text;
//        select_file_message.WHO_UPLOAD_THIS_FILE_ID=_who_upload
//        [self download_from_url];
    }
    else
    {
    }
    [super setHighlighted:highlighted animated:animated];
}

-(void)setModel:(file_in_class *)model{
    _model = model;
    _file_name.text=model.file_name;
    _who_upload.text=model.who_upload;
    _class_name=model.class_name;
    _class_id=model.class_id;
    _course_id=model.course_id;
    _file_name_in_this_cell=model.class_id;
}

//使用懒加载创建分割线view,保证一个cell只有一条
-(UIView *)separatorView
{
    if (_separatorView == nil) {
        UIView *separatorView = [[UIView alloc]init];
        self.separatorView = separatorView;
        separatorView.backgroundColor = [UIColor brownColor];
        [self addSubview:separatorView];
    }
    return _separatorView;
}

//重写layoutSubViews方法，设置位置及尺寸
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.separatorView.frame = CGRectMake(0, self.bounds.size.height-1,     self.bounds.size.width, 2);
}
//-(void)download_from_url
//{
//    NSURL *url_file =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/download?file_name=%@",_file_name.text]];
//    NSData *data= [NSData dataWithContentsOfURL:url_file];
//    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);// NSData写入文件
//
//    // 获取Documents目录
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@", docPath);
//    NSString *strPath =[NSString stringWithFormat:@"%@/%@", docPath, _file_name.text];
//    NSLog(@"%@", strPath);
//    // 创建一个存放NSData数据的路径
////    NSString *fileDataPath = [docPath stringByAppendingPathComponent:@"icon"];
//    [data writeToFile:strPath atomically:YES];
//}
@end
