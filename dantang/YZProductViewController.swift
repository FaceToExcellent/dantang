//
//  YZProductViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Alamofire
import DGElasticPullToRefresh
class YZProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,giftCellPushtoDetailDelegate {
    
    let limit:Int = 20
    var offset:Int = 0
    let tableView=UITableView()
    var dateArray = NSMutableArray()
     let wb = (UIScreen.main.bounds.width) / 750
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 240/255, green: 105/255, blue: 105/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        
    
        
        loaddanpinData()

    }
    func makeUI(){
        self.tableView.frame = CGRect.init(x: 0, y:64, width: self.view.frame.size.width, height: self.view.frame.size.height-64-44)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(giftTableViewCell().classForCoder, forCellReuseIdentifier:"gift")
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
       refresh.addTarget(self, action: #selector(YZProductViewController.myrefresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresh)
        
        
    }
    func myrefresh(){
        self.offset = self.offset + self.limit
        refresh.beginRefreshing()
        self.loaddanpinData()
        
    }
    
    func  loaddanpinData(){
      
        let url = BASE_URL + "v2/items?gender=1&generation=1&limit=\(limit)&offset=\(offset)"
        //print(offset)
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
                
          //  print(model.paging)
                
             
                
                self.makeUI();
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            }
            
        }
        
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //print(self.dateArray.count*10)
        return  self.dateArray.count * 10
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = giftTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier:"gift", for: indexPath) as! giftTableViewCell
        
     
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.black
        cell.delegate = self
        
        let num :Int = indexPath.row/10
       // print(indexPath.row)
        let model:giftModel = self.dateArray.object(at: num) as! giftModel
       // let a :giftInnerModel = model.items?.object(at:indexPath.row%20) as! giftInnerModel
        
        
       // cell.textLabel?.text = a.name
        //因为一次请求20个 所以单个情况暂时不写
        if ((model.items?.count)!*(self.dateArray.count)) > indexPath.row*2 {
            let  row = indexPath.row*2;
            let a :giftInnerModel = model.items?.object(at:row%10) as! giftInnerModel
            cell.setliftView(model: a)
            cell.liftView.tag = row
            cell.tag = indexPath.row
            
    //cell.liftView.name.text = String(indexPath.row)
        }
        
        if ((model.items?.count)!*(self.dateArray.count)) > (indexPath.row*2 + 1) {
            let  row = indexPath.row*2 + 1;
            let a :giftInnerModel = model.items?.object(at:row%10) as! giftInnerModel
            cell.setrightView(model: a)
            cell.rightView.tag = row
            cell.tag = indexPath.row
        }
        
        //print(a.mydescription)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 520 * wb
    }
    func giftCellPushtoDetail(isleft: Bool, tag: Int) {
        let num :Int = tag/4
       // print(num)
        let model:giftModel = self.dateArray.object(at: num) as! giftModel
        let vc = YZPDetailViewController()
        if isleft {
        //tag*2
               let a :giftInnerModel = model.items?.object(at:tag*2) as! giftInnerModel
              vc.model = a
            
        }else
        {
         //tag*2 +1
            if (tag*2+1) < (model.items?.count)! {
                let a :giftInnerModel = model.items?.object(at:tag*2+1) as! giftInnerModel
                vc.model = a
            }
            
            
            
        }
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
