//
//  UILabel + Extension.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation

extension UILabel {
    /// 设置富文本
    ///
    /// - Parameters:
    ///   - ttext: 内容
    ///   - tolabel: 添加到的控件（UIlabel）
    ///   - withSuffixStr: 添加文本
    func setColorFultext(ttext : String,tolabel : UILabel,withSuffixStr : String,lenght : Int) -> Void {
        let ddd = ttext
        let amountText = NSMutableAttributedString.init(string: ddd + withSuffixStr)
        
        // set the custom font and color for the 0,1 range in string
        amountText.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 10 * SCREEN_SCALE),
                                  NSForegroundColorAttributeName: UIColor.colorWithHexString("447FD4")],
                                 range: NSMakeRange(ddd.characters.count, lenght))
        // if you want, you can add more attributes for different ranges calling .setAttributes many times
        
        // set the attributed string to the UILabel object
        tolabel.attributedText = amountText
    }
}
