//
//  myheadView.swift
//  dantang
//
//  Created by HYZ on 16/10/25.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit


protocol myheadViewDelegate: NSObjectProtocol {
    func myheadViewheadbuttonCLick()
}
class myheadView: UIView {

    let wb = (UIScreen.main.bounds.width) / 750
    let bgImage  = UIImageView()
    let headimage = UIButton()
    let messageButton  = UIButton()
    let setButton = UIButton()
    weak var delegate :myheadViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func makeUI(){
       bgImage.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        bgImage.image = UIImage.init(named: "Me_ProfileBackground")
       self.addSubview(bgImage)
        
    headimage.frame  = CGRect.init(x: (self.frame.size.width - 75)/2, y: (self.frame.size.height - 75)/2, width: 75, height: 75)
        headimage.addTarget(self, action: #selector(myheadView.headimageCLick), for: .touchDragInside)
    self.addSubview(headimage)
    headimage.setBackgroundImage(UIImage.init(named: "Me_AvatarPlaceholder_75x75_"), for: .normal)
    
    messageButton.frame  = CGRect.init(x: 30*wb, y: 70*wb, width: 40*wb, height: 40*wb)
     messageButton.setBackgroundImage(UIImage.init(named: "Me_message_20x20_"), for: .normal)
    self.addSubview(messageButton)
     
        
     setButton.frame  = CGRect.init(x:  self.frame.size.width - 70*wb, y: 70*wb, width: 40*wb, height: 40*wb)
         setButton.setBackgroundImage(UIImage.init(named: "Me_settings_20x20_"), for: .normal)
      self.addSubview(setButton)
        
    }
    
    
    
    func headimageCLick(){
        delegate?.myheadViewheadbuttonCLick()
    }
    
    
}
