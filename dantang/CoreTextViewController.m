//
//  CoreTextViewController.m
//  dantang
//
//  Created by HYZ on 17/4/26.
//  Copyright © 2017年 HYZ. All rights reserved.
//

#import "CoreTextViewController.h"

@interface CoreTextViewController ()

@end

@implementation CoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor lightGrayColor];
    //富文本
    NSDictionary * dic = @{NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:10],NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)};
    
    NSMutableAttributedString * attr =[[NSMutableAttributedString alloc]initWithString:@" Created by HYZ on 17/4/26. \n Copyright © 2017年 HYZ. All rights reserved."];
    
    NSLog(@"%lu",(unsigned long)attr.length);
    [attr setAttributes:dic range:NSMakeRange(0,attr.length)];
    
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(9, 10)];
    
    NSDictionary *dict = @{NSBackgroundColorAttributeName:[UIColor whiteColor],NSLigatureAttributeName:@0.2};
    [attr addAttributes:dict range:NSMakeRange(0    , attr.length)];
    
    [attr removeAttribute:NSFontAttributeName range:NSMakeRange(32, 10)];
    
    UILabel *lable = [[UILabel alloc]init];
    lable.frame = CGRectMake(50,64,220, 150);
    lable.attributedText = attr;
    lable.numberOfLines = 0;
    lable.backgroundColor =[UIColor orangeColor];
    [self.view addSubview:lable];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
