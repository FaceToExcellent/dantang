//
//  MarkupParser.swift
//  dantang
//
//  Created by HYZ on 2017/7/21.
//  Copyright © 2017年 HYZ. All rights reserved.
//

import UIKit
import CoreText
import QuartzCore
class MarkupParser: NSObject {

    
    var color :UIColor = .black
    var fontName:String = "Arial"
    var attrString :NSMutableAttributedString!
    var  images :[[String :Any]] = []
    override init() {
        super.init()
    }
    
    func parseMarkup(_ markup:String) {
        //1.attrString初始为空，但是最后会包含解析出来的标记。
        attrString = NSMutableAttributedString(string:"")
        
        do {
            //2.这个正则表达式，匹配了紧跟着这些标签的文本块。它就好像在说：“去查看字符串直到你找到一个开头的括号，然后查看字符串直到你找到一个结束的括号（或者文档的末尾）
            let  regex = try NSRegularExpression(pattern:"(.*?)(<[^>]+>|\\Z)",options:[.caseInsensitive,.dotMatchesLineSeparators])
            //3.搜索regex匹配到的整个标记范围，然后生成一个NSTextCheckingResult的数组
            let chunks = regex.matches(in: markup, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSRange(location: 0,length: markup.characters.count))
            
            print(chunks);
            
            let defaultFont:UIFont = .systemFont(ofSize: UIScreen.main.bounds.size.height/40)
            for chunk in chunks{
                guard  let markupRange = markup.range(from:chunk.range)
                else {
                    continue
                }
                let parts = markup.substring(with:markupRange).components(separatedBy: "<")
                
                let font  = UIFont(name:fontName,size:UIScreen.main.bounds.size.height/40) ?? defaultFont
//                let attrs = [NSAttributedString.foregroundColor: color, NSAttributedString.font: font] as [NSAttributedString : Any]
//
//                let text = NSMutableAttributedString(string: parts[0], attributes: attrs)
//                attrString.append(text)
//MARK: //暂时不再继续写了 等待 iOS11 Xcode9 登陆后继续
            }
            
            
            
            
        } catch _ {
            
            
        }
    }
    
}



extension String{
    /*以NSRange表示的字符串的起止索引转换为了String.UTF16View.Index格式，即UTF-16字符串中的位置(position)集合，然后将每个String.UTF16View.Index格式转换为String.Index格式。String.Index格式在组合时，会生成Swift的范围格式：Range。只要索引是有效的，这个函数就会返回原始NSRange格式对应的Range格式。
     
     */
    func range(from range:NSRange)->Range<String.Index>?{
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
        let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16,within:self),
            let to = String.Index(to16,within:self)
            else {
            return nil
        }
        
       return from ..< to
    }
}




