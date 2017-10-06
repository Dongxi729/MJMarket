//
//  ZDXAlertController.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/6.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation

/// 为UIAlertController添加字体颜色
class ZDXAlertController: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addAction(_ action: UIAlertAction) {
        super.addAction(action)
        //通过tintColor实现按钮颜色的修改。
        self.view.tintColor = COMMON_COLOR
        //也可以通过设置 action.setValue 来实现
        //action.setValue(UIColor.orange, forKey:"titleTextColor")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
