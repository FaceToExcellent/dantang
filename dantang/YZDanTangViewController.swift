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
 self.view.backgroundColor = UIColor.purpleColor()
        
        loadHomeInfo(4);
        // Do any additional setup after loading the view.
    }
    
    
    
    /// 获取首页数据
    func loadHomeInfo(id: Int) -> () {
        //  let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=20&offset=0"
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
            
                
                
                if let json = response.result.value {
                    print("HOMEJSON: \(json)")
                    
                    //接下来解析 
                }
                
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
