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
    var baseGame : BaseGameModel? {
        didSet {
            guard let game = baseGame else { return }
            titleLabel.text = game.tag_name
            if let iconURL = URL(string: game.icon_url) {
                iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
            }else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
