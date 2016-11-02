//
//  YZPDetailViewController.swift
//  dantang
//
//  Created by HYZ on 16/10/20.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class YZPDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let tableview = UITableView()
    let HDview = UIView()
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
        HDview.frame =  CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width+150)
        //HDview.backgroundColor = UIColor.gray
        
        headview.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        headview.backgroundColor = UIColor.red
        headview.LoadData(model: self.model!)
        HDview.addSubview(headview)
    
        headview.reloadData(model:  self.model!)
        
        name.frame = CGRect.init(x: 10, y: self.view.frame.size.width + 5, width: self.view.frame.size.width, height: 15)
        name.textAlignment = .left
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 14)
        name.text = model?.name
        HDview.addSubview(name)
        
        
        prices.frame = CGRect.init(x: 10, y: self.view.frame.size.width + 25, width: self.view.frame.size.width, height: 15)
        prices.textAlignment = .left
        prices.textColor = UIColor.red
        prices.font = UIFont.systemFont(ofSize: 12)
        prices.text = "￥" + (model?.price)!
        HDview.addSubview(prices)
        
        mydescription.frame = CGRect.init(x: 10, y: self.view.frame.size.width + 45, width: self.view.frame.size.width-20, height: 100)
        mydescription.textAlignment = .left
        mydescription.textColor = UIColor.black
        mydescription.numberOfLines = 8
        mydescription.lineBreakMode = .byTruncatingTail
        mydescription.font = UIFont.systemFont(ofSize: 10)
        mydescription.text = "PS:" + (model?.mydescription)!
        mydescription.sizeToFit()//label 从顶部开始
        HDview.addSubview(mydescription)
        
        
        tableview.frame = CGRect.init(x: 0, y: 0, width:Screem_W, height: Screem_H)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableHeaderView = HDview
        tableview.separatorStyle = UITableViewCellSeparatorStyle.none
        tableview.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "de")
        self.view.addSubview(tableview)
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell = tableview.dequeueReusableCell(withIdentifier: "de", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if indexPath.row == 0 {
            let pwview = pOwView()
            pwview.frame = CGRect.init(x: 0, y: 0, width: Screem_W, height: Screem_H)
           // pwview.backgroundColor = UIColor.red
            
            pwview.reloadView(id_: (model?.id_)!)
          
            
            cell.addSubview(pwview)
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
           
            return Screem_H
        }
        
        return 100
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
