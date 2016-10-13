//
//  AmuseViewModel.swift
//  DYTV
//
//  Created by CodeLL on 2016/10/13.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class AmuseViewModel {
    
    var anchors : [AnchorGroup] = [AnchorGroup]()
    
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/getHotRoom/2") { (result) in
         
            // 1.对结果进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArr = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.遍历数组中的字典
            for dict in dataArr {
                let amuse = AnchorGroup(dict: dict)
                self.anchors.append(amuse)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
