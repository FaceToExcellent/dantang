//
//  CoreText2ViewController.swift
//  dantang
//
//  Created by HYZ on 2017/7/21.
//  Copyright © 2017年 HYZ. All rights reserved.
//

import UIKit

class CoreText2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
        
       let view = CTView.init(frame: CGRect.init(x: 10, y: 100, width: 300, height: 200))
        
        
        self.view .addSubview(view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    


}
