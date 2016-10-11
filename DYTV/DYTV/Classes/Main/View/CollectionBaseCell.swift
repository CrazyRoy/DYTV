//
//  CollectionBaseCell.swift
//  DYTV
//
//  Created by coderLL on 16/10/1.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    // MARK:- 定义模型属性
    var anchor: AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/1000))万人在线"
            } else {
                onlineStr = "\(anchor.online)人在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.设置封面图片
            guard let icon_URL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: icon_URL)
        }
    }
}
