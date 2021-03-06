//
//  CoretextView.m
//  dantang
//
//  Created by HYZ on 17/5/2.
//  Copyright © 2017年 HYZ. All rights reserved.
//

#import "CoretextView.h"
#import <CoreText/CoreText.h>
@implementation CoretextView
/*
 coreText 起初是为OSX设计的，而OSX得坐标原点是左下角，y轴正方向朝上。iOS中坐标原点是左上角，y轴正方向向下。
 若不进行坐标转换，则文字从下开始，还是倒着的
 */
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
//MARK:这里是开始吧屏幕坐标系转换为系统坐标系 基本为固定写法
    //获取当前绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置字形的变换矩阵为不做图形变换
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //平移方法，将画布向上平移一个屏幕高
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //缩放方法，x轴缩放系数为1，则不变，y轴缩放系数为-1，则相当于以x轴为轴旋转180度
    CGContextScaleCTM(context, 1.0, -1.0);
//MARK: 转换结束
    
//MARK: 设置图片代理
    /*
     事实上，图文混排就是在要插入图片的位置插入一个富文本类型的占位符。通过CTRUNDelegate设置图片
     */
    //用来插入的富文本
    _attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n这里在测试图文混排，\n我是一个富文本"];
    //MARK:需要一个回调结构体
    /*
     设置一个回调结构体，告诉代理该回调那些方法
     */
    //创建一个回调结构体，设置相关参数
    CTRunDelegateCallbacks callBacks;
    //memset将已开辟内存空间 callbacks 的首 n 个字节的值设为值 0, 相当于对CTRunDelegateCallbacks内存空间初始化
    memset(&callBacks,0,sizeof(CTRunDelegateCallbacks));
    //设置回调版本，默认这个
    callBacks.version = kCTRunDelegateVersion1;
    //CFRun 结构参见 CFRun'ssuject.png
    //设置图片顶部距离基线的距离
    callBacks.getAscent = ascentCallBacks;
    //设置图片底部距离基线的距离
    callBacks.getDescent = descentCallBacks;
    //设置图片宽度
    callBacks.getWidth = widthCallBacks;
    
    /*
     创建一个代理
     */
    //创建一个图片尺寸的字典，初始化代理对象需要 这里尺寸要复合比例
    NSDictionary * dicPic = @{@"height":@133,@"width":@190.5};
    //创建代理 __bridge既是C的结构体转换成OC对象时需要的一个修饰词
    CTRunDelegateRef delegate = CTRunDelegateCreate(& callBacks, (__bridge void *)dicPic);
//MARK:设置结束
    
//MARK:图片插入
    //创建空白字符
    unichar placeHolder = 0xFFFC;
    //已空白字符生成字符串
    NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1];
    //用字符串初始化占位符的富文本
    NSMutableAttributedString * placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
    //给字符串中的范围中字符串设置代理
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    //释放（__bridge进行C与OC数据类型的转换，C为非ARC，需要手动管理）
    CFRelease(delegate);
    //将占位符插入原富文本
    [_attributeStr insertAttributedString:placeHolderAttrStr atIndex:12];
//MARK:插入结束
//MARK:先绘制文本
    //一个frame的工厂，负责生成frame
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributeStr);
    //创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    //添加绘制尺寸
    CGPathAddRect(path, NULL, self.bounds);
    NSInteger length = _attributeStr.length;
    //工厂根据绘制区域及富文本（可选范围，多次设置）设置frame
    //frame即为全部文本的frame 一定要搞清楚全部与指定范围获取的frame他们都是从左上角开始的
    _ctframe = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
    //根据frame绘制文字
    CTFrameDraw(_ctframe, context);
//MARK:绘制文本结束
    //content-details_like_selected_16x16_
//MARK:绘制图片
    _image = [UIImage imageNamed:@"CFRun'ssuject"];
    //这里的CFFrame参见 CFFrame组成.png
    _imgFrm = [self calculateImageRectWithFrame:_ctframe];
    CGContextDrawImage(context,_imgFrm, _image.CGImage);
//MARK:绘制图片结束
//MARK:释放
    CFRelease(_ctframe);
    CFRelease(path);
    CFRelease(frameSetter);
}
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


-(CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
{
    /*
     1.CTLine 可以看做Core Text绘制中的一行的对象 通过它可以获得当前行的line ascent,line descent ,line leading,还可以获得Line下的所有Glyph Runs
     2.CTRun 或者叫做 Glyph Run，是一组共享想相同attributes（属性）的字形的集合体
     3.一个CTFrame有几个CTLine组成，有几行文字就有几行CTLine。一个CTLine有包含多个CTRun，一个CTRun是所有属性都相同的那部分富文本的绘制单元。所以CTRun是CTFrame的基本绘制单元。*/
    
    //根据frame获取需要绘制的线的数组
    NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);
    //获取线的数量
    NSInteger count = [arrLines count];
    //建立起点的数组（cgpoint类型为结构体，故用C语言的数组）
    CGPoint points[count];
    //获取起点 CFRangeMake 这个参数似乎没什么用 还是上面的插入位置管用些
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    
    //遍历线的数组
    for (int i = 0; i < count; i ++) {
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        //获取GlyphRun数组（GlyphRun：高效的字符绘制方案）
        NSArray * arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line);
        //遍历CTRun数组
        for (int j = 0; j < arrGlyphRun.count; j ++) {
            //获取CTRun
            CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j];
            //获取CTRun的属性
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);
            //获取代理
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                continue;//非空
            }
            //判断代理字典
            NSDictionary * dic = CTRunDelegateGetRefCon(delegate);
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            //获取一个起点
            CGPoint point = points[i];
            //获取上距
            CGFloat ascent;
            //获取下距
            CGFloat descent;
            //创建一个frame
            CGRect boundsRun;
            boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            //取得高
            boundsRun.size.height = ascent + descent;
            //获取x偏移量
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            //point是行起点位置，加上每个字的偏移量得到每个字的x
            boundsRun.origin.x = point.x + xOffset;
            //计算原点
            boundsRun.origin.y = point.y - descent;
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




//MARK:点击事件操作
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    //获取点击位置的系统坐标
    CGPoint location = [self systemPointFromScreenPoint:[touch locationInView:self]];
    //检查是否点击在图片上，如果在，优先响应图片事件
    if ([self checkIsClickOnImgWithPoint:location]) {
        return;
    }
    //响应字符串事件
    //MARK:响应字符串有错误
    
   //  [self ClickOnStrWithPoint:location];
}

/*
 实际上接受所有非图片的点击事件，将字符串的每个
 字符取出与点击位置比较，若在范围内则点击到文字
 ，进而检测对应的文字是否响应事件，若存在响应
 */
-(void)ClickOnStrWithPoint:(CGPoint)location
{
    //获取所有CTLine
    NSArray * lines = (NSArray *)CTFrameGetLines(_ctframe);
    //初始化范围数组
    CFRange ranges[lines.count];
    //初始化原点数组
    CGPoint origins[lines.count];
    //获取所有CTLine的原点
    CTFrameGetLineOrigins(_ctframe, CFRangeMake(0, 0), origins);
    //获取所有CTLine的Range
    for (int i = 0; i < lines.count; i ++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        CFRange range = CTLineGetStringRange(line);
        ranges[i] = range;
    }
    //逐字检查
    for (int i = 0; i < _attributeStr.length; i ++) {
        long maxLoc;
        int lineNum;
        //获取对应字符所在CTLine的index
        for (int j = 0; j < lines.count; j ++) {
            CFRange range = ranges[j];
            maxLoc = range.location + range.length - 1;
            if (i <= maxLoc) {
                lineNum = j;
                break;
            }
        }
        //取到字符对应的CTLine
        CTLineRef line = (__bridge CTLineRef)lines[lineNum];
        CGPoint origin = origins[lineNum];
        //计算对应字符的frame
        CGRect CTRunFrame = [self frameForCTRunWithIndex:i CTLine:line origin:origin];
        //如果点击位置在字符范围内，响应时间，跳出循环
        if ([self isFrame:CTRunFrame containsPoint:location]) {
            //点击到文字，然而没有响应的处理。可以做其他处理
            NSLog(@"您点击到了第 %d 个字符，位于第 %d 行，然而他没有响应事件。",i,lineNum + 1);//点击到文字，然而没有响应的处理。可以做其他处理
            return;
        }
    }
    //没有点击到文字，可以做其他处理
    NSLog(@"您没有点击到文字");
}

///字符frame计算
/*
 返回索引字符的frame
 
 index：索引
 line：索引字符所在CTLine
 origin：line的起点
 */
-(CGRect)frameForCTRunWithIndex:(NSInteger)index
                         CTLine:(CTLineRef)line
                         origin:(CGPoint)origin
{
    //获取字符起点相对于CTLine的原点的偏移量
    CGFloat offsetX = CTLineGetOffsetForStringIndex(line, index, NULL);
    //获取下一个字符的偏移量，两者之间即为字符X范围
    CGFloat offsexX2 = CTLineGetOffsetForStringIndex(line, index + 1, NULL);
    //坐标转换，将点的CTLine坐标转换至系统坐标
    offsetX += origin.x;
    offsexX2 += origin.x;
    //取到CTLine的起点Y
    CGFloat offsetY = origin.y;
    //初始化上下边距的变量
    CGFloat lineAscent;
    CGFloat lineDescent;
    //获取所有CTRun
    NSArray * runs = (__bridge NSArray *)CTLineGetGlyphRuns(line);
    CTRunRef runCurrent;
    //获取当前点击的CTRun
    for (int k = 0; k < runs.count; k ++) {
        CTRunRef run = (__bridge CTRunRef)runs[k];
        CFRange range = CTRunGetStringRange(run);
        NSRange rangeOC = NSMakeRange(range.location, range.length);
        if ([self isIndex:index inRange:rangeOC]) {
            runCurrent = run;
            break;
        }
    }
    //计算当前点击的CTRun高度
    CTRunGetTypographicBounds(runCurrent, CFRangeMake(0, 0), &lineAscent, &lineDescent, NULL);
    CGFloat height = lineAscent + lineDescent;
    //返回一个字符的Frame
    return CGRectMake(offsetX, offsetY, offsexX2 - offsetX, height);
}
-(BOOL)isIndex:(NSInteger)index inRange:(NSRange)range
{
    if ((index <= range.location + range.length - 1) && (index >= range.location)) {
        return YES;
    }
    return NO;
}
/*
 遍历图片frame的数组与点击位置比较，如果在
 范围内则响应的数组中取出对应响应并执行，返
 回yes，否则返回no
 */
-(BOOL)checkIsClickOnImgWithPoint:(CGPoint)location
{
    if ([self isFrame:_imgFrm containsPoint:location]) {
    NSLog(@"您点击到了图片");
    return YES;
}
    return NO;
    
}
///点包含检测
-(BOOL)isFrame:(CGRect)frame containsPoint:(CGPoint)point
{
    //传入系统坐标系下的frame
    return CGRectContainsPoint(frame, point);
}
/*
 将屏幕坐标转换为系统坐标
 */
-(CGPoint)systemPointFromScreenPoint:(CGPoint)origin
{
    return CGPointMake(origin.x, self.bounds.size.height - origin.y);
}


@end
