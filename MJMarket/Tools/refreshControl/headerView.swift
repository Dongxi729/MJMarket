

import UIKit



@objc protocol headerViewelegate
{
    @objc optional func headerViewEndfun(_ _endRefresh: ()->Void)
}

class headerView: UIView {
    //头部下拉 view
    
    var _scrollView:UIScrollView!
    
    
    
    var dragboo:Bool = false
    //是否正在拖动
    
    var delegate:headerViewelegate?
    
    var la :UILabel?
    
    var jimg:UIImageView?
    
    var ay:UIActivityIndicatorView?
    
    
    // MARK:- 初始化
    /// 初始化
    ///
    /// - Parameters:
    ///   - frame: 大小
    ///   - _sv: 添加的webview
    init(frame: CGRect,_sv:UIScrollView)
    {
        super.init(frame: frame)
        _scrollView = _sv
        self.backgroundColor = UIColor.white
        _scrollView.alwaysBounceVertical = true
        
        la = UILabel(frame: CGRect.init(x: self.frame.width / 4, y: self.frame.height / 2 - 10, width: self.frame.width / 3, height: 20))
        la!.text = "下拉可以刷新"
        la?.textAlignment  = .center
        self.addSubview(la!)
        la!.center.x = self.frame.width/2
        
        la?.font = UIFont.systemFont(ofSize: 12)
        
        
        jimg = UIImageView.init(frame: CGRect.init(x: (la?.LeftX)! - 20 * SCREEN_SCALE, y: self.frame.height / 2 - 10, width: 20, height: 20))
        jimg?.image = UIImage(named: "arrow")
        jimg?.contentMode = .scaleAspectFit
        
        self.addSubview(jimg!)
        
        /// 菊花样式小清新灰色
        ay = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        ay?.color = UIColor.black
        ay?.frame = (jimg?.frame)!
        self.addSubview(ay!)
        ay?.isHidden = true
        
        
        /// 分割线的颜色
        let line = UIView(frame: CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: 1))
        line.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.addSubview(line)
        
        
        
    }
    
    
    func Do()
    {
        //监听
        let point = _scrollView.contentOffset
        
        //坐标
        
        if( point.y <= 0 && dragboo == false )
        {
            //jimg?.hidden = false
            var a :CGFloat = 0
                {
                didSet
                {
                    if(a>1)
                    {
                        a = 1
                        la!.text = "松开可以刷新"
                    }
                    else
                    {
                        la!.text = "下拉可以刷新"
                    }
                }
            }
            a = -CGFloat(point.y) / (CGFloat(self.frame.height))
            jimg?.transform = CGAffineTransform(rotationAngle: a * CGFloat(Double.pi))
            // print(a)
        }
        
        //        适用于tableView
        //        if point.y < -self.frame.height
        //        {
        //            beginRefresh()
        //        }
        
        
        ///适用于编辑状态的webview
        if point.y < -100 * SCREEN_SCALE
        {
            beginRefresh()
        }
    }
    
    
    
    // MARK:- 开始刷新
    /// 开始刷新
    func beginRefresh()
    {
        //刷新
        if dragboo == false && _scrollView.isDragging == false
        {
            la!.text = "数据加载中...."
            jimg?.transform = CGAffineTransform(rotationAngle: 0)
            jimg?.isHidden = true
            ay?.isHidden = false
            ay?.startAnimating()
            dragboo = true
            animationfun(self.frame.height)
        }
    }
    
    
    // MARK:- 停止刷新
    /// 停止刷新
    func endRefresh()
    {
        //完成刷新
        
        if dragboo && _scrollView.isDragging == false
        {
            // ay?.stopAnimating()
            dragboo = false
            Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.timerfun), userInfo: nil, repeats: false)
            
        }
        
    }
    
    
    /// 定时器控制文字变化
    func timerfun()
    {
        animationfun()
    }
    
    
    func animationfun(_ _top:CGFloat = 0)
    {
        //动画方法
        var edge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        edge.top = _top
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            
            self._scrollView.contentInset = edge
            
        }, completion: { (Bool) -> Void in
            if(self.dragboo)
            {
                self.delegate?.headerViewEndfun!(self.endRefresh)
            }
            else
            {
                self.jimg?.isHidden = false
                self.ay?.isHidden = true
                self.la!.text = "下拉可以刷新"
            }
            
        })
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
