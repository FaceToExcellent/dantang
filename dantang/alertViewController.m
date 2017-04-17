//
//  alertViewController.m
//  dantang
//
//  Created by HYZ on 17/4/17.
//  Copyright © 2017年 HYZ. All rights reserved.
//

#import "alertViewController.h"
#import "FrankAlertActionSheetView.h"
@interface alertViewController ()
/**
 位置关系
 */
@property (nonatomic,assign)CustomViewPosition position;
@end

@implementation alertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    NSArray *array = [NSArray arrayWithObjects:@"自定义视图",@"弹出View上",@"/调用系统/",@"弹出View下", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    //设置frame
    segment.frame = CGRectMake(10, 100, self.view.frame.size.width-20, 30);
    //添加到视图
    [self.view addSubview:segment];
    
    [segment addTarget:self action:@selector(segmentControlValueChangedMethod:) forControlEvents:UIControlEventValueChanged];
    
}
- (void)segmentControlValueChangedMethod:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            //自定义视图
            FrankAlertActionSheetView * alert0 = [[FrankAlertActionSheetView alloc]initCustomActionSheetWithTitle:@"标题" message:@"信息内容信息内容信息内容" completeBlock:^(NSString *indexString, NSInteger buttonIndex) {
                 NSLog(@"------- %ld",(long)buttonIndex);
            } cancelButtonTitle:@"关闭" otherButtonTitles:@"111",@"222",@"333", nil];
            alert0.messageFont = 16;
            alert0.titleColor =[UIColor redColor];
            alert0.messageColor =[UIColor blackColor];
            alert0.buttonTitleColor =[UIColor greenColor];
            [alert0 show];
            
        }
            break;
        case 1:
        {  /**ViewAnimateNone/ViewAnimateFromTop/ViewAnimateFromLeft/ViewAnimateFromBottom/ViewAnimateFromRight/ViewAnimateScale/
            **/
             ViewAlertAnimateStyle animateSytle = ViewAnimateFromTop;
            UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 15 * 2, 250)];
            
            alertView.backgroundColor = [UIColor whiteColor];
            
            alertView.layer.cornerRadius = 8;
            
            alertView.layer.masksToBounds = YES;
            
            UILabel *alertLabel = [[UILabel alloc] initWithFrame:alertView.bounds];
            alertLabel.center = alertView.center;
            alertLabel.textAlignment = NSTextAlignmentCenter;
            
            alertLabel.text = @"这是自定义的弹出view";
            
            alertLabel.font = [UIFont systemFontOfSize:20];
            
            alertLabel.numberOfLines = 0;
            
            [alertView addSubview:alertLabel];
            
            
            FrankAlertActionSheetView * alert = [[FrankAlertActionSheetView alloc]initCustomView:alertView animateStyle:animateSytle position:self.position];
            
            [alert show];
        }
            break;
            
        case 2:
        {
            //调用系统/*UIAlertControllerStyleActionSheet/UIAlertControllerStyleAlert*/
              UIAlertControllerStyle alertSytle = UIAlertControllerStyleAlert;
            
            FrankAlertActionSheetView * alert = [[FrankAlertActionSheetView alloc] initSystemAlertActionWithStyle:alertSytle title:@"标题" message:@"这是信息描述内容" completeBlock:^(NSString *indexString, NSInteger buttonIndex) {
                
                NSLog(@"------- %ld",(long)buttonIndex);
                
            } cancelButtonTitle:@"取消" otherButtonTitles:@"000",@"111",@"222",@"333", nil];
            
            // 自定义样式颜色、字号大小
            alert.messageFont = 16;
            alert.titleFont = 20;
            alert.titleColor = [UIColor redColor];
            alert.messageColor = [UIColor greenColor];
            alert.buttonTitleColor = [UIColor blackColor];
            
            [alert show];

        }
            break;
        case 3:{
             self.position = CustomViewPosition_Bottom;
            ViewAlertAnimateStyle animateSytle = ViewAnimateNone;
            UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 15 * 2, 250)];
            
            alertView.backgroundColor = [UIColor whiteColor];
            
            alertView.layer.cornerRadius = 8;
            
            alertView.layer.masksToBounds = YES;
            
            UILabel *alertLabel = [[UILabel alloc] initWithFrame:alertView.bounds];
            alertLabel.center = alertView.center;
            alertLabel.textAlignment = NSTextAlignmentCenter;
            
            alertLabel.text = @"这是自定义的弹出view";
            
            alertLabel.font = [UIFont systemFontOfSize:20];
            
            alertLabel.numberOfLines = 0;
            
            [alertView addSubview:alertLabel];
            
            
            FrankAlertActionSheetView * alert = [[FrankAlertActionSheetView alloc]initCustomView:alertView animateStyle:animateSytle position:self.position];
            
            [alert show];

        }
            break;
         default:
            break;
    }
    
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
