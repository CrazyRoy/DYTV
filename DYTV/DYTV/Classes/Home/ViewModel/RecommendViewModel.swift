//
//  RecommendViewModel.swift
//  DYTV
//
//  Created by coderLL on 16/10/1.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    
    // MARK:- 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    
    // 请求推荐数据
    func requestData(_ finishCallback : @escaping () -> ()) {
        // 1.定义参数
        let paramters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        // 2.创建Group
        let dGroup = DispatchGroup()
        
        // 3.请求第一部分的推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: paramters) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key, 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 3.遍历字典,并且转成模型数组
            // 3.1设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }

            // 3.3离开组
            dGroup.leave()
        }
        
        // 4.请求第二部分的颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: paramters) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key, 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]]else {return}
            
            // 3.遍历字典,并且转成模型数组
            // 3.1设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"

            // 3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3离开组
            dGroup.leave()
        }
        
        // 5.请求2-12部分的游戏数据
        dGroup.enter()
        loadAnchorData(method: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: paramters) {
            // 1.离开组
            dGroup.leave()
        }
        
        // 6.所有的数据都请求道, 对所有的数据进行排序
        dGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            // 完成回调
            finishCallback()
        }
    }
    
    // 请求无限轮播数据
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key, 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            // 回调闭包
            finishCallback()
        }
    }
}
