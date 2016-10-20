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
    let headview = giftScollview()
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor = UIColor.white
       self.navigationController?.navigationBar.tintColor = UIColor(red: 240/255, green: 105/255, blue: 105/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        self.title = "商品详情"
        
        let backButton = UIButton()
        backButton.frame = CGRect.init(x: 0, y: 0, width: 24/2, height: 43/2)
        backButton.setBackgroundImage(UIImage.init(named: "icoBack"), for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(YZPDetailViewController.popCLick), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        
        
      // print(model?.name)
        
        makeUI()
        
        
    }
    
    func popCLick(){
       self.navigationController?.popViewController(animated: true)
    }
    
    func makeUI(){
        headview.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        headview.backgroundColor = UIColor.red
        headview.LoadData(model: self.model!)
        self.view.addSubview(headview)
        
        headview.reloadData(model:  self.model!)
        
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
