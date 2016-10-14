//
//  AmuseMenuView.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/15.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

// MARK:- 常量定义
private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    
    // MARK: 定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: 从Xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 注册单元格
        self.collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置每个cell的尺寸
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.collectionView.bounds.size
    }
}

// MARK:- 快速创建view的方法
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

// MARK:- 遵守UICollectionView的数据源方法
extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.groups == nil { return 0 }
        
        let pageNum = (groups!.count - 1) / 8 + 1
        self.pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        // 2.设置模型数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    // 根据cell设置数据模型
    private func setupCellDataWithCell(cell : AmuseMenuViewCell, indexPath : IndexPath) {
        // 0....7
        // 8....15
        // 16...23
        
        // 1.取出起始位置和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2.判断是否越界
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        // 3.取出模型, 并赋值给cell
        cell.groups = Array(self.groups![startIndex...endIndex])
        
    }
}

// MARK:- 遵守UICollectionView的代理方法
extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         pageControl.currentPage = Int(CGFloat(scrollView.contentOffset.x / scrollView.bounds.width) + 0.5)
    }
}
