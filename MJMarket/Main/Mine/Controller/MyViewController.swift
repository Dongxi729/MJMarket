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

class MyViewController: ZDXBaseVC,UITableViewDataSource,UITableViewDelegate,MyCellTwoDelegate,MyCellOneDelegate,ChagrgeVDelegate,MyVHeaderVDelegate, headerViewelegate {
    
    // MARK: - headerViewelegate
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        /// 取出刷新头
        let d : headerView = self.myTbV.viewWithTag(888) as! headerView
        ZDXRequestTool.getUserInfo { (result) in
            if result {
                toast(toast: "更新个人信息成功")
                self.myTbV.reloadData()
                self.myTbV.frame = self.view.bounds
                d.endRefresh()
            } else {
                d.endRefresh()
                self.myTbV.frame = self.view.bounds
            }
        }
        
        if AccountModel.shareAccount()?.id != nil {
            
            ZDXRequestTool.orderCount(finished: { (str) in
                
                self.recArray = str
                UserDefaults.standard.set(str, forKey: "redIcon")
                UserDefaults.standard.synchronize()
            })
        }
    }
    
    func wxChargeSuccess() {

        ZDXRequestTool.getUserInfo { (result) in
    
            CCog(message: result)
            if result {
                self.myTbV.reloadData()
            }
        }
    }
    
    func alipayChargeSuccess() {
        ZDXRequestTool.getUserInfo { (result) in
            if result {
                self.myTbV.reloadData()
            }
        }
    }
    
    func btnCli(sender: IndexPath) {

        /// 全部订单
        if sender.row == 0 {
            
            self.navigationController?.pushViewController(AllCommementVC(), animated: true)
        }
        
        if sender.row == 1 {
            
            self.navigationController?.pushViewController(WaitReceiveVC(), animated: true)
        }
        
        //待收货订单
        if sender.row == 2 {
            self.navigationController?.pushViewController(WaitToCommementVC(), animated: true)
        }
        
        
        //待付款订单
        if sender.row == 3 {
            
            self.navigationController?.pushViewController(WaitToPay(), animated: true)
        }
        
        //退款订单
        if sender.row == 4 {
            self.navigationController?.pushViewController(RefundVC(), animated: true)
        }
    }
    
    /// SIGN_URL
    func sliSucce() {
        self.navigationController?.pushViewController(SignmentVC(), animated: true)
    }
    
    /// 积分
    func jifenSEL() {
        self.navigationController?.pushViewController(MyJIfenVC(), animated: true)
    }
    
    
    /// 提示登录
    private func alertTologin() {
        guard let _ = AccountModel.shareAccount()?.id as? String else {
            
            let ac = ZDXAlertController.init(title: "友情提示", message: "您尚未登录", preferredStyle: .alert)
            ac.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
                let nav = JFNavigationController.init(rootViewController: LoginVC())
                UIApplication.shared.keyWindow?.rootViewController = nav
            }))
            
            ac.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
            
            self.present(ac, animated: true, completion: nil)
            
            return
        }
    }
    
    
    
    lazy var myTbV: UITableView = {
        let d: UITableView = UITableView.init(frame: CGRect.init(x: 0, y: -COMMON_MARGIN * 2, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 32), style: .grouped)
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
    
    
    /// 右上角按钮
    private lazy var myView_RightBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - (20 * SCREEN_SCALE) - COMMON_MARGIN, y: UIApplication.shared.statusBarFrame.height + COMMON_MARGIN, width: 20 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(myView_RightBtnSEl), for: .touchUpInside)
        d.setBackgroundImage(#imageLiteral(resourceName: "setting"), for: .normal)
        return d
    }()
    
    func myView_RightBtnSEl() {
        self.navigationController?.pushViewController(SettingVC(), animated: true)
    }
    
    var myViewController_CellThreeTitles : [String] = ["收货地址","优惠券","我的评价","我的收藏","登录密码","购买代理商品订单"]
    var myViewController_CellIcon : [String] = ["location","coupon","my_evaluate","my_collect","login_psd","agency_order"]
    
    var redIcom : [String] = ["0","1","0","1","1"]
    
    var recArray: [String] = [] {
        didSet {
            self.myTbV.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        vc.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        let now = Date.init()
        let nowStr = dformatter.string(from: now)
        
        UserDefaults.standard.set(nowStr, forKey: "nowDate")
        UserDefaults.standard.synchronize()
        
        
        vc.isHidden = true
        
        if navigationController?.viewControllers.count == 1 {
            UIApplication.shared.statusBarStyle = .lightContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        ZDXRequestTool.getUserInfo { (result) in
            if result {
                self.myTbV.reloadData()
            }
        }
        

        if AccountModel.shareAccount()?.token == nil {
            alertTologin()
        } else {
            ZDXRequestTool.orderCount(finished: { (str) in
              
                self.recArray = str
                UserDefaults.standard.set(str, forKey: "redIcon")
                UserDefaults.standard.synchronize()
            })
        }
        
        DispatchQueue.main.async {
            
            self.myTbV.reloadData()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

        view.addSubview(myTbV)
        
        myTbV.addHeaderViewfun()
        let refresgControl : headerView = myTbV.viewWithTag(888) as! headerView
        refresgControl.delegate = self;
        
        UIApplication.shared.statusBarStyle = .default
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.myTbV.addSubview(myView_RightBtn)
        
        view.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            self.myTbV.contentInsetAdjustmentBehavior = .never
            self.myTbV.frame = self.view.bounds
        }
    }
    
    
    
    // MARK: - 表格代理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyVHeaderV") as! MyVHeaderV
            if (MineModel.chooseImgData != nil) {
                cell.headerIconImg.image = MineModel.chooseImgData
            } else {
                if var headImgUrl = AccountModel.shareAccount()?.headimg as? String {
                    headImgUrl = "http://mj.ie1e.com" + headImgUrl
                    
                    DispatchQueue.main.async {
                        cell.headerIconImg.setAvatarImage(urlString: headImgUrl, placeholderImage: #imageLiteral(resourceName: "default_thumb"))
                    }
                }
            }
            
            if MineModel.nameString.characters.count > 0 {
                cell.nameInfoV.nameLabel.text = MineModel.nameString
            }
            
            cell.myVHeaderVDelegate = self
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "one") as! MyCellOne
            cell.myCellOneDelegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "two") as! MyCellTwo
            cell.myCellTwoDelegate = self
            cell.cellDataSouece = recArray
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
        return UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
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
            return 60
        case 3:
            return 45
        default:
            return 30
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return myViewController_CellThreeTitles.count
        } else {
            return 1
        }
    }
    
    // MARK: - MyCellTwoDelegate
    //    func btnCli(sender: UIButton) {
    //
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3 {
            UIApplication.shared.statusBarStyle = .default
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
        
        /// 收货地址
        if indexPath.section == 3 && indexPath.row == 0 {
            self.navigationController?.pushViewController(GetGoodVC(), animated: true)
        }
        
        /// 优惠券
        if indexPath.section == 3 && indexPath.row == 1 {
            self.navigationController?.pushViewController(MyCoupon(), animated: true)
            
        }
        
        /// 我的评价
        if indexPath.section == 3 && indexPath.row == 2 {
            self.navigationController?.pushViewController(Mycomment(), animated: true)
        }
        
        /// 我的收藏
        if indexPath.section == 3 && indexPath.row == 3 {
            self.navigationController?.pushViewController(MyCollectVC(), animated: true)
        }
        
        /// 登录密码
        if indexPath.section == 3 && indexPath.row == 4 {
            self.navigationController?.pushViewController(ChangeLoginPassVC(), animated: true)
        }
        
        /// 购买代理商品
        if indexPath.section == 3 && indexPath.row == 5 {
            self.navigationController?.pushViewController(AgentOrderVC(), animated: true)
        }
    }
    
    
    func chargeDelegateSEL() {
        let payV = ChagrgeV.init(CGRect.init(x: 0, y: 0, width: 265, height: (310) * 1.15))
        payV.chagrgeVDelegate = self
        
        UIApplication.shared.keyWindow?.addSubview(payV)
        payV.center = (UIApplication.shared.keyWindow?.center)!
        
        zdx_setupButtonSpringAnimation(payV)
    }
    
    
    // MARK: - ChagrgeVDelegate
    func selectChargeApp(_ selectType: Int) {
        CCog(message: selectType)
    }
    
    func selectChargeAppWithMoney(_ selectType: Int) {
        CCog(message: selectType)
    }
    
}




