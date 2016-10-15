//
//  FunnyViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/15.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

// MARK:- 常量定义
private let kTopMargin : CGFloat = 10

class FunnyViewController : BaseAnchorViewController {
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
}

// MARK:- 设置UI布局
extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        // 1.设置头部的size为0
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        // 2.设置inset内边距
        self.collectionView.contentInset = UIEdgeInsets(top:kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension FunnyViewController {
    
    override func loadData() {
        // 1.给父类中ViewModel进行赋值
        self.baseVM = amuseVM
        
        self.amuseVM.loadFunnyData(method: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3") {
            // 2.1刷新表格数据
            self.collectionView.reloadData()
            
            // 2.2数据请求完成
            self.loadDataFinished()
        }
    }
}
