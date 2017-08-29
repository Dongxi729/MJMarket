//
//  UnderLineLabel.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

//  带下划线的label

import UIKit

// MARK: - https://stackoverflow.com/questions/28053334/how-to-underline-a-uilabel-in-swift
class UnderLineLabel : UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
