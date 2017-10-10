//
//  Peroninfo_Three.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol Peroninfo_ThreeDelegate {
    func peroninfo_ThreePass(chooseSexInt : Int)
}
class Peroninfo_Three: CommonTableViewCell,PersonInfoSexVDelegate {
    func sexChooseDelegate(intIndex: Int) {
        self.peroninfo_ThreeDelegate?.peroninfo_ThreePass(chooseSexInt: intIndex)
    }
    
    var peroninfo_ThreeDelegate : Peroninfo_ThreeDelegate?
    
    lazy var personInfoThree_NameDescLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = UIColor.gray
        d.text = "性别"
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    
    lazy var sexV: PersonInfoSexV = {
        let d: PersonInfoSexV = PersonInfoSexV.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: 12.5, width: SCREEN_WIDTH * 0.45, height: 20))
        d.personInfoSexVDelegate = self
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(sexV)
        contentView.addSubview(personInfoThree_NameDescLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol PersonInfoSexVDelegate {
    func sexChooseDelegate(intIndex : Int)
}
class PersonInfoSexV: UIView {
    
    var personInfoSexVDelegate : PersonInfoSexVDelegate?
    
    var button : BtnWithTwoSide!
    
    var titles  : [String] = ["男","女"]
    
    var ccc = false
    
    var imgs : [String] = [] {
        didSet {
            if ccc == false {
                
                for i in 0..<self.imgs.count {
                    self.button = BtnWithTwoSide.init()
                    self.button.frame = CGRect(x: CGFloat(i) * self.bounds.width / 2, y: 0, width: self.bounds.width / 2, height: self.bounds.height)
                    self.button.addTarget(self, action: #selector(btnChanged(sender:)), for: .touchUpInside)
                    self.button.setTitle(titles[i], for: .normal)
                    self.button.setTitleColor(UIColor.black, for: .normal)
                    self.button.setImage(UIImage.init(named: imgs[i]), for: .normal)
                    self.button.tag = 100 + i
                    
                    if i == 1 {
                        ccc = true
                    }
                    addSubview(self.button)
                }
            }
            
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
    @objc func btnChanged(sender : UIButton) {
        
        
        let a = viewWithTag(100) as! UIButton
        let b = viewWithTag(101) as! UIButton
        if sender.tag == 100 {
            
            self.personInfoSexVDelegate?.sexChooseDelegate(intIndex: 0)
            
            a.setImage(UIImage.init(named: "sex_select"), for: .normal)
            b.setImage(UIImage.init(named: "sex_unselect"), for: .normal)
        }
        
        if sender.tag == 101 {
            self.personInfoSexVDelegate?.sexChooseDelegate(intIndex: 1)
            
            a.setImage(UIImage.init(named: "sex_unselect"), for: .normal)
            b.setImage(UIImage.init(named: "sex_select"), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BtnWithTwoSide : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .scaleAspectFit
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: self.bounds.width / 2, y: 0, width: self.bounds.width / 2, height: self.bounds.height)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0, width: self.bounds.width / 2, height: self.bounds.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

