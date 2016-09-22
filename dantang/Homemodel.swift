//
//  Homemodel.swift
//  dantang
//
//  Created by HYZ on 16/9/18.
//  Copyright © 2016年 HYZ. All rights reserved.
//
/*  {
 "content_url" = "http://dantang.liwushuo.com/posts/2792/content";
 "cover_image_url" = "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/151027/pktvp21vq.jpg-w720";
 "created_at" = 1451606400;
 "editor_id" = "<null>";
 id = 2792;
 labels =                 (
 );
 liked = 0;
 "likes_count" = 534;
 "published_at" = 1451606400;
 "share_msg" = "";
 "short_title" = "\U6700\U7f8e\U88c5\U9970\U706f";
 status = 0;
 template = "";
 title = "\U88c5\U9970\U706f\U767b\U573a\Uff0c\U6c14\U6c1bturn up\Uff01";
 type = post;
 "updated_at" = 1445937578;
 url = "http://dantang.liwushuo.com/posts/2792";
 },
*/

import UIKit


class Homemodel: NSObject {
var items:NSArray?
var paging:String?
    func  setHomeModelData(data:NSDictionary)->Homemodel{
    let model =   Homemodel()
        let array = data["items"] as? NSArray
        let array2 = NSMutableArray()
        for i in 0  ..< array!.count  {
            
            let innermodel = Homeinnermodel().setHomeinnermodelData(data: array?.object(at: i) as! NSDictionary)
            
            array2.add(innermodel)
        }
        model.items = array2
        
        
        let dict = data["paging"] as? NSDictionary
        model.paging = dict?["next_url"] as? String
      return model
    }

}

























