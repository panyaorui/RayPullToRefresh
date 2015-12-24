//
//  RayBaseHeadView.swift
//  RayPullToRefresh
//
//  Created by ray on 15/11/18.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

enum RayBaseHeadViewState{
    case StateDragToRefresh;     //默认状态,下拉可以刷新状态
    case StateLooseToRefresh;    //松开立即刷新状态
    case  StateRefreshing;         //加载中状态
    case StateDraging;             // 滑动状态
}

class RayBaseHeadView: UIView {
    
    //回调函数
    var action: (() -> ())? = {}
    
    var StateDragToRefreshHint = "下拉可以刷新";     //下拉可以刷新
    var StateLooseToRefreshHint = "放开手才能给你刷新数据...";    //松开立即刷新
    var  StateRefreshingHint = "客观别急，正在加载数据..."; //加载中
    
    var scrollView:UIScrollView?;
    
    //默认状态
    var state:RayHeadViewState = RayHeadViewState.StateDragToRefresh;

    /** 结束下拉刷新*/
    func completeDragRefresh(){
        self.setState(RayHeadViewState.StateDragToRefresh);
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView!.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
        })
    }
    
    /** 添加刷新时执行的函数*/
    func addAction(action :(() -> ())){
        self.action = action;
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if(self.scrollView == nil){ return;}
        let offsetY:CGFloat = self.scrollView!.contentOffset.y
        // 只有在 y<=0 以及 scrollview的高度不为0 时才判断
        if((offsetY > 0) || (self.scrollView!.bounds.size.height == 0)){return;}
        
        /** 将状态更为刷新中*/
        if(self.state == RayHeadViewState.StateLooseToRefresh && offsetY < -self.frame.height && !self.scrollView!.dragging){
            self.scrollView!.contentInset = UIEdgeInsetsMake(self.frame.height + 8, 0, 0, 0);
            self.setState(RayHeadViewState.StateRefreshing);
        }
        /** 下拉到头视图高度时提示松开刷新*/
        if(self.state == RayHeadViewState.StateDraging && offsetY < -self.frame.height){
            self.setState(RayHeadViewState.StateLooseToRefresh);
        }
        /** 往上推时更改状态*/
        if(self.state == RayHeadViewState.StateLooseToRefresh && offsetY > -self.frame.height && self.scrollView!.dragging){
            self.setState(RayHeadViewState.StateDragToRefresh);
        }
        /** 状态更改为滑动中*/
        if((self.state == RayHeadViewState.StateDragToRefresh || self.state == RayHeadViewState.StateDraging) && self.scrollView!.dragging){
            self.setState(RayHeadViewState.StateDraging);
        }

    }

    /** 默认状态时调用*/
    func tableviewStateDragToRefresh(){
        
    }
    
    /** 松开刷新时时调用*/
    func tableviewStateLooseToRefresh(){
        
    }
    
    /** 刷新中调用*/
    func tableviewStateRefreshing(){
        
    }
    
    /** 更改视图状态*/
    func setState(newsState:RayHeadViewState)
    {
                    

    }


    
    override func willMoveToSuperview(newSuperview: UIView?) {
        if (newSuperview != nil && newSuperview!.isKindOfClass(UIScrollView)) {
            self.scrollView = newSuperview as? UIScrollView
            newSuperview!.addObserver(self, forKeyPath: "contentOffset", options: .Initial, context: &KVOContext)
        }
    }
    
    
}
