//
//  UITableView+Extension.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/27.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation


extension UITableView {
    func scrollToBottom(animated: Bool = false) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        self.scrollToRow(at: NSIndexPath.init(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: false)
    }

//    func scrollToBottom(animated: Bool) {
//        var yOffset: CGFloat = 0
//        //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
//        if self.contentSize.height > self.bounds.size.height {
//            yOffset = self.contentSize.height - self.bounds.size.height
//        }
//        self.setContentOffset(CGPoint(x: 0, y: yOffset), animated: animated)
//    }
}

