//
//  ChagrgeV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/1.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  余额充值

import UIKit

class ChagrgeV: UIView {
    
    lazy var chargeTitleV: UIView = {
        
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height * 0.16))
        d.backgroundColor = COMMON_COLOR
        return d
    }()
    
    lazy var titleLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: self.chargeTitleV.bounds)
        d.text = "余额充值"
        d.textColor = .white
        d.textAlignment = .center
        return d
    }()
    
    lazy var secOne: ChagrgeOneV = {
        let d: ChagrgeOneV = ChagrgeOneV.init(frame: CGRect.init(x: 0, y: self.chargeTitleV.BottomY, width: self.Width, height: self.Height * 0.3))
        return d
    }()
    
    
    lazy var secTwoV: CYDetailSelectV = {
        let d : CYDetailSelectV = CYDetailSelectV.init(["微信支付","支付宝支付"], ["list_icon_wechat","list_icon_alipay"], CGRect.init(x: 0, y: self.secOne.BottomY, width: self.Width, height: self.Height * 0.35))
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.backgroundColor = UIColor.gray
        addSubview(chargeTitleV)
        chargeTitleV.addSubview(titleLabel)
        
        addSubview(secOne)
        addSubview(secTwoV)
        secTwoV.reloadTbv()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ChagrgeOneV: UIView {
    
    lazy var chagrgeTF: UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: COMMON_MARGIN * 2, y: COMMON_MARGIN * 0.5 * SCREEN_SCALE, width: self.Width - 4 * COMMON_MARGIN, height: 30 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.layer.borderColor = UIColor.colorWithHexString("F3F3F3").cgColor
        d.layer.cornerRadius = 5
        d.clipsToBounds = true
        d.placeholder = "请输入充值金额"
        return d
    }()
    
    lazy var autoTF: UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: COMMON_MARGIN * 2, y: self.chagrgeTF.BottomY * SCREEN_SCALE + COMMON_MARGIN, width: self.chagrgeTF.Width * 0.6, height: self.chagrgeTF.Height))
        d.layer.borderWidth = 1
        d.layer.borderColor = UIColor.colorWithHexString("F3F3F3").cgColor
        d.layer.cornerRadius = 5
        d.clipsToBounds = true
        d.placeholder = "请输入验证码"
        return d
    }()
    
    lazy var autoImgV: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: self.autoTF.RightX + COMMON_MARGIN * 0.5 * SCREEN_SCALE, y: self.autoTF.TopY, width: self.chagrgeTF.Width - self.autoTF.Width -  COMMON_MARGIN * 0.5 * SCREEN_SCALE , height: self.autoTF.Height))
        d.layer.borderWidth = 1
        return d
    }()
    
    lazy var seprLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 5, y: self.autoTF.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: self.Width - 10, height: 1))
        d.backgroundColor = UIColor.black
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chagrgeTF)
        addSubview(autoTF)
        addSubview(autoImgV)
        addSubview(seprLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CYDetailSelectV: UIView,UITableViewDelegate,UITableViewDataSource {
    
    private lazy var cy_selectTbV: UITableView = {
        let d : UITableView = UITableView.init(frame: self.bounds, style: .grouped)
        d.register(ZDXCheckDeskCellDown.self, forCellReuseIdentifier: "ZDXCheckDeskCellDown")
        d.delegate = self
        d.dataSource = self
        return d
    }()
    
    /// 标题
    private var titles = [String]()
    
    /// 图片名字
    private var imgsTitles = [String]()
    
    func reloadTbv() {
        self.cy_selectTbV.reloadData()
        addSubview(cy_selectTbV)
    }
    
    init(_ titles: [String],_ imgsName : [String],_ frame : CGRect) {
        super.init(frame: frame)
        self.titles = titles
        self.imgsTitles = imgsName
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZDXCheckDeskCellDown") as! ZDXCheckDeskCellDown
        cell.zdxCheckDeskCellDownHeadImg.image = UIImage.init(named: titles[indexPath.row])
        cell.zdxCheckDescCellDescLabel.text = titles[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func updateCellStatus(_ cell: ZDXCheckDeskCellDown, selected: Bool) {
        
        cell.zdxCDCheckImg.image = selected ? #imageLiteral(resourceName: "radio_white_s") : #imageLiteral(resourceName: "icon_big_gray")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.cellForRow(at: indexPath) as! ZDXCheckDeskCellDown
        updateCellStatus(cell, selected: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ZDXCheckDeskCellDown
        updateCellStatus(cell, selected: false)
        
        if indexPath.row == 0 {
            updateCellStatus(cell, selected: false)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ZDXCheckDeskCellDown: CommonTableViewCell {
    
    lazy var zdxCheckDeskCellDownHeadImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: 20, height: 20))
        
        return d
    }()
    
    lazy var zdxCheckDescCellDescLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.zdxCheckDeskCellDownHeadImg.RightX + COMMON_MARGIN, y: 10, width: self.Width - 2 * COMMON_MARGIN - 25, height: 25))
        d.textColor = UIColor.colorWithHexString("333333")
        d.font = UIFont.systemFont(ofSize: 13)
        return d
    }()
    
    lazy var zdxCDCheckImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0.65 * (self.Width - 2 * COMMON_MARGIN), y: 15, width: 15, height: 15))
        d.layer.borderWidth = 0.5
        d.layer.borderColor = UIColor.gray.cgColor
        d.layer.cornerRadius = 7.5
        d.clipsToBounds = true
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        /// 延长系统自带分割线
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = .zero
        
        contentView.addSubview(zdxCheckDeskCellDownHeadImg)
        contentView.addSubview(zdxCheckDescCellDescLabel)
        contentView.addSubview(zdxCDCheckImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
