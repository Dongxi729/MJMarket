//
//  SettingVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  设置

import UIKit

class SettingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private lazy var set_TbV: UITableView = {
        let d:UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(SetVCellOne.self, forCellReuseIdentifier: "setOne")
        d.register(SetVCellTwo.self, forCellReuseIdentifier: "SetVCellTwo")
        return d
    }()
    
    var setCellTwoTitles : [String] = ["意见反馈","客服中心"]
    
    private lazy var settingVC_ExitBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 45 * SCREEN_SCALE - 64, width: SCREEN_WIDTH, height: 45 * SCREEN_SCALE))
        d.backgroundColor = COMMON_COLOR
        d.setTitle("退出当前账号", for: .normal)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "设置"
        view.addSubview(set_TbV)
        view.addSubview(settingVC_ExitBtn)
    }
    
    // MARK: - 表格代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setOne") as! SetVCellOne
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SetVCellTwo") as! SetVCellTwo
            cell.setCellTwo_DescLabel.text = setCellTwoTitles[indexPath.row]
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
    }

}


