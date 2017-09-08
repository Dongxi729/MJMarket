//
//  ShareV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  分享视图

import UIKit

class ShareV: UIView {
    
    var shareCellV : UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShareCell: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
