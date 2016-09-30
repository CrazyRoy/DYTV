//
//  NetworkTools.swift
//  DYTV
//
//  Created by coderLL on 16/10/1.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import Alamofire

// MARK:- 方法枚举类型
enum MethodType {
    case GET
    case POST
}

// MARK:- 网络请求工具类
class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : String]? = nil, finishedCallback: (result : AnyObject) -> ()) {
        
        // 1.获取类型
        let method = type == .GET ? Method.GET : Method.POST
        
        // 2.发送网络请求
        Alamofire.request(method, URLString, parameters: parameters).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            // 4.将结果回调出去
            finishedCallback(result: result)
        }
    }
}
