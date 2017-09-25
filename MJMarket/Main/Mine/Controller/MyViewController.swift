//
//  MyViewController.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的视图控制器
//tabbar遮盖44PX
//http://www.itnose.net/detail/6316946.html

import UIKit

class MyViewController: ZDXBaseVC,UITableViewDataSource,UITableViewDelegate,MyCellTwoDelegate,MyCellOneDelegate,ChagrgeVDelegate {


    lazy var myTbV: UITableView = {
        let d: UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        
        d.register(MyVHeaderV.self, forCellReuseIdentifier: "MyVHeaderV")
        d.register(MyCellOne.self, forCellReuseIdentifier: "one")
        d.register(MyCellTwo.self, forCellReuseIdentifier: "two")
        d.register(MyCellThree.self, forCellReuseIdentifier: "MyCellThree")
        
        
        
        /// cell的分割线颜色
        d.separatorColor = UIColor.colorWithHexString("F3F3F3")

        return d
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    

    
    
    
    /// 右上角按钮
    private lazy var myView_RightBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - (25 * SCREEN_SCALE) - COMMON_MARGIN, y: 20 + COMMON_MARGIN, width: 25 * SCREEN_SCALE, height: 25 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(myView_RightBtnSEl), for: .touchUpInside)
        d.backgroundColor = UIColor.randomColor()
        d.setBackgroundImage(#imageLiteral(resourceName: "setting"), for: .normal)
        return d
    }()
    
    func myView_RightBtnSEl() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(SettingVC(), animated: true)
        
    }
    
    var myViewController_CellThreeTitles : [String] = ["收货地址","优惠券","我的评价","我的收藏","登录密码"]
    var myViewController_CellIcon : [String] = ["location","coupon","my_evaluate","my_collect","login_psd"]
    
    var redIcom : [String] = ["0","1","0","1","1"]
    
    var recArray: [String] = [] {
        didSet {
            self.myTbV.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        if AccountModel.shareAccount()?.token == nil {
            FTIndicator.showToastMessage("未登录")
        } else {
            FTIndicator.showToastMessage("登录")
        }
        
        ZDXRequestTool.orderCount(finished: { (str) in
            
            self.recArray = str
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.

        view.addSubview(myTbV)
        UIApplication.shared.statusBarStyle = .default
        
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(myView_RightBtn)
        
        view.backgroundColor = UIColor.colorWithHexString("F8F8F8")
        

        if #available(iOS 11.0, *) {
            self.myTbV.contentInsetAdjustmentBehavior = .never
        }
    }
    
    
    // MARK: - 表格代理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyVHeaderV") as! MyVHeaderV
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "one") as! MyCellOne
            cell.myCellOneDelegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "two") as! MyCellTwo
            
            
            cell.xxx(dss: recArray)
            cell.myCellTwoDelegate = self
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellThree") as! MyCellThree
            cell.myCellThree_descLabel.text = myViewController_CellThreeTitles[indexPath.row]
            cell.myCellThree_FronIcon.image = UIImage.init(named: myViewController_CellIcon[indexPath.row])
            cell.myCellThree_DisImg.image = UIImage.init(named: "right")
            return cell
        default:
            break
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001
        } else {
            return COMMON_MARGIN * 0.5
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return COMMON_MARGIN * 0.5
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120 * SCREEN_SCALE
        case 1:
            return 60
        case 2:
            return 60 * SCREEN_SCALE
        case 3:
            return 45
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 5
        } else {
            return 1
        }
    }
    
    // MARK: - MyCellTwoDelegate
    func btnCli(sender: UIButton) {
        if sender.titleLabel?.text == "全部订单" {
            CCog()
        }
        
        if sender.titleLabel?.text == "待收货" {
            CCog()
        }
        
        if sender.titleLabel?.text == "待评价" {
            CCog()
        }
        
        if sender.titleLabel?.text == "代付款" {
            CCog()
        }
        
        if sender.titleLabel?.text == "退款/售后" {
            CCog()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row == 4 {
            self.navigationController?.pushViewController(ChangeLoginPassVC(), animated: true)
        }
    }

    
    func chargeDelegateSEL() {
        CCog()
        let payV = ChagrgeV.init(CGRect.init(x: 0, y: 0, width: 265, height: (310) * 1.15))
        payV.chagrgeVDelegate = self

        UIApplication.shared.keyWindow?.addSubview(payV)
        payV.center = (UIApplication.shared.keyWindow?.center)!
    }
    
    
    // MARK: - ChagrgeVDelegate
    func selectChargeApp(_ selectType: Int) {
        CCog(message: selectType)
    }
    
    func selectChargeAppWithMoney(_ selectType: Int) {
        CCog(message: selectType)
    }
    
}









