//
//  CoreTextViewController.m
//  dantang
//
//  Created by HYZ on 17/4/26.
//  Copyright © 2017年 HYZ. All rights reserved.
//

#import "CoreTextViewController.h"
#import <CoreText/CoreText.h>
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
    //图片没加上
//MARK:1
    //获取当前绘制的上下文
    CGContextRef context  = UIGraphicsGetCurrentContext();
    //设置字形的变换矩阵为不做图形变换
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //平移方法 将画布上平抑一个屏幕高
    CGContextTranslateCTM(context, 0, self.view.frame.size.height);
    //缩放方法，x轴缩放系数为1，则不变，y轴缩放系数为-1，则相当于以x轴旋转180度
    CGContextScaleCTM(context, 1.0, -1.0);
    
    NSMutableAttributedString * attributestr =[[NSMutableAttributedString alloc]initWithString:@"\n这里是在测试图文混排\n这里是一个富文本"];
//MARK:2
    //创建一个回调结构体，设置相关参数
    CTRunDelegateCallbacks  callBacks;
    //memset将已开辟内存空间 callbacks 的首 n 个字节的值设为值 0, 相当于对CTRunDelegateCallbacks内存空间初始化
    memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks));
    //回调版本，默认这个
    callBacks.version = kCTRunDelegateVersion1;
    //设置图片顶部距离基线的距离
    callBacks.getAscent =ascentCallBacks;
    //设置图片底部的距离基线的距离
    callBacks.getDescent = descentCallBacks;
    //设置图片宽度
    callBacks.getWidth = widthCallBacks;
    
 //MARK:3
    //创建一个图片尺寸的字典，初始化代理对象需要
    NSDictionary * dicPic = @{@"height":@32,@"width":@32};
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void * _Nullable)(dicPic));
    //创建空白字符
    unichar placeHolder = 0xFFFC;
    //已空白字符生成字符串
    NSString * placeHolderStr =[NSString stringWithCharacters:&placeHolder length:1];
    //用字符串初始化占位符的富文本
    NSMutableAttributedString * placeHolderAttrStr = [[NSMutableAttributedString alloc]initWithString:placeHolderStr];
    //给字符串中的范围中字符串设置代理
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    //释放（__bridge进行C与OC数据类型的转换，C为非ARC，需要手动管理）
    CFRelease(delegate);

    [attributestr insertAttributedString:placeHolderAttrStr atIndex:12];//将占位符插入原富文本
//MARK:4
    //一个frame的工厂，负责生成frame
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributestr);
    //创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    //添加绘制尺寸
    CGPathAddRect(path, NULL, self.view.bounds);
    NSInteger length = attributestr.length;
    //工厂根据绘制区域及富文本（可选范围，多次设置）设置frame
    CTFrameRef frame =CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
    //根据frame绘制文字
    CTFrameDraw(frame, context);
    
    UIImage * image = [UIImage imageNamed:@"content-details_like_selected_16x16_"];
   CGRect imgFrm = [self calculateImageRectWithFrame:frame];
    //绘制图片
    CGContextDrawImage(context,imgFrm, image.CGImage);
    
    
    
    UILabel *lable2 = [[UILabel alloc]init];
    lable2.frame = CGRectMake(50,264,220, 150);
    lable2.attributedText = attributestr;
    lable2.numberOfLines = 0;
    lable2.backgroundColor =[UIColor orangeColor];
    [self.view addSubview:lable2];
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}

-(CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
{
    //根据frame获取需要绘制的线的数组
    NSArray * arrLines =(NSArray *)CTFrameGetLines(frame);
    //获取线的数量
    NSInteger count  =[arrLines count];
    //建立起点的数组（cgpoint类型为结构体，故用C语言的数组）
    CGPoint points[count];
    //获取起点
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    
    for(int i = 0;i<count ;i++){
        //遍历线的数组
        CTLineRef line = (__bridge CTLineRef)(arrLines[i]);
        //获取GlyphRun数组（GlyphRun：高效的字符绘制方案）
        NSArray * arrGlyphRun = (NSArray*)CTLineGetGlyphRuns(line);
        for (int j=0; j<arrGlyphRun.count; j++) {
            //遍历CTRun数组
            //获取CTRun
            CTRunRef run = (__bridge CTRunRef)(arrGlyphRun[j]);
            //获取CTRun的属性
            NSDictionary * attributes = (NSDictionary*)CTRunGetAttributes(run);
            //获取代理
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)([attributes valueForKey:(id)kCTRunDelegateAttributeName]);
            //非空
            if (delegate == nil) {
                continue;
            }
            //判断代理字典
            NSDictionary *dic = CTRunDelegateGetRefCon(delegate);
            
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            //获取一个起点
            CGPoint point  = points[i];
            //获取上距
            CGFloat ascent ;
            //获取下距
            CGFloat descent;
            //创建一个frame
            CGRect boundsRun;
            boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            //取得高
            boundsRun.size.height = ascent + descent;
            //获取x偏移量
            CGFloat xoffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            //point是行起点位置，加上每个字的偏移量得到每个字的x
            boundsRun.origin.x = point.x
            + xoffset;
            //计算原点
            boundsRun.origin.y = point.y -descent;
            //获取绘制区域
            CGPathRef path = CTFrameGetPath(frame);
            //获取剪裁区域边框
            CGRect colRect = CGPathGetBoundingBox(path);
            
            CGRect imageBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
            return imageBounds;
            
        }
    }
    
    
    
  
    
    
    return CGRectZero;
    
    
   
}
//MARK:结构体
static CGFloat ascentCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"height"] floatValue];
}
static CGFloat descentCallBacks(void * ref)
{
    return 0;
}
static CGFloat widthCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"width"] floatValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
