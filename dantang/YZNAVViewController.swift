//
//  YZNAVViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
class YZNAVViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      let navBar  = UINavigationBar.appearance()
     navBar.barTintColor = UIColor.white
     navBar.tintColor = UIColor.black
//        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSForegroundColorAttributeName:UIFont.systemFontOfSize(20)]
        
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count>0  {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
          super.pushViewController(viewController, animated: true)
    }
    /// 返回按钮
    func navigationBackClick() {
//        if SVProgressHUD.isVisible() {
//            SVProgressHUD.dismiss()
//        }
        
        
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
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
