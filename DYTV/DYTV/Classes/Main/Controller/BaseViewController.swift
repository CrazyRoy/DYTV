//
//  BaseViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/15.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK:- 定义属性
    var baseContentView : UIView?

    // MARK:- 懒加载属性
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "home_header_normal"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "home_header_normal")!, UIImage(named: "home_header_hot")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }

}

// MARK:- 添加UI界面
extension BaseViewController {
    
    // MARK:- 设置UI界面
    func setupUI() {
        
        // 1.先隐藏内容的view
        self.baseContentView?.isHidden = true
        
        // 2.添加执行动画的UIImageView
        self.view.addSubview(animImageView)
        
        // 3.给UIImageView执行动画
        self.animImageView.startAnimating()
        
        // 4.设置背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    // MARK:- 数据请求完成
    func loadDataFinished() {
        // 1.停止动画
        self.animImageView.stopAnimating()
        
        // 2.隐藏animImageView
        self.animImageView.isHidden = true
        
        // 3.显示内容的view
        self.baseContentView?.isHidden = false
    }
}
