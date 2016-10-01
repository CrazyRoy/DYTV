//
//  RecommendCycleView.swift
//  DYTV
//
//  Created by coderLL on 16/10/1.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class RecommendCycleView: UIView {

    // MARK:- 常量
    private let kCycleCellID = "kCycleCellID"
    
    // MARK:- 控件属性
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 定义属性
    var cycleTimer : NSTimer?
    
    var cycleModels : [CycleModel]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 3.默认滚动到中间某一个值
            let indexPath = NSIndexPath(forItem: (cycleModels?.count ?? 0) * 10, inSection: 0)
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
            
            // 4.添加定时器
            removeCycleTime()
            addCycleTimer()
        }
    }
    
    // MARK:- 系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 1.设置不随父控件拉伸而拉伸
        autoresizingMask = .None
        
        // 2.注册cell
        collectionView.registerNib(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 1.设置CollectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
    }
}

// MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return NSBundle.mainBundle().loadNibNamed("RecommendCycleView", owner: nil, options: nil).first as! RecommendCycleView
    }
}

// MARK:- 遵守UICollectionView数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return (self.cycleModels?.count ?? 0) * 1000
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.取到cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCycleCellID, forIndexPath: indexPath) as! CollectionViewCycleCell
        // 2.获取数据模型
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        // 3.设置数据模型
        cell.cycleModel = cycleModel
        
        return cell
    }
}

// MARK:- 遵循UICollectionView代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 1.获取滑动的偏移量
        let offsetX = scrollView.contentOffset.x
            
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int((offsetX / scrollView.bounds.width) + 0.5) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeCycleTime()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK:- 对定时器的操作方法
extension RecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
    }
    
    private func removeCycleTime() {
        cycleTimer?.invalidate()    // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetx = collectionView.contentOffset.x
        let offsetX = currentOffsetx + collectionView.bounds.width
        
        // 2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
