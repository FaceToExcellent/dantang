//
//  ROOTViewController.swift
//  单糖仿写
//
//  Created by HYZ on 16/9/5.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class ROOTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.extendedLayoutIncludesOpaqueBars = false
        self.modalPresentationCapturesStatusBarAppearance = false
        //设置导航栏背景色不变淡
        
        self.navigationController?.navigationBar.translucent = false
        
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
