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
        let d : CountDownBtnTwo = CountDownBtnTwo.init(frame: CGRect.init(x: SCREEN_WIDTH - 60 - 3 * COMMON_MARGIN, y: UIApplication.shared.statusBarFrame.height + COMMON_MARGIN * 3, width: 60, height: 30))
        d.initwith(color: .clear, title: "", superView: d, titleColor: UIColor.colorWithHexString("646464"))
        d.layer.borderWidth = 1
        d.layer.borderColor = UIColor.colorWithHexString("646464").cgColor
        d.layer.cornerRadius = 5
        return d
    }()
    
    lazy var lauchImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: self.view.bounds)
        d.contentMode = .scaleToFill
        d.image = UIImage.init(named: "4-lauchImg")
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(lauchImg)
        view.addSubview(countDownBtn)
        view.backgroundColor = UIColor.white
    }
    
}
