//
//  CTView.swift
//  dantang
//
//  Created by HYZ on 2017/7/21.
//  Copyright © 2017年 HYZ. All rights reserved.
//

import UIKit
import CoreText
class CTView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //1.在视图创建的时候，draw(_:)会自动运行，渲染这个视图的背景图层。
    override func draw(_ rect: CGRect) {
        //2.打开用于绘制的当前图形上下文。
        guard let context  = UIGraphicsGetCurrentContext()  else {
            return;
        }
        
        //翻转 transformation
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        
        
        //3.创建一条用来限定绘图区域的路径，在这个例子中就是整个视图的bounds。
        let  path  = CGMutablePath()
        path.addRect(bounds)
        //4.Core Text，使用NSAttributedString而不是String或者NSString，保存文本和属性(attributes)。初始化一个"Hello World"的属性字符串。
        let  attrString = NSAttributedString(string:"你好呀")
        //5.CTFramesetterCreateWithAttributedString使用提供的属性字符串创建一个CTFramesetter。CTFramesetter会管理你引用的字体和绘图区域。
        let framsetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
        //6.通过使CTFramesetterCreateFrame在路径内渲染整个字符串，可以创建一个CTFrame。
        let frame = CTFramesetterCreateFrame(framsetter, CFRangeMake(0, attrString.length), path, nil)
        //7.CTFrameDraw在给定的上下文中绘制CTFrame。
        CTFrameDraw(frame, context);
        
        
        
        
        
    }
    /*当你提供一个NSAttributedString创建一个CTFramesetter对象实例的时候，一个CTTypesetter的实例对象会自动为你创建用以管理你的字体。接下来你会在渲染文本的时候用到这个CTFramesetter去创建一个或者多个frame。
     
     当你创建了一个frame，你可以为这个frame提供文本的一个subrange去渲染这段文本。Core Text会自动为文本的每一行创建一个CTLine，并为每个具有相同格式的字符创建一个CTRun。举个例子，Core Text只会创建一个CTRun用于同一行中的几个红色的单词，创建一个CTRun用于接下来的纯文本，创建一个CTRun用于粗体段落等等。Core Text创建会根据你提供的NSAttributedString中的属性创建CTRun。此外，上面说到的每一个CTRun对象都可以采用不同的属性，也就是说，你可以很好地控制字距、连字、宽度、高度等。
     
     */
}
