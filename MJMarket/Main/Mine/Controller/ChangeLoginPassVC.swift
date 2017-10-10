//
//  ChangeLoginPassVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  修改登录密码

import UIKit

class ChangeLoginPassVC: UIViewController,UITableViewDelegate,UITableViewDataSource,BindPhoneCellDelegate,PersonFooVDelegate {
    func getAutoDelegate(sender: CountDownBtn) {
        CCog()
    }
    
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
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        title = "修改登录密码"
        view.addSubview(bindPhone_TBV)
        bindPhone_TBV.tableFooterView = bindPhone_FoV
        
    }
    
    private var cellDescTitles : [String] = ["请输入您的登录密码","请重复输入登录密码"]
    
    // MARK: - 表格代理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BindPhoneCell") as! BindPhoneCell
        cell.bindPhoneCellDescLanbel.placeholder = cellDescTitles[indexPath.row]
        cell.bindIndex = indexPath
        cell.bindCellDelegate = self
        
        cell.bindPhoneCell_Btn.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    
    /// 第一次登录密码
    private var loginPass = ""
    private var loginConfirmPass = ""
    // MARK: - BindPhoneCellDelegate
    func cellStr(index: IndexPath, str: String) {
        CCog(message: index.row)
        CCog(message: str)
        switch index.row {
        case 0:
            loginPass = str
        case 1:
            loginConfirmPass = str
        default:
            break
        }
    }
    
    
    // MARK: - PersonFooVDelegate -- 尾部代理方法
    func personBtnSEL() {
        CCog()
        if loginPass.characters.count == 0 {
            FTIndicator.showToastMessage("请输入登录密码")
            return
        }
        
        if loginConfirmPass.characters.count == 0 {
            FTIndicator.showToastMessage("请再次输入登录密码")
            return
        }
//        ZDXRequestTool.changeLoginPass(oldPassword: loginPass, newPassword: loginConfirmPass)
        ZDXRequestTool.changeLoginPass(oldPassword: loginPass, newPassword: loginConfirmPass) { (result) in
            if result {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
}
