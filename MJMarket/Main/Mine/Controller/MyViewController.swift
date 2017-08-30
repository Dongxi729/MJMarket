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

class MyViewController: ZDXBaseVC,UITableViewDataSource,UITableViewDelegate {


    lazy var myTbV: UITableView = {
        let d: UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        
        d.register(MyVHeaderV.self, forCellReuseIdentifier: "MyVHeaderV")
        d.register(MyCellOne.self, forCellReuseIdentifier: "one")
        d.register(MyCellTwo.self, forCellReuseIdentifier: "two")
        d.register(MyCellThree.self, forCellReuseIdentifier: "MyCellThree")
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
        return d
    }()
    
    func myView_RightBtnSEl() {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.addSubview(myTbV)
        UIApplication.shared.statusBarStyle = .default
        
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(myView_RightBtn)
    }
    
    // MARK: - 表格代理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyVHeaderV") as! MyVHeaderV
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "one") as! MyCellOne
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "two") as! MyCellTwo
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellThree") as! MyCellThree
            return cell
        default:
            break
        }
        return UITableViewCell.init()
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
            return 50
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
}



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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class MyCellOne: CommonTableViewCell {
    
    lazy var leftV: MyCellOneV = {
        let d: MyCellOneV = MyCellOneV.init(frame: CGRect.init(x: 0, y: 8, width: SCREEN_WIDTH * 0.5, height: self.Height))
        d.myCellMoneyLabel.text = "￥" + "0"
        d.descLabel.text = "金额"
        return d
    }()
    
    /// 分割线
    private lazy var seperateLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 1, y: 8, width: 2, height: self.Height))
        d.backgroundColor = UIColor.colorWithHexString("EBEAEB")
        return d
    }()
    
    lazy var rightV: MyCellOneV = {
        let d: MyCellOneV = MyCellOneV.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5, y: 8, width: SCREEN_WIDTH * 0.5, height: self.Height))
        d.myCellMoneyLabel.text = "1000"
        d.descLabel.text = "积分"
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftV)
        contentView.addSubview(rightV)
        contentView.addSubview(seperateLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyCellTwo: CommonTableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

class MyCellThree: CommonTableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


