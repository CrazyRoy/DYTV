//
//  AppDelegate.swift
//  DYTV
//
//  Created by coderLL on 16/9/16.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 设置tabbar选中的主题颜色
        UITabBar.appearance().tintColor = UIColor.orangeColor();
        return true
    }
    
}

