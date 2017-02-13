//
//  giftInnerModel.swift
//  dantang
//
//  Created by HYZ on 16/10/18.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import SwiftyJSON
class giftInnerModel: NSObject {
    var brand_id :String?
    var brand_order :Int?
    var category_id :String?
    var cover_image_url : String?
    var mydescription :String?
    var published_at :Int?
    var favorites_count :Int!
    var id_ :Int?
    var image_urls :NSArray?
    var is_favorite :Int?
    
    var name :String?
    var price :String?

    
    var purchase_url :String?
  
    var url :String?
    func setgiftinnermodelData(data:NSDictionary) -> giftInnerModel {
       // print(data)
        let data1:NSDictionary = (data["data"] as? NSDictionary)!
        let model =  giftInnerModel()
        model.brand_id = data1["brand_id"] as?String
         model.brand_order = data1["brand_id"] as?Int
         model.category_id = data1["category_id"] as?String
         model.cover_image_url = data1["cover_image_url"] as?String
        // model.created_at = data["created_at"] as?Int
         model.mydescription = data1["description"] as?String
        // model.editor_id = data["editor_id"] as?Int
        model.favorites_count = data1["favorites_count"] as! Int
         model.id_ = data1["id"] as?Int
         model.image_urls = data1["image_urls"] as?NSArray
         model.is_favorite = data1["is_favorite"] as?Int
         model.name = data1["name"] as?String
         model.price = data1["price"] as?String
        model.purchase_url = data1["purchase_url"] as?String
        model.url = data1["url"] as?String
        
        
        
        return model;
        
    }

    
}
