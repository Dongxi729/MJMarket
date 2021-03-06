//
//  SettingVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  设置

import UIKit
import WebKit

class SettingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private lazy var set_TbV: UITableView = {
        let d:UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(SetVCellOne.self, forCellReuseIdentifier: "setOne")
        d.register(SetVCellTwo.self, forCellReuseIdentifier: "SetVCellTwo")
        return d
    }()
    
    /// 数据源
    private var setCellTwoTitles : [String] = ["意见反馈","关于我们","清除缓存"]
    
    private lazy var settingVC_ExitBtn: UIButton = {
        
        var d : UIButton = UIButton.init()
        if SCREEN_HEIGHT == 812 {
            d.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - (self.navigationController?.navigationBar.Height)! - (self.tabBarController?.tabBar.Height)! - 45 * SCREEN_SCALE, width: SCREEN_WIDTH, height: 45 * SCREEN_SCALE)
        } else {
            d = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 45 * SCREEN_SCALE - 64, width: SCREEN_WIDTH, height: 45 * SCREEN_SCALE))
            
        }
        
        d.backgroundColor = COMMON_COLOR
        d.setTitle("退出当前账号", for: .normal)
        d.addTarget(self, action: #selector(exitLocalCount), for: .touchUpInside)
        return d
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSelf), name: NSNotification.Name(rawValue: "updateSuccess"), object: nil)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "设置"
        view.addSubview(set_TbV)
        view.addSubview(settingVC_ExitBtn)
        
        view.backgroundColor = UIColor.white
    }
    
    
    
    func reloadSelf() {
        self.set_TbV.reloadData()
    }
    
    // MARK: - 表格代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return setCellTwoTitles.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setOne") as! SetVCellOne
            if (MineModel.chooseImgData != nil) {
                cell.set_HeadImg.image = MineModel.chooseImgData
            }
            
            cell.set_NameLabel.text = MineModel.nameString
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SetVCellTwo") as! SetVCellTwo
            cell.setCellTwo_DescLabel.text = setCellTwoTitles[indexPath.row]
            if indexPath.section == 1 && indexPath.row == 2 {
                cell.clearCaheLabel.isHidden = false
            }
            return cell
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        } else {
            return COMMON_MARGIN * 0.25
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return COMMON_MARGIN
        } else {
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60 * SCREEN_SCALE
        } else {
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.navigationController?.pushViewController(PersonInfoVC(), animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            self.navigationController?.pushViewController(FeedBackVC(), animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            self.navigationController?.pushViewController(AboutUSVC(), animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            DispatchQueue.main.async {
                
                let cell = tableView.cellForRow(at: indexPath) as! SetVCellTwo
                
                //缓存机制:http://www.jianshu.com/p/186a3b236bc9
                if #available(iOS 9.0, *) {
                    
                    let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
                    let dateForm = NSDate.init(timeIntervalSince1970: 0)
                    
                    
                    WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: dateForm as Date, completionHandler: {
                        
                        toast(toast: "清除完毕")
                        cell.clearCaheLabel.text = "0.0MB"

                    })
                    
                } else {
                    
                    var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
                    libraryPath += "/Cookies"
                    URLCache.shared.removeAllCachedResponses()
                    toast(toast: "清除完毕")
                    cell.clearCaheLabel.text = "0.0MB"

                }
            }
        }
    }
    
    // MARK: - 退出当前账号
    @objc private func exitLocalCount() {
        RemoveCookieTool.removeCookie()
        RemoveCookieTool.removeCookie()
        RemoveCookieTool.removeCookie()
        RemoveCookieTool.removeCookie()
        AccountModel.logout()
        UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
        MineModel.nameString = ""
        MineModel.chooseImgData = nil
        MineModel.signMent = false
        
        /// UserDefaults.standard.set(str, forKey: "redIcon")
        UserDefaults.standard.removeObject(forKey: "redIcon")
        UserDefaults.standard.synchronize()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


