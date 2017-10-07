import UIKit


extension UIScrollView {
    
    func addHeaderViewfun()
    {
        //添加头部刷新
        var header  = self.viewWithTag(888) as? headerView
        if(header == nil)
        {
            header = headerView(frame: CGRect(x: 0, y: -70, width: self.frame.width, height: 70),_sv:self)
            header?.tag = 888
            self.addSubview(header!)
        }
        // header!.beginRefresh()
        //添加下拉刷新
        
        self.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
        //监听contentOffset的变化
        
    }
    
    
    func addFooterViewfun()
    {
        //添加尾部加载
        var footer  = self.viewWithTag(999) as? footerView
        if(footer == nil)
        {
            footer = footerView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 70),_sv:self)
            print(self.contentSize)
            footer?.tag = 999
            self.addSubview(footer!)
            footer?.isHidden = true
            
        }
        
        //添加下拉刷新
        
        self.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
        //监听contentOffset的变化
    }
    
    
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let header = self.viewWithTag(888) as? headerView
        {
            header.Do()
            //头部监听
        }
        
        if let footer = self.viewWithTag(999) as? footerView
        {
            footer.Do()
            //尾部监听
        }
        
        
    }
    
}



