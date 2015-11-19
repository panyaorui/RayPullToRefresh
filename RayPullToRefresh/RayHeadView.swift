//
//  RayHeadView.swift
//  RayPullToRefresh
//   下拉刷新顶部视图
//  Created by ray on 15/11/9.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

enum RayHeadViewState{
    case StateDragToRefresh;     //默认状态,下拉可以刷新状态
    case StateLooseToRefresh;    //松开立即刷新状态
    case  StateRefreshing;         //加载中状态
    case StateDraging;             // 滑动状态
}

class RayHeadView: RayBaseHeadView {
    
    /** 缩放动画图片控件*/
    var image:UIImageView?;
    /** 状态提示*/
    @IBOutlet weak var labelHint: UILabel!
    /** 图片箭头*/
    @IBOutlet weak var imageArraw: UIImageView!
    /** 头部等待加载提示*/
    @IBOutlet weak var indicatorHead: UIActivityIndicatorView!
    /** 动画方式*/
    var animateType:RayTableViewAnimateType = RayTableViewAnimateType.Default;
    
    /** 根据xib文件获取RayHeadView视图*/
    class func viewFromNibNamed()->RayHeadView
    {
        return NSBundle.mainBundle().loadNibNamed("RayHeadView", owner: self, options: nil)[0] as! RayHeadView;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.indicatorHead.hidden = true;
    }
    
    /** 更改视图状态*/
    override func setState(newsState:RayHeadViewState)
    {
        self.state = newsState;
        switch(self.state){
        case RayHeadViewState.StateDragToRefresh: //下拉刷新
            self.labelHint.text = self.StateDragToRefreshHint;
            self.flipImageAnimated(false);
            self.switchImage(false);
           break;
        case RayHeadViewState.StateLooseToRefresh://松开刷新
             self.labelHint.text = self.StateLooseToRefreshHint;
             self.flipImageAnimated(true);
            break;
        case RayHeadViewState.StateRefreshing://刷新中
            self.labelHint.text = self.StateRefreshingHint;
            self.switchImage(true);

            //执行回调函数
            if(self.action != nil){
                self.action!();
            }
            break;
        case RayHeadViewState.StateDraging: //滑动中
                break;
                
            }

    }
    
    
    /** 切换箭头和加载中图片*/
    func switchImage(showIndicator:Bool){
        if(showIndicator){
            self.indicatorHead.hidden = false;
            self.indicatorHead.startAnimating();
            self.imageArraw.hidden = true;
        }else{
              self.indicatorHead.hidden = true;
             self.indicatorHead.stopAnimating();
             self.imageArraw.hidden = false;
        }
    }
    
    /** 默认动画方式，用于旋转箭头*/
    func flipImageAnimated(animated:Bool){
        UIView .animateWithDuration(0.18) { () -> Void in
            if(animated)
            {
              self.imageArraw.layer.transform = CATransform3DMakeRotation(CGFloat.init(M_PI), 0.0, 0, 1.0);
            }else{
              self.imageArraw.layer.transform = CATransform3DMakeRotation(CGFloat.init(M_PI) * 2, 0.0, 0, 1.0);
            }
        }
    }
}
