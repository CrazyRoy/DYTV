//
//  CollectionViewGameCell.swift
//  DYTV
//
//  Created by coderLL on 16/10/2.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewGameCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            guard let group = group else { return }
            titleLabel.text = group.tag_name
            let iconURL = NSURL(string: group.icon_url)!
            iconImageView.kf_setImageWithURL(iconURL, placeholderImage: UIImage(named: "home_more_btn"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
