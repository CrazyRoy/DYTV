//
//  BaseAnchorViewController.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/15.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

// MARK:- 常量
let kItemMargin : CGFloat = 10
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3
let kHeaderViewH : CGFloat = 50

let kNormalCellID = "kNormalCellID"
let kHeaderViewID = "kHeaderViewID"
let kPrettyCellID = "kPrettyCellID"

class BaseAnchorViewController: BaseViewController {

    // MARK:- 懒加载属性
    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
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
        self.loadData()
    }
}

// MARK:- 设置UI界面
extension BaseAnchorViewController {
    override func setupUI() {
        // 1.给父类中的内容view引用进行赋值
        self.baseContentView = collectionView
        
        // 2.添加collectionView
        self.view.addSubview(collectionView)
        
        // 3.调用父类的setupUI()
        super.setupUI()
    }
}


// MARK:- 请求数据
extension BaseAnchorViewController {
    func loadData() {
    }
}

// MARK:- 遵守UICollectionViewDelegate, UICollectionViewDataSource
extension BaseAnchorViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return self.baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = self.baseVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        
        // 2.取出模型对象
        let anchor = self.baseVM.anchorGroups[(indexPath as NSIndexPath).section].anchors[(indexPath as NSIndexPath).item]
        
        // 4.将模型赋值给cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.取出模型赋值
        let group = self.baseVM.anchorGroups[(indexPath as NSIndexPath).section]
        headerView.group = group
        
        return headerView
    }
}

// MARK:- 遵守UICollectionView的代理协议

extension BaseAnchorViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 1.取出对应的主播信息
        let anchor = self.baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        // 2.判断是主播房间还是秀场房间
        anchor.isVertical == 0 ? pushNormalRoomVc(anchor) : presentShowRoomVc(anchor)
    }
    
    func pushNormalRoomVc(_ anchor : AnchorModel) {
        // 1.创建normalRoomVc
        let normalRoomVc = RoomNormalViewController()
        
        // 2.传递数据模型
        normalRoomVc.anchor = anchor
        
        // 3.以push方式推出
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
    
    func presentShowRoomVc(_ anchor : AnchorModel) {
        // 1.创建ShowRoomVc
        let showRoomVc = RoomShowViewController()
        
        // 2.传递数据模型
        showRoomVc.anchor = anchor
        
        // 3.以modal方式弹出
        present(showRoomVc, animated: true, completion: nil)
    }
}

