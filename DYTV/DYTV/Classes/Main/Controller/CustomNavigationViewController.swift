//
//  CustomNavigationViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/15.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置全屏pop手势
        setScreenPopGesture()
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK:- 设置全屏pop手势
extension CustomNavigationViewController {
    
    fileprivate func setScreenPopGesture() {
        // 1. 获取系统pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2. 获取系统手势添加到的view中
        guard let gesView = systemGes.view else { return }
        
        // 3. 获取target/action
        // 根据运行时获取所有的属性名称
//        var count : UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        
        // 3.1取出targets数组
        let targets = systemGes.value(forKey: "_targets") as? [AnyObject]
        
        // 3.2取出targets数组中的第一个target
        guard let targetObjc = targets?.first else { return }
        
        // 3.3取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.4取出action
        let action = Selector(("handleNavigationTransition:"))
        
        // 3.5创建自己的pop手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        // 3.6给创建的手势设置和系统手势一样的目标和操作, 达到系统pop的相同效果
        panGes.addTarget(target, action: action)
    }
}
