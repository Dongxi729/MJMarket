//
//  ShareV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  分享视图

import UIKit

protocol ShareVDelegate {
    func shareToFriend()
    func shareToQQ()
    func shareToWxFriend()
}

class ShareV: UIView,ShareCellDelegate {
    
    var shareVDelegate : ShareVDelegate?
    
    lazy var leftLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x:self.shareToDesc.LeftX - COMMON_MARGIN - SCREEN_WIDTH * 0.15, y: self.shareToDesc.bounds.midX, width: SCREEN_WIDTH * 0.15, height: 1))
        d.backgroundColor = UIColor.colorWithHexString("333333")
        return d
    }()
    
    lazy var rightLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: self.shareToDesc.RightX + COMMON_MARGIN , y: self.leftLine.TopY, width: SCREEN_WIDTH * 0.15, height: 1))
        d.backgroundColor = UIColor.colorWithHexString("333333")
        return d
    }()
    
    lazy var shareToDesc: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 52 / 2, y: COMMON_MARGIN, width: 52.0, height: 20 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "分享到"
        return d
    }()
    
    
    lazy var shareIcons: ShareCell = {
        let d : ShareCell = ShareCell.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.2, y: self.shareToDesc.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: SCREEN_WIDTH * 0.6, height: self.Height * 0.3))
        d.shareCellDelegate = self
        return d
    }()
    
    lazy var cancelBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.Height - 20 * SCREEN_SCALE - COMMON_MARGIN, width: SCREEN_WIDTH, height: 20 * SCREEN_SCALE))
        d.setTitleColor(UIColor.black, for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        d.addTarget(self, action: #selector(dismissShare), for: .touchUpInside)
        d.setTitle("取消", for: .normal)
        return d
    }()
    
    @objc private func dismissShare() {
        UIView.animate(withDuration: 0.25) {
            self.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 150)
        }
    }
    
    private lazy var topWindown: UIWindow = {
        let d : UIWindow = UIWindow.init(frame: (UIApplication.shared.keyWindow?.frame)!)
        d.makeKeyAndVisible()
        return d
    }()
    
    private lazy var maskV: UIView = {
        let d : UIView = UIView.init(frame: (UIApplication.shared.keyWindow?.frame)!)
        d.backgroundColor = UIColor.white
        d.alpha = 0
        return d
    }()
    
    init(_ rect : CGRect) {
        super.init(frame: rect)
        
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white
        
        addSubview(shareToDesc)
        addSubview(shareIcons)
        CCog(message: shareToDesc.frame)
        addSubview(leftLine)
        addSubview(rightLine)
        addSubview(cancelBtn)
    }
    
    func shareClickBtn(sender: UIButton) {
        if sender.titleLabel?.text == "微信好友" {
            self.shareVDelegate?.shareToWxFriend()
        }
        
        if sender.titleLabel?.text == "朋友圈" {
            self.shareVDelegate?.shareToFriend()
        }
        
        if sender.titleLabel?.text == "QQ" {
            self.shareVDelegate?.shareToQQ()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ShareCellDelegate {
    func shareClickBtn(sender : UIButton)
}


class ShareCell: UIView {
    
    var shareCellV : ShareBtn!
    
    var shareCellDelegate : ShareCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var btnTitles : [String] = ["微信好友","朋友圈","QQ"]
        
        var imgs : [String] = ["wechat_friend","wechat_circle","qq"]
        
        let imgWidth = self.Width
        
        for index in 0..<imgs.count {
            
            self.shareCellV = ShareBtn.init(frame: CGRect.init(x: Int(imgWidth) / 3 * index, y: 0, width: Int(imgWidth) / 3, height: Int(self.Height)))
            self.shareCellV.setImage(UIImage.init(named: imgs[index]), for: .normal)
            self.shareCellV.setTitle(btnTitles[index], for: .normal)
            self.shareCellV.setTitleColor(UIColor.colorWithHexString("333333"), for: .normal)
            self.shareCellV.addTarget(self, action: #selector(shareBtn(sender:)), for: .touchUpInside)
            addSubview(shareCellV)
        }
    }
    
    @objc private func shareBtn(sender : UIButton) {
        self.shareCellDelegate?.shareClickBtn(sender: sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShareBtn : UIButton {
    
    
    override init(frame: CGRect) {
        
        
        super.init(frame: frame)
        
        
        self.layer.borderWidth = 1
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = FONT_COLOR
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height * 0.7)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0.8 * self.Height, width: self.Width, height: self.Height * 0.15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
