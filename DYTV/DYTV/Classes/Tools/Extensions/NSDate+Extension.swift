//
//  NSDate+Extension.swift
//  DYTV
//
//  Created by coderLL on 16/10/1.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
