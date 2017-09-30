//
//  MineModel.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class MineModel: NSObject {
    static var chooseImgData : UIImage?

    /// 名字
    static var nameString: String = {
        var d : String = ""
        
        if let xx = AccountModel.shareAccount()?.nickname as? String {
            d = xx
        } else {
            d = ""
        }
        
        return d
    }()
    
    static var signMent = false
    
}
