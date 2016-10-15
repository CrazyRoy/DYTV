
//
//  AmuseViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/13.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

// MARK:- 常量定义
private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

// MARK:- 设置UI界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        // 将菜单的View添加到collectionView中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension AmuseViewController {
    
    // MARK:- 请求数据
    override func loadData() {
        // 1.给父类中ViewModel进行赋值
        self.baseVM = self.amuseVM
        
        self.amuseVM.loadAmuseData {
            // 1.刷新表格数据
            self.collectionView.reloadData()
            
            // 2.给菜单栏传递显示数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            // 3.数据请求完成
            self.loadDataFinished()
        }
    }
}

