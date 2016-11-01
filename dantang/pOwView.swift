//
//  pOwView.swift
//  dantang
//
//  Created by HYZ on 16/10/29.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class pOwView: UIView {
    let titilview = UIView()
    let tuwenButton = UIButton()
    let pinglunButton = UIButton()
    let redview = UIView()
    let limit:Int = 20
    var offset:Int = 0
    var id :Int = 0
    let webview =  MyWebView.init(f:CGRect.init(x: 0, y: 90*wb + 15, width: Screem_W, height:1000*wb))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func makeUI()
     {
        
        let grayview = UIView()
        grayview.frame = CGRect.init(x: 0, y: 0, width: Screem_W, height: 15)
        grayview.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.addSubview(grayview)
        
        titilview.frame = CGRect.init(x: 0, y: 15, width: Screem_W, height: 90*wb)
        self.addSubview(titilview)
        
        tuwenButton.frame = CGRect.init(x: 0, y: 0, width: Screem_W/2, height: 90*wb)
        tuwenButton.setTitle("图文介绍", for: UIControlState.normal)
        tuwenButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        tuwenButton.tag = 1
        tuwenButton.addTarget(self, action: #selector(pOwView.buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        titilview.addSubview(tuwenButton)
        
        pinglunButton.frame = CGRect.init(x: Screem_W/2, y: 0, width: Screem_W/2, height: 90*wb)
        pinglunButton.setTitle("评论", for: UIControlState.normal)
        pinglunButton.tag = 2
        pinglunButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        pinglunButton.addTarget(self, action: #selector(pOwView.buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        titilview.addSubview(pinglunButton)
        
        let view = UIView()
        view.frame  = CGRect.init(x: 0, y: 90*wb-1, width: Screem_W, height: 0.5)
        view.backgroundColor = UIColor.black
        titilview.addSubview(view)
        let view2 = UIView()
        view2.frame = CGRect.init(x: Screem_W/2, y: 0, width: 0.5, height: 90*wb)
        view2.backgroundColor = UIColor.black
        titilview.addSubview(view2)
       // webView.frame = CGRect.init(x: 0, y: 90*wb, width: Screem_W, height: Screem_H - 90*wb)
       // self.addSubview(webView)
        
        redview.frame = CGRect.init(x: 0, y: 90*wb - 5, width: Screem_W/2, height: 5)
        redview.backgroundColor = UIColor.init(red: 231/255, green: 86/255, blue: 89/255, alpha: 1)
        titilview.addSubview(redview)
        
      
        webview.backgroundColor = UIColor.orange
        //     let url = BASE_URL + "v2/items/\(id)/comments"
       // let params = ["limit": 20,"offset": 0]
       // let id = 0
        let url = BASE_URL + "v2/items/\(id)"
        webview.loadMywebview(myUrl:url)
       // webview.isUserInteractionEnabled = false
        
        
        //webview.webview.delegate=self;
        //print("DantangDetailViewController",homemodel.content_url)
        self.addSubview(webview)
        
     }
    
    func buttonClick(sender:UIButton){
        if sender.tag == 1 {
            //图文介绍
            print("图文介绍")
              let url = BASE_URL + "v2/items/\(id)"
            redview.frame = CGRect.init(x: 0, y: 90*wb - 5, width: Screem_W/2, height: 5)
           // webView.backgroundColor = UIColor.gray
            
            webview.loadMywebview(myUrl: url)
            
        }else if sender.tag == 2 {
            print("评论")
             let url = BASE_URL + "v2/items/\(id)/comments?limit=\(limit)&offset=\(offset)"
            redview.frame = CGRect.init(x: Screem_W/2, y: 90*wb - 5, width: Screem_W/2, height: 5)
           // webView.backgroundColor  = UIColor.blue
             webview.loadMywebview(myUrl: url)
        }
    }
    func reloadView(id_:Int){
        id = id_ 
        makeUI()
    }
    
    
}
