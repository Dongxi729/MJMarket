//
//  TestVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/1.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  测试控制器

import UIKit

class TestVC: UIViewController,ChagrgeVDelegate {

    lazy var texttf: UITextFiledForMoney = {
        let d : UITextFiledForMoney = UITextFiledForMoney.init(2, CGRect.init(x: 0, y: 300, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.3))
        d.layer.borderWidth = 1
        return d
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

//        let payV = ChagrgeV.init(CGRect.init(x: 0, y: 0, width: 250, height: (250) * 1.15))
//        payV.chagrgeVDelegate = self
//        
//        UIApplication.shared.keyWindow?.addSubview(payV)
//        payV.center = (UIApplication.shared.keyWindow?.center)!
        
        self.navigationController?.pushViewController(SecVC(), animated: true)
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



class SecVC: UIViewController {
    
    lazy var shareC: ShareV = {
        let d : ShareV = ShareV.init(CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 150))
        d.backgroundColor = COMMON_COLOR
        return d
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        UIView.animate(withDuration: 0.25) {
            
            self.shareC.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 150 - 64, width: SCREEN_WIDTH , height: 150)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        view.addSubview(shareC)
    }
}
