//
//  CoretextView.h
//  dantang
//
//  Created by HYZ on 17/5/2.
//  Copyright © 2017年 HYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface CoretextView : UIView
@property(nonatomic,strong)UIImage * image;
@property(nonatomic) CGRect imgFrm;
@property(nonatomic)NSMutableAttributedString * attributeStr;
@property(nonatomic)CTFrameRef ctframe;
@end
