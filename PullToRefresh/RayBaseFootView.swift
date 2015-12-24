//
//  RayBaseFootView.swift
//  RayPullToRefresh
//
//  Created by ray on 15/11/18.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

var KVOContext = ""
class RayBaseFootView: UIView {
    
    var StateDragToMoreHint = "上啦加载更多";     //下拉可以刷新
    var StateLooseToMoreHint = "松开加载更多";    //松开立即刷新
    var  StateRefreshingHint = "加载中...";
    
    //回调函数
    var action: (() -> ())? = {}
    
    var scrollView:UIScrollView?;
    
    //默认状态
    var state:RayFootViewState = RayFootViewState.StateDragToMore;
    
    
    func addAction(action :(() -> ())){
        self.action = action;
    }
    
    // observeValueForKeyPath/
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if(keyPath == "contentOffset" && self.scrollView!.contentOffset.y > 0){
            let  nowContentOffsetY:CGFloat = self.scrollView!.contentOffset.y + self.scrollView!.frame.size.height;
            print("\(nowContentOffsetY - self.scrollView!.contentSize.height)---\(self.frame.size.height + 20)");
            if(self.state == RayFootViewState.StateLooseToMore && nowContentOffsetY - self.scrollView!.contentSize.height > self.frame.size.height + 20 && !self.scrollView!.dragging){
                self.setState(RayFootViewState.StateRefreshing);
            }
            
            if(self.state == RayFootViewState.StateDragToMore && nowContentOffsetY - self.scrollView!.contentSize.height > self.frame.size.height + 20 && self.scrollView!.contentOffset.y != 0){
                self.setState(RayFootViewState.StateLooseToMore);
            }
            if(self.state == RayFootViewState.StateLooseToMore && nowContentOffsetY - self.scrollView!.contentSize.height < self.frame.size.height + 20){
                self.setState(RayFootViewState.StateDragToMore);
            }
        }else if(keyPath == "contentSize"){
            if (self.scrollView!.contentSize.height == 0){
                self.frame.origin.y = 0
            }else if(self.scrollView!.contentSize.height < self.frame.size.height){
                self.frame.origin.y = self.scrollView!.frame.size.height - self.frame.height
            }else{
                self.frame.origin.y = self.scrollView!.contentSize.height
            }
        
        }
        
        
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        print("1212");
        self.scrollView = newSuperview as? UIScrollView;
        newSuperview!.addObserver(self, forKeyPath: "contentSize", options: .Initial, context: &KVOContext);
        newSuperview!.addObserver(self, forKeyPath: "contentOffset", options: .Initial, context: &KVOContext);
    }
    
    func setState(newsState:RayFootViewState)
    {
        
    }
    
    func completeDragMore(){
        self.setState(RayFootViewState.StateDragToMore);
        UIView.animateWithDuration(0.5, animations: { () -> Void in
         //   self.scrollView!.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.width, 0);
        })
    }

    



}
