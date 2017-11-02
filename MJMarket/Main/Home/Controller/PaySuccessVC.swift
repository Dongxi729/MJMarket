//
//  PaySuccessVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  支付成功

import UIKit

class PaySuccessVC: WKViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadURL(urlStr: WEB_VIEW_ORDER_LIST)
        
//        let right : UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "right"), style: .plain, target: self, action: #selector(popTomain))
//        self.navigationItem.leftBarButtonItem = right
        AccountModel.popBack = true
    }
    
    @objc func popTomain() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
