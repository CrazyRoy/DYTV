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

}
