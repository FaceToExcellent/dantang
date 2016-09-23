//
//  YZDanTangViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Alamofire
class YZDanTangViewController: ROOTViewController,UITableViewDelegate,UITableViewDataSource{
 var model = Homemodel()
  let tableView=UITableView()
    
    let wb = (UIScreen.main.bounds.width) / 750
    let hb = UIScreen.main.bounds.height / 1334
    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.backgroundColor = UIColor.purple
        
        loadHomeInfo(4);
    
        // Do any additional setup after loading the view.
    }
    
    
    
    /// 获取首页数据
    func loadHomeInfo(_ id: Int) -> () {
        //  let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=20&offset=0"
        let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=20&offset=0"
  
        
        Alamofire.request(url).responseJSON { response in
          //  print(response.request)  // original URL request
          //  print(response.response) // HTTP URL response
           // print(response.data)     // server data
           // print(response.result)   // result of response serialization
            
            if let JSON = response.result.value  {
               // print("JSON: \(JSON)")
                
                let dict : NSDictionary = (JSON as? NSDictionary)!
                
               // print(dict["code"])
                
               // print(dict["data"])
              //  print(dict["message"])
              
                 self.model = Homemodel().setHomeModelData(data: dict["data"] as!NSDictionary)
             // print(self.model.items?.count)
//                let a :Homeinnermodel = model.items?.object(at: 0) as! Homeinnermodel
//                print(a.title)
                
                    self.makeUI();
                
            }
        }

        
        
    }
    
    func makeUI(){
        
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(HomeViewCell().classForCoder, forCellReuseIdentifier: "id")
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.model.items?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = HomeViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! HomeViewCell
      
            //cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "id")
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.textColor = UIColor.black
       // print(self.model.items?.count)
        let a :Homeinnermodel = self.model.items?.object(at: indexPath.row) as! Homeinnermodel 
        
        cell.setDate(model: a)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320*hb
    }
    
    
    
    
    
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
