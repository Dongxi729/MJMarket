/// 登录后界面的导航栏

import UIKit

class JFNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    /// 左上角按钮
    var leftBarItem : UIButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let leftMenuItem = UIBarButtonItem.init(title: "返回", style: .done, target: self, action: #selector(back))
        self.navigationItem.setLeftBarButton(leftMenuItem, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = navigationBar
        
        /// 导航栏背景颜色
        navBar.barTintColor = UIColor.gray
        navBar.isTranslucent = false
        navBar.barStyle = UIBarStyle.black
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        navBar.titleTextAttributes = [
            /// 全局标题颜色白色
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]
        
        // 全屏返回手势
     //   panGestureBack()
        
        /// 状态栏白色
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    /**
     全屏返回手势
     */
    private func panGestureBack() {
        let target = interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        pan.delegate = self
        view.addGestureRecognizer(pan)
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gesture: UIGestureRecognizer) -> Bool {
        
        if childViewControllers.count == 1 {
            return false
        }  else {
            return true
        }
    }
    
    lazy var jfNav_leftBar: UIBarButtonItem = {
        let d: UIBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
        d.tintColor = UIColor.white
        return d
    }()
    
    /**
     拦截push操作
     
     - parameter viewController: 即将压入栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        
        super.pushViewController(viewController, animated: animated)
        
        /// 子页面数大于1个,显示左上角图标
        if self.viewControllers.count > 1 {
            // 压入栈后创建返回按钮
            viewController.navigationItem.leftBarButtonItem = jfNav_leftBar
        }
    }
    
    /**
     全局返回操作
     */
    @objc fileprivate func back() {
        popViewController(animated: true)
    }
}
