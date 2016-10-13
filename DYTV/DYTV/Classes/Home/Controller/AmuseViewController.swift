
//
//  AmuseViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/13.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

// MARK:- 常量
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"

class AmuseViewController: UIViewController {

    
    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0   // 行间距
        layout.minimumInteritemSpacing = kItemMargin  // Item之间的间距
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI界面
        self.setupUI()
        
        // 请求数据
        self.loadAmuseData()
    }
}

// MARK:- 设置UI界面
extension AmuseViewController {
    fileprivate func setupUI() {
        self.view.addSubview(collectionView)
    }
}

// MARK:- 请求数据
extension AmuseViewController {
    fileprivate func loadAmuseData() {
        self.amuseVM.loadAmuseData {
            // 刷新表格数据
            self.collectionView.reloadData()
        }
    }
}

// MARK:- 遵守UICollectionViewDelegate, UICollectionViewDataSource
extension AmuseViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
       return self.amuseVM.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = self.amuseVM.anchors[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出模型对象
        let group = self.amuseVM.anchors[(indexPath as NSIndexPath).section]
        let anchor = group.anchors[(indexPath as NSIndexPath).item]
        
        // 2.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        
        // 4.将模型赋值给cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.取出模型赋值
        let group = self.amuseVM.anchors[(indexPath as NSIndexPath).section]
        headerView.group = group
        
        return headerView
    }
}
