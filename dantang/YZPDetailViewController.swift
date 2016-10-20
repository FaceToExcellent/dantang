//
//  YZPDetailViewController.swift
//  dantang
//
//  Created by HYZ on 16/10/20.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class YZPDetailViewController: UIViewController {

    var model : giftInnerModel? = giftInnerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   self.view.backgroundColor = UIColor.white
       print(model?.name)
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
