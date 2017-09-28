//
//  ZDXBaseViewController.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class ZDXBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
}
