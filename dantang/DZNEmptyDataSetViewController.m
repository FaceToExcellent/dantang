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
