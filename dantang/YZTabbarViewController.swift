//
//  YZTabbarViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/5.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class YZTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        // 添加子控制器
        addChildViewControllers()
    }


    /**
     # 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController("YZDanTangViewController", title: "单糖", imageName: "TabBar_home_23x23_")
        addChildViewController("YZProductViewController", title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController("YZCategoryViewController", title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController("YZMeViewController", title: "我", imageName: "TabBar_me_boy_23x23_")
    }
     private func addChildViewController(childControllerName: String, title: String, imageName: String) {
        
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let cls:AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let  vcClass = cls as!UIViewController.Type
        let vc = vcClass.init()
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.title = title
        
        let nav = YZNAVViewController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
