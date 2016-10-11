//
//  CollectionViewPrettyCell.swift
//  DYTV
//
//  Created by coderLL on 16/9/29.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: CollectionBaseCell {

    // MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK:- 定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            
            // 3.所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
