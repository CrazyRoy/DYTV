//
//  RecommendViewController.swift
//  DYTV
//
//  Created by coderLL on 16/9/28.
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

class RecommendViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var recommendVm : RecommendViewModel = RecommendViewModel()
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
    fileprivate lazy var recommendCycleView : RecommendCycleView = {
       let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
        // 发送网络请求
        loadData()
    }
}

// MARK:- 设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI() {
        // 1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        
        // 2.将cycleView添加到UICollectionView中
        collectionView.addSubview(recommendCycleView)
        
        // 3.将gameView添加到UICollectionView中
        collectionView.addSubview(gameView)
        
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension RecommendViewController {
    fileprivate func loadData() {
        // 1.请求推荐数据
        recommendVm.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给gameView
            self.gameView.groups = self.recommendVm.anchorGroups
        }
        
        // 2.请求无线轮播数据
        recommendVm.requestCycleData { 
            self.recommendCycleView.cycleModels = self.recommendVm.cycleModels
        }
    }
}

// MARK:- 遵守UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVm.anchorGroups[section]
        return group.anchors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVm.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出模型对象
        let group = recommendVm.anchorGroups[(indexPath as NSIndexPath).section]
        let anchor = group.anchors[(indexPath as NSIndexPath).item]
        
        // 2.定义Cell
        let cell : CollectionBaseCell!
        
        // 3.取出Cell
        if (indexPath as NSIndexPath).section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        }
        
        // 4.将模型赋值给cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.取出模型
        let group = recommendVm.anchorGroups[(indexPath as NSIndexPath).section]
        headerView.group = group
        
        return headerView
    }
}

// MARK:- 遵守UICollectionViewDelegateFlowLayout
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath as NSIndexPath).section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else {
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
}
