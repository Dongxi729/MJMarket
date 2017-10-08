//
//  PersonFooV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit


protocol PersonFooVDelegate {
    func personBtnSEL()
}
// MARK: - 表格尾部
class PersonFooV : UIView {
    
    var personFooVDelegate : PersonFooVDelegate?
    
    lazy var personInfo_footerV: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: COMMON_MARGIN, y: 0, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 35 * SCREEN_SCALE))
        d.backgroundColor = COMMON_COLOR
        d.setTitle("保存", for: .normal)
        d.addTarget(self, action: #selector(personSaveSEL), for: .touchUpInside)
        d.layer.cornerRadius = 17.5
        return d
    }()
    
    @objc private func personSaveSEL() {
        self.personFooVDelegate?.personBtnSEL()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(personInfo_footerV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}