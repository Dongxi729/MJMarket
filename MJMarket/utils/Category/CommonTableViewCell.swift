//
//  CommonTableViewCell.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        /// 延长系统自带分割线
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
