//
//  YZProductViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Alamofire
class YZProductViewController: UIViewController {
    let limit:Int = 1
    var offset:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
        
        loaddanpinData()
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
                    print(dict)
                
            }
            
        }
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
