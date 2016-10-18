//
//  YZProductViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Alamofire
class YZProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let limit:Int = 20
    var offset:Int = 0
    let tableView=UITableView()
    var dateArray = NSMutableArray()
     let wb = (UIScreen.main.bounds.width) / 750
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
        
        loaddanpinData()
       // makeUI()
    }
    func makeUI(){
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "gift")
    }
    func  loaddanpinData(){
        
        let url = BASE_URL + "v2/items?gender=1&generation=1&limit=\(limit)&offset=\(offset)"
        
        Alamofire.request(url).responseJSON { response in
            //  print(response.request)  // original URL request
            //  print(response.response) // HTTP URL response
            // print(response.data)     // server data
            // print(response.result)   // result of response serialization
            if let JSON = response.result.value  {
                    let dict : NSDictionary = (JSON as? NSDictionary)!
                  // print(dict)
                let model = giftModel().setgiftModelData(data: dict["data"] as!NSDictionary)
               self.dateArray.add(model)
                
              //  print(self.dateArray)
                
                self.makeUI();
                self.tableView.reloadData()
            }
            
        }
        
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.dateArray.count * 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "gift", for: indexPath) 
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.black
        
        let num :Int = indexPath.row/20
        let model:giftModel = self.dateArray.object(at: num) as! giftModel
        let a :giftInnerModel = model.items?.object(at:indexPath.row%20) as! giftInnerModel
        
        cell.textLabel?.text = a.name
        //print(a.mydescription)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320 * wb
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
