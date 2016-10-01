//
//  CollectionViewNormalCell.swift
//  DYTV
//
//  Created by coderLL on 16/9/29.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewNormalCell: CollectionBaseCell {
    
    // MARK:- 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK:- 定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            
            // 2.设置房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
