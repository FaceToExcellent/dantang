//
//  HomeViewCell.swift
//  dantang
//
//  Created by HYZ on 16/9/23.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Kingfisher
class HomeViewCell: UITableViewCell {
    var myimageView = UIImageView()
    var mytitle = UILabel()
    
    let wb = (UIScreen.main.bounds.width) / 750
    let hb = UIScreen.main.bounds.height / 1334
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: String?.none)
        self.makeCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func  makeCellUI(){
        
        // 15 720 * 290 
        myimageView.frame = CGRect.init(x: 15*wb, y:15*hb, width:720*wb, height: 290*hb)
        self .addSubview(myimageView)
        
        mytitle.frame = CGRect.init(x: 20*wb, y:260*hb, width: 690*wb, height: 30*hb)
        mytitle.textAlignment = .left
        mytitle.textColor = UIColor.white
        mytitle.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(mytitle)
        
        
    }
    
    func setDate(model:Homeinnermodel){
        let url = URL(string: model.cover_image_url!)
        self.myimageView.kf.setImage(with: url)
        self.mytitle.text = model.title
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
