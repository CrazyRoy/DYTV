//
//  UIBarButtonItem+Extension.swift
//  DYTV
//
//  Created by coderLL on 16/9/16.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // 便利构造函数
    convenience init(imageName: String, highImageName: String, size: CGSize = CGSizeZero) {
        
        // 1.创建UIButton
        let btn = UIButton();
        
        // 2.设置btn的图片
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if(highImageName != "") {
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSizeZero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        
        // 4.创建UIBarButtonItem
        self.init(customView: btn)
    }
}
