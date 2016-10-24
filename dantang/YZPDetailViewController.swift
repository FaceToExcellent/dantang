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
    let name  = UILabel()
    let prices = UILabel()
    let  mydescription = UILabel()
    
    
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
    //swift 这个垃圾方式
    self.navigationController?.popViewController(animated: true)
    }
    
    func makeUI(){
        headview.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        headview.backgroundColor = UIColor.red
        headview.LoadData(model: self.model!)
        self.view.addSubview(headview)
        
        headview.reloadData(model:  self.model!)
        
        name.frame = CGRect.init(x: 10, y: self.view.frame.size.width + 5, width: self.view.frame.size.width, height: 15)
        name.textAlignment = .left
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 14)
        name.text = model?.name
        self.view.addSubview(name)
        
        
        prices.frame = CGRect.init(x: 10, y: self.view.frame.size.width + 25, width: self.view.frame.size.width, height: 15)
        prices.textAlignment = .left
        prices.textColor = UIColor.red
        prices.font = UIFont.systemFont(ofSize: 12)
        prices.text = "￥" + (model?.price)!
        self.view.addSubview(prices)
        
        mydescription.frame = CGRect.init(x: 10, y: self.view.frame.size.width + 45, width: self.view.frame.size.width-20, height: 150)
        mydescription.textAlignment = .left
        mydescription.textColor = UIColor.black
        mydescription.numberOfLines = 8
        mydescription.lineBreakMode = .byTruncatingTail
        mydescription.font = UIFont.systemFont(ofSize: 10)
        mydescription.text = "PS:" + (model?.mydescription)!
        mydescription.sizeToFit()//label 从顶部开始
        self.view.addSubview(mydescription)
        
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
