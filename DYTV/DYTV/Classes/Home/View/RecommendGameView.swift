//
//  RecommendGameView.swift
//  DYTV
//
//  Created by coderLL on 16/10/2.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

// MARK:- 定义常量
private let kGameCellID : String = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {

    // MARK:- 定义数据属性
    var groups : [AnchorGroup]? {
        didSet {
            // 1.移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            // 2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            // 3.重新刷新表格数据
            collectionView.reloadData()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 默认创建出来有autoresizingMask导致内外一起拉伸之后尺寸为0, 所以显示不出来
        // 解决方法: 设置控件不随父控件拉伸而拉伸
        autoresizingMask = .None
        
        // 注册cell
        collectionView.registerNib(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 给collectionView设置内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

// MARK:- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return NSBundle.mainBundle().loadNibNamed("RecommendGameView", owner: nil, options: nil).first as! RecommendGameView
    }
}

// MARK:- 遵循UICollectionViewDataSource数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 1.获取cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kGameCellID, forIndexPath: indexPath) as! CollectionViewGameCell
        
        // 2.取出数据模型
        let group = groups![indexPath.item]
        
        // 3.传递模型数据
        cell.group = group
        
        return cell
    }
}
