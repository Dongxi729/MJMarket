//
//  MyCellTwo.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol MyCellTwoDelegate {
    func btnCli(sender : IndexPath)
}

class MyCellTwo : CommonTableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var indexPAth : IndexPath?
    
    var myCellTwoDelegate : MyCellTwoDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collV)
    }
    
    /// 图片名字
    private var imgsName : [String] = ["full_order","wait_payment","wait_receiver","wait_evaluate","refund_after"]
    
    private var titleSource : [String] = ["全部订单","待付款","待收货","待评价","退款/售后"]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellDataSouece = [""] {
        didSet {
            print(#line,cellDataSouece)
            
            self.collV.reloadData()
        }
    }
    
    
    /// 九宫格
    lazy var collV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        let d : UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.bounds.height * 1.3), collectionViewLayout: layout)
        
        d.backgroundColor = UIColor.clear
        
        d.dataSource = self
        d.delegate = self
        
        d.register(Home_cell.self, forCellWithReuseIdentifier: "cell")
        
        layout.itemSize = CGSize.init(width: UIScreen.main.bounds.width / 6, height: self.bounds.height * 1.3)
        d.showsVerticalScrollIndicator = false
        d.isScrollEnabled = false
        
        return d
    }()
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CCog(message: indexPath.row)
        self.myCellTwoDelegate?.btnCli(sender: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Home_cell

        if cellDataSouece.count == 0 {
            if let redSource = UserDefaults.standard.object(forKey: "redIcon") as? [String] {
                if redSource[indexPath.row] == "0" {
                    cell.seprateBtn.redV.isHidden = true
                } else {
                    cell.seprateBtn.redV.isHidden = false
                }
                cell.seprateBtn.redV.text = redSource[indexPath.row]
                cell.seprateBtn.setImage(UIImage.init(named: imgsName[indexPath.row]), for: .normal)
                cell.seprateBtn.setTitleColor(.black, for: .normal)
                cell.seprateBtn.setTitle(self.titleSource[indexPath.row], for: .normal)
            } else {
                var tempSource = ["0","0","0","0","0"]
                if tempSource[indexPath.row] == "0" {
                    cell.seprateBtn.redV.isHidden = true
                } else {
                    cell.seprateBtn.redV.isHidden = false
                }
                cell.seprateBtn.redV.text = tempSource[indexPath.row]
                cell.seprateBtn.setImage(UIImage.init(named: imgsName[indexPath.row]), for: .normal)
                cell.seprateBtn.setTitleColor(.black, for: .normal)
                cell.seprateBtn.setTitle(self.titleSource[indexPath.row], for: .normal)
            }
        } else {
            
            if cellDataSouece[indexPath.row] == "0" {
                cell.seprateBtn.redV.isHidden = true
            } else {
                cell.seprateBtn.redV.isHidden = false
            }
            cell.seprateBtn.redV.text = cellDataSouece[indexPath.row]
            cell.seprateBtn.setImage(UIImage.init(named: imgsName[indexPath.row]), for: .normal)
            cell.seprateBtn.setTitleColor(.black, for: .normal)
            
            cell.seprateBtn.setTitle(self.titleSource[indexPath.row], for: .normal)
        }

        return cell
    }
}


class Home_cell: UICollectionViewCell {
    lazy var btn: UILabel = {
        let d : UILabel = UILabel.init(frame: self.bounds)
        return d
    }()
    
    lazy var seprateBtn: BtnWithRedMark2 = {
        let d : BtnWithRedMark2 = BtnWithRedMark2.init(frame: self.bounds)
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(seprateBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BtnWithRedMark2 : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(redV)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.titleLabel?.textAlignment = .center
        self.isUserInteractionEnabled = false
        
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: self.bounds.height * 0.6, width: self.bounds.width, height: self.bounds.height * 0.4)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * 0.6)
    }
    
    lazy var redV: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.bounds.width * 0.6, y: 0, width: self.bounds.width / 3, height: self.bounds.height / 3))
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 12)
        d.layer.cornerRadius = (self.bounds.height / 6)
        d.clipsToBounds = true
        d.textAlignment = .center
        d.backgroundColor = UIColor.red
        return d
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BtnWithRedMark: UIView {
    
    
    
    lazy var myInfoBtn: SeparateBtn = {
        let d: SeparateBtn = SeparateBtn.init(frame: CGRect.init(x: self.Width * 0.1, y: self.Width * 0.125, width: self.Width * 0.85, height: self.Height * 0.85))
        d.setTitle("廍订单", for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        d.setTitleColor(FONT_COLOR, for: .normal)
        d.setImage(#imageLiteral(resourceName: "correct"), for: .normal)
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myInfoBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
