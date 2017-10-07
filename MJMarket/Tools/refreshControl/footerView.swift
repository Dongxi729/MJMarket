

import UIKit



@objc protocol footerViewelegate
{
    @objc optional func footerViewEndfun(_ _endRefresh: ()->Void)
}

class footerView: UIView {
    //尾部上拉 view
    
    var _scrollView:UIScrollView!
    
    var dragboo:Bool = false
    //是否正在拖动
    
    var delegate:footerViewelegate?
    
    var la :UILabel?
    
    var jimg:UIImageView?
    
    var ay:UIActivityIndicatorView?
    
    init(frame: CGRect,_sv:UIScrollView)
    {
        super.init(frame: frame)
        _scrollView = _sv
        self.backgroundColor = UIColor.white
        _scrollView.alwaysBounceVertical = true
        
        jimg = UIImageView(frame: CGRect(x: 0, y: 0, width: 40/2, height: 65/2))
        jimg?.image = UIImage(named: "sports014")
        la = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: 20))
        la!.text = "上拉可以加载"
        la?.textAlignment  = .center
        self.addSubview(la!)
        la!.center.x = self.frame.width/2
        la!.center.y = self.frame.height*1/3
        la?.font = UIFont.systemFont(ofSize: 12)
        
        jimg?.center.y = la!.center.y
        jimg?.center.x = la!.frame.origin.x - (jimg?.frame.width)!
        self.addSubview(jimg!)
        jimg?.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi))
        
        
        ay = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        ay?.color = UIColor.black
        ay?.frame = (jimg?.frame)!
        self.addSubview(ay!)
        ay?.isHidden = true
        
        
        
        let line = UIView(frame: CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: 1))
        line.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.addSubview(line)
    }
    
    
    func Do()
    {
        if(self.frame.origin.y != _scrollView.contentSize.height)
        {
            self.frame.origin.y = _scrollView.contentSize.height
            self.isHidden = false
        }
        //        //监听
        let point = _scrollView.contentOffset
        //        //坐标
        //print(point.y + _scrollView.frame.height)
        //
        if( point.y + _scrollView.frame.height >= _scrollView.contentSize.height && dragboo == false )
        {
            //jimg?.hidden = false
            var a :CGFloat = 0
                {
                didSet
                {
                    if(a>1)
                    {
                        a = 1
                        la!.text = "松开可以加载"
                    }
                    else
                    {
                        la!.text = "上拉可以加载"
                    }
                }
            }
            a = (point.y + _scrollView.frame.height -  _scrollView.contentSize.height) / self.frame.height
            jimg?.transform = CGAffineTransform(rotationAngle: a * CGFloat(Double.pi))
            // print(a)
        }
        
        if (point.y + _scrollView.frame.height -  _scrollView.contentSize.height) > self.frame.height && _scrollView.contentSize.height > _scrollView.frame.height
        {
            beginRefresh()
        }
        
    }
    
    
    
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
    
    
    func endRefresh()
    {
        //完成刷新
        //print(dragboo,_scrollView.dragging == false)
        if dragboo && _scrollView.isDragging == false
        {
            // ay?.stopAnimating()
            dragboo = false
            animationfun()
            Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.timerfun), userInfo: nil, repeats: false)
        }
        
    }
    
    func timerfun()
    {
        animationfun()
    }
    
    
    func animationfun(_ _bottom:CGFloat = 0)
    {
        //动画方法
        var edge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        edge.bottom = _bottom
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            
            self._scrollView.contentInset = edge
            
        }, completion: { (Bool) -> Void in
            
            if(self.dragboo)
            {
                self.delegate?.footerViewEndfun!(self.endRefresh)
            }
            else
            {
                self.jimg?.isHidden = false
                self.ay?.isHidden = true
                self.la!.text = "上拉可以加载"
            }
            
        })
    }
    
    
    
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
