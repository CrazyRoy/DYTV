//
//  BaseViewModel.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/14.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class BaseViewModel {

     lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

// MARK:- 请求数据
extension BaseViewModel {
    
    // MARK:- 请求推荐、娱乐模块主播数据
    func loadAnchorData(method : MethodType, URLString : String, parameters: [String : Any]? = nil, finishedCallback: @escaping () -> ()) {
        
        NetworkTools.requestData(method, URLString: URLString, parameters: parameters) { (result) in
            
            // 1.对结果进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArr = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.遍历数组中的字典
            for dict in dataArr {
                let amuse = AnchorGroup(dict: dict)
                self.anchorGroups.append(amuse)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
    
    // MARK:- 请求趣玩模块主播数据
    func loadFunnyData(method : MethodType, URLString : String, parameters: [String : Any]? = nil, finishedCallback: @escaping () -> ()) {
        
        NetworkTools.requestData(method, URLString: URLString, parameters: parameters) { (result) in
            
            // 1.对结果进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArr = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.遍历数组中的字典
            // 2.1创建AnchorGroup
            let anchorGroup = AnchorGroup()
            // 2.1添加Anchor
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                anchorGroup.anchors.append(anchor)
            }
            // 2.3将AnchorGroup添加到anchorGroups
            self.anchorGroups.append(anchorGroup)
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
