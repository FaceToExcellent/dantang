//
//  YZDanTangViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
class YZDanTangViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.backgroundColor = UIColor.purpleColor()
        
  self.edgesForExtendedLayout = UIRectEdge.None
  
    self.extendedLayoutIncludesOpaqueBars = false
    self.modalPresentationCapturesStatusBarAppearance = false
        //设置导航栏背景色不变淡
        
        self.navigationController?.navigationBar.translucent = false
        
       self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    
    //下载数据
    func loadData(){
        
      
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
