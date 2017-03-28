//
//  FSCalendarViewController.m
//  dantang
//
//  Created by HYZ on 17/3/28.
//  Copyright © 2017年 HYZ. All rights reserved.
//

#import "FSCalendarViewController.h"
#import "FSCalendar.h"
@interface FSCalendarViewController ()<FSCalendarDataSource, FSCalendarDelegate>
@property (weak, nonatomic) FSCalendar *calendar;
@end

@implementation FSCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self MakeView];
}


-(void)MakeView{
   
}

-(void)loadView
{
    /****
     * 如果当前的VC不使用Interface Builder，请覆盖这个方法，反之如果使用了，则一定不能覆盖这个方法(you must not override this method)。
     * loadView这个方法负责创建当前VC的根视图的视图层级(view hierachy)，在这里给self.view赋值(non-nil value)，并且不要调用[super loadView];（Your custom implementation of this method should not call super）;
     * viewDidLoad用来做额外的初始化(additional initialization)；
     方式2. 使用Interface Builder   **/
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:calendar];
    self.calendar = calendar;
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
