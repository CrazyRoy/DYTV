//
//  CollectionViewCycleCell.swift
//  DYTV
//
//  Created by coderLL on 16/10/2.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCycleCell: UICollectionViewCell {

    // MARK:- 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            if let iconURL = URL(string: cycleModel?.pic_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            }
        }
    }
    
    // MARK:- 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
