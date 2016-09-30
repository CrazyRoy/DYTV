//
//  AnchorModel.swift
//  DYTV
//
//  Created by coderLL on 16/10/1.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    // 房间ID
    var room_id : Int = 0
    // 房间图片对应的URLString
    var vertical_src : String = ""
    // 判断是手机直播还是电脑直播
    // 0: 电脑直播 1: 手机直播
    var isVertical : Int = 0
    // 房间名称
    var room_name : String = ""
    // 主播昵称
    var nickname : String = ""
    // 观看人数
    var online : Int = 0
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
