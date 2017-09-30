//
//  MyCellOne.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的第二行视图

import UIKit

class MyCellOneV: UIView {
    
    /// 金额
    lazy var myCellMoneyLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height * 0.5))
        d.text = "￥" + "0"
        d.font = UIFont.systemFont(ofSize: 15)
        d.textColor = COMMON_COLOR
        d.textAlignment = .center
        return d
    }()
    
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.Height * 0.5, width: self.Width, height: self.Height * 0.5))
        
        d.font = UIFont.systemFont(ofSize: 15)
        d.textColor = FONT_COLOR
        d.textAlignment = .center
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myCellMoneyLabel)
        addSubview(descLabel)
        
        
        
        if ((AccountModel.shareAccount()?.money) != nil) {
            CCog(message: AccountModel.shareAccount()?.money)
            DispatchQueue.main.async {
                self.myCellMoneyLabel.text = "￥" + ((AccountModel.shareAccount()?.money as? NSNumber)?.stringValue)!
            }
        } else {
            CCog(message: AccountModel.shareAccount()?.money)
            myCellMoneyLabel.text = "￥" + "0"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


protocol MyCellOneDelegate {
    func chargeDelegateSEL()
    func jifenSEL()
}

class MyCellOne: CommonTableViewCell {
    
    var myCellOneDelegate : MyCellOneDelegate?
    
    lazy var leftV: MyCellOneV = {
        let d: MyCellOneV = MyCellOneV.init(frame: CGRect.init(x: 0, y: 8, width: SCREEN_WIDTH * 0.5, height: self.Height))
        d.myCellMoneyLabel.text = "￥" + "0"
        d.descLabel.text = "余额"
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(rechageSEL))
        d.isUserInteractionEnabled = true
        d.addGestureRecognizer(tapGes)
        return d
    }()
    
    func rechageSEL() {
        self.myCellOneDelegate?.chargeDelegateSEL()
    }
    
    func jifen(){
        self.myCellOneDelegate?.jifenSEL()
    }
    
    /// 分割线
    private lazy var seperateLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 0.75, y: 8, width: 1.5, height: self.Height))
        d.backgroundColor = UIColor.colorWithHexString("EBEAEB")
        return d
    }()
    
    lazy var rightV: MyCellOneV = {
        let d: MyCellOneV = MyCellOneV.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5, y: 8, width: SCREEN_WIDTH * 0.5, height: self.Height))
        d.myCellMoneyLabel.text = "10"
        d.descLabel.text = "积分"
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(jifen))
        d.isUserInteractionEnabled = true
        d.addGestureRecognizer(tapGes)
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftV)
        contentView.addSubview(rightV)
        contentView.addSubview(seperateLine)
        
        DispatchQueue.main.async {
        
            if ((AccountModel.shareAccount()?.scores) != nil) {
            
                self.rightV.myCellMoneyLabel.text = (AccountModel.shareAccount()?.scores as? NSNumber)?.stringValue
            } else {
                self.rightV.myCellMoneyLabel.text = "0"
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
