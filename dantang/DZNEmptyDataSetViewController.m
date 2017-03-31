//
//  DZNEmptyDataSetViewController.m
//  dantang
//
//  Created by HYZ on 17/3/30.
//  Copyright © 2017年 HYZ. All rights reserved.
//

#import "DZNEmptyDataSetViewController.h"
//导入头文件
#import "UIScrollView+EmptyDataSet.h"
@interface DZNEmptyDataSetViewController ()< DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation DZNEmptyDataSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Do any additional setup after loading the view.
}
#pragma mark - DZNEmptyDataSetSource // 返回图片 
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
   // return [UIImage imageNamed:@"6"];
    return [UIImage imageNamed:@"100"];

}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"这应该是白页";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"这里确实是空的空空空空空的";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"哈喽" attributes:attribute];
}
//#pragma mark - DZNEmptyDataSetDelegate
// 处理按钮的点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com"]];
     if ([[UIApplication sharedApplication] canOpenURL:url])
     {
         [[UIApplication sharedApplication] openURL:url];
     }
}

// 空白区域点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
   
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点我干哈" message:@"干哈" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"关上" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 标题文字与详情文字的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
