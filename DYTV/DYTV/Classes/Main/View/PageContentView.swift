//
//  PageContentView.swift
//  DYTV
//
//  Created by coderLL on 16/9/28.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    // MARK:- 定义属性
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController
    
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()

    // MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        // 设置UI界面
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置UI界面
extension PageContentView {
    
    private func setupUI() {
        // 1.将所有的控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController.addChildViewController(childVc)
        }
        
        // 2.添加UICollectionView, 用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- 遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         print(self.childVcs.count)
         return self.childVcs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ContentCellID, forIndexPath: indexPath)
        
        // 2.给Cell设置内容
        // 2.1 由于循环利用, 避免循环添加, 先删除所有的子视图
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}