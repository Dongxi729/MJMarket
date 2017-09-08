//
//  TestVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/1.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  测试控制器

import UIKit

class TestVC: UIViewController,ChagrgeVDelegate {
    
    lazy var shareVVV: ShareV = {
        let d : ShareV = ShareV.init(frame: CGRect.init(origin: CGPoint.init(x: 100, y: 100), size: CGSize.init(width: SCREEN_WIDTH * 0.6, height: 80)))
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(shareVVV)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let payV = ChagrgeV.init(CGRect.init(x: 0, y: 0, width: 250, height: (250) * 1.15))
        payV.chagrgeVDelegate = self
        
        UIApplication.shared.keyWindow?.addSubview(payV)
        payV.center = (UIApplication.shared.keyWindow?.center)!
    }

    // MARK: - ChagrgeVDelegate
    func selectChargeApp(_ selectType: Int) {
        CCog(message: selectType)
    }
    
    func selectChargeAppWithMoney(_ selectType: Int) {
        CCog(message: selectType)
    }
    
    
    lazy var xxx: CYDetailSelectV = {
        let d : CYDetailSelectV = CYDetailSelectV.init(["sss","xxx","嘻嘻嘻"], ["","",""], self.view.bounds)
        return d
    }()
}


