//
//  giftdetailTableViewCell.swift
//  dantang
//
//  Created by HYZ on 16/11/2.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class giftdetailTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: String?.none)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
