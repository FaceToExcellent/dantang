//
//  DantangDetailViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/28.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class DantangDetailViewController: UIViewController {
var  homemodel = Homeinnermodel()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.isNavigationBarHidden = false
        
        
        //必须用自己声明的自定义init oc的写法swift的形式
        let webview =  MyWebView.init(f:CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        webview.loadMywebview(myUrl:homemodel.content_url!)
        //webview.webview.delegate=self;
       // print("DantangDetailViewController",homemodel.content_url)
        self.view.addSubview(webview)

           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
