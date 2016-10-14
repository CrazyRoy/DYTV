
//
//  AmuseViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/13.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
        
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // 请求数据
        self.loadAmuseData()
    }
}

// MARK:- 设置UI界面
extension AmuseViewController {
    
}

// MARK:- 请求数据
extension AmuseViewController {
    fileprivate func loadAmuseData() {
        
        // 1.给父类中ViewModel进行赋值
        self.baseVM = self.amuseVM
        
        self.amuseVM.loadAmuseData {
            // 刷新表格数据
            self.collectionView.reloadData()
        }
    }
}

