//
//  Homeinnermodel.swift
//  dantang
//
//  Created by HYZ on 16/9/22.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class Homeinnermodel: NSObject {
    var content_url :String?
    var cover_image_url :String?
    var created_at :Int?
    var id_ : Int?
    var liked :Int?
    var likes_count :Int?
    var published_at :Int?
    var share_msg :String?
    var short_title :String?
    var title :String?
    var updated_at :Int?
    var url :String?
    func setHomeinnermodelData(data:NSDictionary) -> Homeinnermodel {
       let model =  Homeinnermodel()
        model.content_url = data["content_url"] as?String
        model.cover_image_url = data["cover_image_url"] as?String
        model.created_at = data["created_at"] as?Int
        model.id_ = data["id"] as?Int
        model.liked = data["liked"] as?Int
        model.likes_count = data["likes_count"] as?Int
        model.published_at = data["published_at"] as?Int
        model.share_msg = data["share_msg"] as?String
        model.short_title = data["short_title"] as?String
        model.title = data["title"] as?String
        model.updated_at = data["updated_at"] as?Int
        model.url = data["url"] as?String
        
        return model
    }
    
    
}
