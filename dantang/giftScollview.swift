//
//  giftScollview.swift
//  dantang
//
//  Created by HYZ on 16/10/20.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Kingfisher
class giftScollview: UIView,UIScrollViewDelegate {
    
    
    let scrollview = UIScrollView()
    var dataArray  = NSArray()
    var page :Int! = 0
    
    var repeatTimer  = Timer()
  
      override init(frame: CGRect) {
      super.init(frame: frame)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(model:giftInnerModel){
        repeatTimer.invalidate()
        page = 0
        MakeUI()
        LoadData(model: model)
        timerCLick()
    }
    
    
    func LoadData(model:giftInnerModel){
        
        
        loadData2(model: model)
        MakeUI()
        timerCLick()
    }
    
    
    func loadData2(model:giftInnerModel){
        
        let w  = Int(self.frame.size.width)
        self.dataArray = model.image_urls!
        
        //print(model.image_urls?.object(at: 0))
        self.scrollview.contentSize  = CGSize.init(width: (self.dataArray.count  + 2)*w, height: 0)
        
        var url : String!
        for i in 0 ..<  (self.dataArray.count + 2){
            if i == dataArray.count + 1 || i == 1 {
                url = String(describing: self.dataArray.object(at: 0))
            }else if i==0 {
                
                 url = String(describing: self.dataArray.object(at: dataArray.count - 1))
            
            }else
            {
                 url = String(describing: self.dataArray.object(at:i - 1))
            }
            
            
            self.scrollview.addSubview(self.createImageView(imageUrl: url, num: i))
            
        }
        let contentOffset: CGPoint = self.scrollview.contentOffset
        self.scrollview.setContentOffset(CGPoint.init(x: w, y: Int(contentOffset.y)), animated: true)
        
        if dataArray.count == 1 {
            self.scrollview.isScrollEnabled = false
            
        }
        
        
    }
    
    func createImageView(imageUrl: String,num: Int) ->UIImageView
    {
         let w  = Int(self.frame.size.width)
        let image = UIImageView()
        image.frame = CGRect.init(x: num*w, y: 0, width: w, height: w)
        
         let url = URL(string: imageUrl)
        image.kf.setImage(with: url)
        image.tag = num
        
        return image
        
        
    }
    
    func MakeUI(){
        
        scrollview.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.width)
        scrollview.backgroundColor = UIColor.white
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator   = false
        scrollview.isPagingEnabled = true
        scrollview.delegate = self
        self .addSubview(scrollview)
        
        
    }
    
    func timerCLick(){
            repeatTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(giftScollview.loadNextPageImage), userInfo: nil, repeats: true)
            
       
    }
    func loadNextPageImage(){
        repeatTimer.tolerance = 1
        let contentOffset:CGPoint = self.scrollview.contentOffset
        let  nextPage:Int =  page + 2
        let  w:Int   = nextPage * Int(self.frame.size.width)
        self.scrollview.setContentOffset(CGPoint.init(x: w, y: Int(contentOffset.y)), animated: true)
        
        
        
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let W  = self.frame.size.width
        if scrollview.contentOffset.x > scrollview.contentSize.width-W-W {
            let contentOffset:CGPoint  = self.scrollview.contentOffset
            self.scrollview.setContentOffset(CGPoint.init(x: W, y: contentOffset.y), animated: false)
        }
        
        if scrollview.contentOffset.x < W {
             let contentOffset:CGPoint  = self.scrollview.contentOffset
            self.scrollview.setContentOffset(CGPoint.init(x: scrollView.contentSize.width-W-W, y: contentOffset.y), animated: false)
        }
        
        let orignX  = (scrollview.contentOffset.x - W)/scrollView.frame.size.width
        page = Int(orignX)
        
        repeatTimer.invalidate()
        
        self.timerCLick()
        
        
    }
   
}

















