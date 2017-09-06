//
//  TestVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/1.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  测试控制器

import UIKit

class TestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.backgroundColor = UIColor.white
    }
    
    lazy var payV: ChagrgeV = {
        let d: ChagrgeV = ChagrgeV.init(frame: CGRect.init(x: 0, y: 0, width: 250 * SCREEN_SCALE, height: (250 * SCREEN_SCALE) * 1.15))
        return d
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.keyWindow?.addSubview(payV)
        payV.center = (UIApplication.shared.keyWindow?.center)!
    }

    lazy var xxx: CYDetailSelectV = {
        let d : CYDetailSelectV = CYDetailSelectV.init(["sss","xxx","嘻嘻嘻"], ["","",""], self.view.bounds)
        return d
    }()
}


