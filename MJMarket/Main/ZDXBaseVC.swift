//
//  ZDXBaseVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class ZDXBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if NSStringFromClass(self.classForCoder).contains("RigisterVC") {
            
            let navBar = navigationController?.navigationBar
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
    }

}
