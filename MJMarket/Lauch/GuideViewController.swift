//
//  GuideViewController.swift
//  GuideViewExample
//
//  Created by ChuGuimin on 16/1/20.
//  Copyright © 2016年 cgm. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {
    

    
    lazy var pageControl: UIPageControl = {
        let d: UIPageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 30))
        d.backgroundColor = UIColor.clear
        d.numberOfPages = 3
        d.currentPage = 0
        d.currentPageIndicatorTintColor = COMMON_COLOR
        return d
    }()
    
    /// 体验按钮
    lazy var startButton: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - SCREEN_WIDTH * 0.125, y: SCREEN_HEIGHT * 0.9, width: SCREEN_WIDTH * 0.25, height: 30))
        d.layer.cornerRadius = 3
        d.setTitle("进入主界面", for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        d.addTarget(self, action: #selector(startNow), for: .touchUpInside)
        d.backgroundColor = UIColor.colorWithHexString("F15A24")
        d.setTitleColor(.white, for: .normal)
        return d
    }()
    
    /// 体验按钮-进入主界面
    @objc private func startNow() {
        UIApplication.shared.setStatusBarHidden(false, with: .slide)
    
        // 设置全局颜色
        UITabBar.appearance().tintColor = COMMON_COLOR
        UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
        
    }
    
    
    fileprivate var scrollView: UIScrollView!
    
    fileprivate let numOfPages = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pageControl)
        view.addSubview(startButton)
        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        
        scrollView.delegate = self
        
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "GuideImage\(index + 1)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
        
        self.view.insertSubview(scrollView, at: 0)
        
        // 给开始按钮设置圆角
        startButton.layer.cornerRadius = 15.0
        // 隐藏开始按钮
        startButton.alpha = 0.0
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

// MARK: - UIScrollViewDelegate
extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.alpha = 1.0
            }) 
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.startButton.alpha = 0.0
            }) 
        }
    }
}
