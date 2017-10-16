//
//  ChangePayPassVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  修改支付密码

import UIKit

class ChangePayPassVC: UIViewController,UITableViewDelegate,UITableViewDataSource,BindPhoneCellDelegate,PersonFooVDelegate {
    
    lazy var bindPhone_TBV: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(BindPhoneCell.self, forCellReuseIdentifier: "BindPhoneCell")
        return d
    }()
    
    lazy var bindPhone_FoV: PersonFooV = {
        let d: PersonFooV = PersonFooV.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 45))
        d.personFooVDelegate = self
        d.personInfo_footerV.setTitle("下一步", for: .normal)
        d.personInfo_footerV.addTarget(self, action: #selector(jumpToSetPayPss), for: .touchUpInside)
        return d
    }()
    
    @objc private func jumpToSetPayPss() {
        if authInputMark {
            let vc = PayPassVC()
            vc.payPassAuth = self.authStr
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        title = "修改支付密码"
        view.addSubview(bindPhone_TBV)
        bindPhone_TBV.tableFooterView = bindPhone_FoV
        
    }
    
    /// 验证码
    private var authStr : String = ""
    
    private var cellDescTitles : [String] = ["请输入验证码"]
    
    // MARK: - 表格代理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BindPhoneCell") as! BindPhoneCell
        cell.bindPhoneCellDescLanbel.placeholder = cellDescTitles[indexPath.row]
        cell.bindIndex = indexPath
        cell.bindCellDelegate = self
        cell.bindPhoneCell_Btn.isHidden = false
        
        if indexPath.row != 0 {
            cell.bindPhoneCell_Btn.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDescTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    
    // MARK: - BindPhoneCellDelegate
    func cellStr(index: IndexPath, str: String) {
        CCog(message: index.row)
        CCog(message: str)
        
        if index.row == 0 {
            authStr = str
        }
    }
    
    func getAutoDelegate(sender: CountDownBtn) {
        
        ZDXRequestTool.sendAuto { (result) in
            if result {
                sender.initwith(color: COMMON_COLOR, title: "", superView: self.view, titleColor: .white)
            }
        }
    }
    
    /// 是否输入验证码标识
    private var authInputMark = false
    
    // MARK: - PersonFooVDelegate -- 尾部代理方法
    func personBtnSEL() {
        if authStr.characters.count == 0 {
            FTIndicator.showToastMessage("请输入验证码")
            return
        } else {
            authInputMark = true
        }
    }
}
