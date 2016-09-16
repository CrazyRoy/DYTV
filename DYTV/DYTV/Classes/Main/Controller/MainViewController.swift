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
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Fellow")
        addChildVc("Profile")
    }
    
    
    private func addChildVc(storyName : String) {
        // 1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        
        // 2.将childVc作为子控制器
        addChildViewController(childVc!)
    }
}
