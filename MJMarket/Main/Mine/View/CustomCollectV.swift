//
//  CustomCollectV
//  TimeStamp
//
//  Created by 郑东喜 on 2017/8/11.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  自定义CollectionView

import UIKit

protocol CustomCollectDelegate {
    /// 选择的cell
    func selectCell(_ indexPath : IndexPath)
}

class CustomCollect : UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var customDelegate : CustomCollectDelegate?
    
    /// collectionView布局
    lazy var layout: UICollectionViewFlowLayout = {
        let d: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        d.scrollDirection = .vertical
        d.itemSize = self.cellItemSize
        return d
    }()
    
    var customIndex : IndexPath!
    
    /// 是否显示小红点
    var customShowRedIcon = false
    
    /// UICollectionView
    lazy var collecTTC: UICollectionView = {
        
        let d : UICollectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: self.layout)
        d.delegate = self
        d.dataSource = self
        d.backgroundColor = .white
        
        d.register(MyTestCollectionViewCell.self, forCellWithReuseIdentifier: "MyTestCollectionViewCell")
        
        return d
    }()
    
    /// 标题数组
    var titles : [String] = []
    
    /// 图片数组
    var imgs : [String] = []
    
    /// 多少个collectionView
    var cells : Int = 0
    
    /// uicollectionViewFlowLayout 中itemSize 的大小
    var cellItemSize : CGSize = CGSize.init(width: 0, height: 10)
    
    /// 初始化collectionView
    ///
    /// - Parameters:
    ///   - titles: 数组
    ///   - imgs: 图片名字数组
    ///   - rect: 大小
    ///   - cellItemSize: cellItemSize  的大小
    init(_ titles :[String],_ imgs : [String],_ rect : CGRect,_ cellItemSize :CGSize) {
        super.init(frame: rect)
        self.cells = titles.count
        self.titles = titles
        self.imgs = imgs
        self.layout.itemSize = cellItemSize
        addSubview(collecTTC)
        
        
        let index = IndexPath.init(row: 0, section: 0)
        collecTTC.selectItem(at: index, animated: false, scrollPosition: .bottom)
        
    }
    
    // MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewFlowLayout
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    var xxxx = false
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTestCollectionViewCell", for: indexPath) as! MyTestCollectionViewCell
        
        self.customIndex = indexPath
        cell.myLabel.text = titles[indexPath.row]
        
        if !xxxx {
            CCog(message: self.imgs[indexPath.row])
            cell.myImageView.image = UIImage.init(named: self.imgs[indexPath.row])
            if indexPath.row == 1 {
                xxxx = true
            }
        }
        
        if ((AccountModel.shareAccount()?.sex) == nil) {
            
            // 默认输出第一个数据
            if indexPath.row == 0 {
                updateCellStatus(cell, selected: true)
            }
        }
        
        
        return cell
    }
    
    
    func updateCellStatus(_ cell: MyTestCollectionViewCell, selected: Bool) {
        
        cell.myImageView.image = selected ? UIImage.init(named: "sex_select") : UIImage.init(named: "sex_unselect")
     
    }
    

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MyTestCollectionViewCell
        updateCellStatus(cell, selected: false)

        
        CCog(message: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MyTestCollectionViewCell
        
        self.customDelegate?.selectCell(indexPath)
        
        updateCellStatus(cell, selected: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MyTestCollectionViewCell: UICollectionViewCell {
    
    lazy var redImgShow: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.Width * 0.3, height: self.Height))
        d.backgroundColor = COMMON_COLOR
        d.layer.cornerRadius = self.myImageView.Width * 0.2 * 0.5
        d.clipsToBounds = true
        return d
    }()
    
    lazy var myLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.myImageView.RightX, y: 0, width: self.Width * 0.5, height: self.Height))
        label.text = "我的小标题"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        return label
    }()
    
    lazy var myImageView: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.Width * 0.29, height: self.Height))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.layer.borderColor = UIColor.colorWithHexString("F3F3F3").cgColor
        d.layer.cornerRadius = d.Width / 1.6 / SCREEN_SCALE
        d.clipsToBounds = true
        
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
