//
//  YZDanTangViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Alamofire
import DGElasticPullToRefresh
class YZDanTangViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    


  let tableView=UITableView()
  var dateArray = NSMutableArray()
    let limit:Int = 20
    var offset:Int = 0
    let wb = (UIScreen.main.bounds.width) / 750
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.white
        
        loadHomeInfo(4);
    
        // Do any additional setup after loading the view.
    }
    
    
    
    /// 获取首页数据
    func loadHomeInfo(_ id: Int) -> () {
        //  let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=20&offset=0"
        let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=\(limit)&offset=\(offset)"
  
      // print("BASE_URL",url)
        
        
        Alamofire.request(url).responseJSON { response in
          //  print(response.request)  // original URL request
          //  print(response.response) // HTTP URL response
           // print(response.data)     // server data
           // print(response.result)   // result of response serialization
            
            if let JSON = response.result.value  {
              //  print("JSON: \(JSON)")
                
                let dict : NSDictionary = (JSON as? NSDictionary)!
                
               // print(dict["code"])
                
               // print(dict["data"])
              //  print(dict["message"])
              
                 let model = Homemodel().setHomeModelData(data: dict["data"] as!NSDictionary)
                 self.dateArray.add(model)
           // print(self.model.paging)
//                let a :Homeinnermodel = model.items?.object(at: 0) as! Homeinnermodel
//                print(a.title)
                
                self.makeUI();
                self.tableView.reloadData()
                
            }
        }

    
        
    }
    
    func makeUI(){
        
      
        
        
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-44)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView)
        tableView.register(HomeViewCell().classForCoder, forCellReuseIdentifier: "id")
        
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({
            self.offset = self.offset + self.limit
            self.loadHomeInfo(4)
            
            self.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.dateArray.count * 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = HomeViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! HomeViewCell
      
            //cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "id")
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.textColor = UIColor.black
       // print(self.model.items?.count)
        
        let num :Int = indexPath.row/20
        let model:Homemodel = self.dateArray.object(at: num) as! Homemodel
        let a :Homeinnermodel = model.items?.object(at:indexPath.row%20) as! Homeinnermodel
        
        cell.setDate(model: a)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320*wb
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let num :Int = indexPath.row/20
        let model:Homemodel = self.dateArray.object(at: num) as! Homemodel
        let a :Homeinnermodel = model.items?.object(at: indexPath.row%20) as! Homeinnermodel
        let vc = DantangDetailViewController()
        vc.homemodel = a
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.isNavigationBarHidden = true
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
