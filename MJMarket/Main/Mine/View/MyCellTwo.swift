//
//  MyCellTwo.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol MyCellTwoDelegate {
    func btnCli(sender : UIButton)
}

class MyCellTwo: CommonTableViewCell {
    var myCellTwoDelegate : MyCellTwoDelegate?
    
    var btnWithRed : BtnWithRedMark = BtnWithRedMark()
    
    
    var redBtn = UIButton()
    
    
    private var myCellTwoTitls : [String] = ["全部订单","待收货","待评价","代付款","退款/售后"]
    
    /// 图片名字
    private var imgsName : [String] = ["full_order","wait_payment","wait_receiver","wait_evaluate","refund_after"]
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        for value in 0..<myCellTwoTitls.count {
            btnWithRed = BtnWithRedMark.init(frame: CGRect.init(x: CGFloat(value) * (SCREEN_WIDTH / 5), y: 0, width: SCREEN_WIDTH / 5, height: SCREEN_WIDTH / 5 * 0.8))
            btnWithRed.layer.borderWidth = 1
            btnWithRed.myInfoBtn.setTitle(myCellTwoTitls[value], for: .normal)
            btnWithRed.myInfoBtn.addTarget(self, action: #selector(btnSEl(sender:)), for: .touchUpInside)
            btnWithRed.myInfoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)

            btnWithRed.myInfoBtn.setImage(UIImage.init(named: imgsName[value]), for: .normal)
            contentView.addSubview(btnWithRed)
            
        }
    }
    
    func xxx(dss : [String]) {
        
        for value in 0..<dss.count {
            
            let str : Int = Int(dss[value])!
            
            redBtn = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.1 + (CGFloat(value) * (SCREEN_WIDTH / 5)), y: 0, width: SCREEN_WIDTH / 16, height: SCREEN_WIDTH / 16))
            redBtn.backgroundColor = COMMON_COLOR
            redBtn.layer.cornerRadius = redBtn.Width / 2
            redBtn.clipsToBounds = true
            
            redBtn.setTitle(String(str), for: .normal)
            
            contentView.addSubview(redBtn)
            
            if str <= 0 {
                redBtn.isHidden = true
            }
            
        }
    }
    
    func btnSEl(sender : UIButton) {
        self.myCellTwoDelegate?.btnCli(sender: sender)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BtnWithRedMark: UIView {
    
    
    
    lazy var myInfoBtn: SeparateBtn = {
        let d: SeparateBtn = SeparateBtn.init(frame: CGRect.init(x: self.Width * 0.1, y: self.Width * 0.125, width: self.Width * 0.85, height: self.Height * 0.85))
        d.setTitle("廍订单", for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        d.setTitleColor(FONT_COLOR, for: .normal)
        d.setImage(#imageLiteral(resourceName: "correct"), for: .normal)
        return d
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        myInfoBtn.center = self.center
        addSubview(myInfoBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
