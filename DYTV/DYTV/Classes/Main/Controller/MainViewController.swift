//
//  MainViewController.swift
//  DYTV
//
//  Created by coderLL on 16/9/16.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加子控制器
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Fellow")
        addChildVc("Profile")
        print("\(childViewControllers.count)")
    }
    
    func addChildVc(sbName: String) {
        
        // 1. 通过storyboard加载子控制器
        let sbVc = UIStoryboard(name: sbName, bundle: nil).instantiateInitialViewController()!
        
        // 2. 将sbVc添加为子控制器
        addChildViewController(sbVc)
    }
}
