//
//  SeparateBtn.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class SeparateBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12.5 * SCREEN_SCALE)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = FONT_COLOR
        self.titleLabel?.sizeToFit()
        self.imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height * 0.65)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0.75 * self.Height, width: self.Width, height: self.Height * 0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
