//
//  RoomNormalViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/15.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController , UIGestureRecognizerDelegate{
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = UIColor.orange
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1.隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 2.设置依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 1.显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
