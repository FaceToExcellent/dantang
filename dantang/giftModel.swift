//
//  giftModel.swift
//  dantang
//
//  Created by HYZ on 16/10/18.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class giftModel: NSObject {
    var items:NSArray?
    var paging:String?
    func  setHomeModelData(data:NSDictionary)->Homemodel{
        let model =   Homemodel()
        let array = data["items"] as? NSArray
        let array2 = NSMutableArray()
        for i in 0  ..< array!.count  {
            
          //  let innermodel = Homeinnermodel().setHomeinnermodelData(data: array?.object(at: i) as! NSDictionary)
            
          //  array2.add(innermodel)
        }
        model.items = array2
        
        
        let dict = data["paging"] as? NSDictionary
        model.paging = dict?["next_url"] as? String
        return model
    }
}
