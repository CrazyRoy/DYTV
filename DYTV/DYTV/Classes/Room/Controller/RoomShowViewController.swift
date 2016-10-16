//
//  RoomShowViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/15.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class RoomShowViewController: UIViewController {

    // MARK:- 定义属性
    var maskImageView : UIImageView!
    
    // MARK:- 定义模型属性
    var anchor: AnchorModel?
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        dismiss(animated: true, completion: nil)
    }
}


// MARK:- 添加UI控件
extension RoomShowViewController {
    
    fileprivate func setupUI() {
        
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = imageView.bounds
        imageView.addSubview(effectView)
        
        // 1.设置蒙版图片
        guard let icon_URL = URL(string: (self.anchor?.vertical_src)!) else { return }
        
       imageView.kf.setImage(with: icon_URL)
        
        self.maskImageView = imageView
        
        view.addSubview(self.maskImageView)
    }
}
