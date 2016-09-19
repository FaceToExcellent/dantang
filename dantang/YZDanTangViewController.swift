//
//  YZDanTangViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Alamofire
class YZDanTangViewController: ROOTViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.backgroundColor = UIColor.purple
        
        loadHomeInfo(4);
        // Do any additional setup after loading the view.
    }
    
    
    
    /// 获取首页数据
    func loadHomeInfo(_ id: Int) -> () {
        //  let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=20&offset=0"
        let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=5&offset=0"
  
        
        Alamofire.request(url).responseJSON { response in
          //  print(response.request)  // original URL request
          //  print(response.response) // HTTP URL response
           // print(response.data)     // server data
           // print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }

        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
