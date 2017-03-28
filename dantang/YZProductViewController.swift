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
import SwiftyJSON
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
            if let JSON1 = response.result.value  {
//MARK:swiftyJSON 解析
//                if let dataFromString = response.data {
//                    let json = JSON(data: dataFromString )
//                    print("",json)
//                    /* {
//                     "code" : 200,
//                     "data" : {
//                     "items" : [
//                     {
//                     "type" : "item",
//                     "data" : {
//                     "description" : "开关一键式，便携又防漏，热水氤氲的湿气打在脸上，温暖又可爱~",
//                     "editor_id" : 1037,
//                     "url" : "http:\/\/dantang.liwushuo.com\/items\/1355",
//                     "purchase_url" : "http:\/\/s.click.taobao.com\/t?e=m%3D2%26s%3DYxYY5WFio4EcQipKwQzePOeEDrYVVa64pRe%2F8jaAHci5VBFTL4hn2ZzpsqmXu%2FE9WI6w0dMGH8htabAtTg06px%2FVXctKptzdeP1OMBEVuKXSfUtBr7Z5QILBwQLXKLHMyxRpeaHkj4I49d%2BuVtoyMHEqY%2Bakgpmw",
//                     "image_urls" : [
//                     "http:\/\/7fvaoh.com3.z0.glb.qiniucdn.com\/image\/150819\/ovabcvdgu.jpg-w720",
//*/
//                
//                }
//                
//MARK: 手动解析
                let dict: NSDictionary  = JSON1 as! NSDictionary
               // print(dict)
                
                
                /*{
                 code = 200;
                 data =     {
                 items =         (
                 {
                 data =                 {
                 "brand_id" = "<null>";
                 "brand_order" = 0;
                 "category_id" = "<null>";
                 "cover_image_url" = "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150819/a7wjwjck3_w.jpg-w720";
                 "created_at" = 1439952881;
                 description = "\U5f00\U5173\U4e00\U952e\U5f0f\Uff0c\U4fbf\U643a\U53c8\U9632\U6f0f\Uff0c\U70ed\U6c34\U6c24\U6c32\U7684\U6e7f\U6c14\U6253\U5728\U8138\U4e0a\Uff0c\U6e29\U6696\U53c8\U53ef\U7231~";
                 "editor_id" = 1037;
                 "favorites_count" = 198;
                 id = 1355;
                 "image_urls" =                     (
                 "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150819/ovabcvdgu.jpg-w720",
                 "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150819/gaw35u5bt.jpg-w720",*/
                let model = giftModel().setgiftModelData(data: dict["data"] as! NSDictionary)
                self.dateArray.add(model)
             
                
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
            let a :giftInnerModel = model.items?.object(at:row%20) as! giftInnerModel
            cell.setliftView(model: a)
            cell.liftView.tag = row
            cell.tag = indexPath.row
            
    //cell.liftView.name.text = String(indexPath.row)
        }
        
        if ((model.items?.count)!*(self.dateArray.count)) > (indexPath.row*2 + 1) {
            let  row = indexPath.row*2 + 1;
            let a :giftInnerModel = model.items?.object(at:row%20) as! giftInnerModel
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
        let num :Int = tag/10
       // print(num)
        let model:giftModel = self.dateArray.object(at: num) as! giftModel
        let vc = YZPDetailViewController()
        if isleft {
        //tag*2
            let  row = tag*2;
            let a :giftInnerModel = model.items?.object(at:row%20) as! giftInnerModel
              vc.model = a
            
        }else
        {
         //tag*2 +1
            
                let  row = tag*2 + 1;
                let a :giftInnerModel = model.items?.object(at:row%20) as! giftInnerModel
                vc.model = a
                
               // print(a.image_urls)
           
            
            
            
        }
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
