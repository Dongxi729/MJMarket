//
//  LauchVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/11/10.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class LauchVC: UIViewController {

    lazy var countDownBtn: CountDownBtnTwo = {
        let d : CountDownBtnTwo = CountDownBtnTwo.init(frame: CGRect.init(x: SCREEN_WIDTH - 100 - 2 * COMMON_MARGIN, y: COMMON_MARGIN, width: 100, height: 50))
        d.initwith(color: .orange, title: "", superView: d, titleColor: UIColor.red)
        d.layer.cornerRadius = 5
        
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(countDownBtn)
        view.backgroundColor = UIColor.white
    }
    
}
