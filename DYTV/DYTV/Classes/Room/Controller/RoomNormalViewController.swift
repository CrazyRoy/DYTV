//
//  RoomNormalViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/15.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController , UIGestureRecognizerDelegate{
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1.隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 1.显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK:- 添加UI控件
extension RoomNormalViewController {
    
    fileprivate func setupUI() {
        
        // 1.设置背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        
        // 2.添加蒙版
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 240)
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

