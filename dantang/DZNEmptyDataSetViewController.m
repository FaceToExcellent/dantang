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
         //10.3
         [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
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
// 返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor cyanColor];

}

//// 标题文字与详情文字同时调整垂直偏移量
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
//    return -100;
//
//}

#pragma mark - DZNEmptyDataSetSource
// 返回图片
#pragma mark - DZNEmptyDataSetSource // 返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    // return [UIImage imageNamed:@"6"];
    return [UIImage imageNamed:@"content-details_like_selected_16x16_"];
    
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0,   1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
#pragma mark - DZNEmptyDataSetDelegate 
// 图片是否要动画效果，默认NO
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark - 其他方法
//// 返回图片的 tintColor
//- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
//    return [UIColor yellowColor];
//}
//// 返回可点击按钮的 image
//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    return [UIImage imageNamed:@"icon_wwdc"];
//}
//// 返回可点击按钮的 backgroundImage
//- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    return [UIImage imageNamed:@"icon_wwdc"];
//}
//// 返回自定义 view
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
//    return nil;
//}
// // 是否显示空白页，默认YES
//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
//    return YES;
//}
//// 是否允许点击，默认YES
//- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
//    return YES;
//}
//// 是否允许滚动，默认NO
//- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
//    return YES;
//}
//// 图片是否要动画效果，默认NO
////- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
////    return YES;
////}
//// 空白页将要出现
//- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView { }
//// 空白页已经出现
//- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView { }
//// 空白页将要消失
//- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView { }
//// 空白页已经消失
//- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView { }
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
