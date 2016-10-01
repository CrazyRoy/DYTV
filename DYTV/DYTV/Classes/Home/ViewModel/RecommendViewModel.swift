//
//  RecommendViewModel.swift
//  DYTV
//
//  Created by coderLL on 16/10/1.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    // MARK:- 懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    
    // 请求推荐数据
    func requestData(finishCallback : () -> ()) {
        // 1.定义参数
        let paramters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        // 2.创建Group
        let dGroup = dispatch_group_create()
        
        // 3.请求第一部分的推荐数据
        dispatch_group_enter(dGroup)
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: paramters) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key, 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]]else {return}
            
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
            dispatch_group_leave(dGroup)
        }
        
        // 4.请求第二部分的颜值数据
        dispatch_group_enter(dGroup)
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: paramters) { (result) in
            
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
            dispatch_group_leave(dGroup)
        }
        
        // 5.请求2-12部分的游戏数据
        dispatch_group_enter(dGroup)
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: paramters) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key, 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历数组, 获取字典, 并且将字典转成模型数组
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            // 4.离开组
            dispatch_group_leave(dGroup)
        }
        
        // 6.所有的数据都请求道, 对所有的数据进行排序
        dispatch_group_notify(dGroup, dispatch_get_main_queue()) { 
            self.anchorGroups.insert(self.prettyGroup, atIndex: 0)
            self.anchorGroups.insert(self.bigDataGroup, atIndex: 0)
            
            finishCallback()
        }
    }
    
    // 请求无限轮播数据
    func requestCycleData(finishCallback : () -> ()) {
        NetworkTools.requestData(.GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
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
