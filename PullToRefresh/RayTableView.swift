 //
//  RayTableView.swift
//  RayPullToRefresh
//   下拉刷新上啦加载更多TableView
//  Created by ray on 15/11/6.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

/** 动画方式*/
enum RayTableViewAnimateType{
    case Default; //默认动画
    case Zoom; //缩放动画
}


class RayTableView: UITableView,UITableViewDelegate {
    
    /** 头部视图*/
    private var headView:RayBaseHeadView?;
    /** 底部视图*/
    private var footView:RayBaseFootView?;
    /** 头部视图高度*/
    private var dragHeaderHeight:CGFloat = 65;
    /** 底部视图高度*/
    private var dragFootHeight:CGFloat = 40;
    /** 是否在刷新中*/
    var headerRefreshing:Bool = false;
    /** 是否在上啦加载更多*/
    var footRefreshing:Bool = false;
    /** 动画方式*/
    var animateType:RayTableViewAnimateType = RayTableViewAnimateType.Default;

    
    /** 通过xib 加载视图时调用*/
    override func awakeFromNib() {
        super.awakeFromNib();
        print("-->");
    }
    
     /** 添加头部下拉刷新视图*/
    func addDragHeaderView()
    {
        switch(animateType){
        case RayTableViewAnimateType.Default: //默认动画
            self.headView = RayHeadView.viewFromNibNamed();
            self.headView!.frame = CGRectMake(0, -self.dragHeaderHeight, self.bounds.size.width, self.dragHeaderHeight);
            self.addSubview(headView!);
         //   self.headView!.indicatorHead.hidden = true;
            break;
        case RayTableViewAnimateType.Zoom: //缩放动画
            self.headView = RayHeadZoomView.viewFromNibNamed();
            self.headView!.frame = CGRectMake(0, -self.dragHeaderHeight, self.bounds.size.width, self.dragHeaderHeight);
            self.addSubview(headView!);
            break;
        }
    }
    
    /** 添加底部上啦加载更多视图*/
    func addDragFootView()
    {
        if(self.footView == nil){
            self.footView = RayFootView.viewFromNibNamed();
            self.footView!.frame = CGRectMake(0, -self.contentSize.height, self.bounds.size.width, self.dragFootHeight);
            self.addSubview(footView!);
            self.contentInset = UIEdgeInsetsMake(0, 0, dragFootHeight, 0);
        }
    }
    
    /** Tableview滑动是调用，根据y坐标展示顶部或者底部视图*/
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if(self.footView != nil){
            
            let  nowContentOffsetY:CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height;
            print("\(nowContentOffsetY)");
            if(footView!.state == RayFootViewState.StateDragToMore && nowContentOffsetY - scrollView.contentSize.height > self.dragFootHeight + 20){
                self.footView!.setState(RayFootViewState.StateLooseToMore);
            }
            if(footView!.state == RayFootViewState.StateLooseToMore && nowContentOffsetY - scrollView.contentSize.height < self.dragFootHeight + 20){
                self.footView!.setState(RayFootViewState.StateDragToMore);
            }
            
        }
    }
    
    /** 当滑动结束时调用，判断是否需要下拉刷新或者上啦加载更多功能*/
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        /**
        if(self.headView != nil && self.headView!.state == RayHeadViewState.StateLooseToRefresh
            && !headerRefreshing){
                self.headerRefreshing = true;
                self.contentInset = UIEdgeInsetsMake(self.dragHeaderHeight, 0, 0, 0);
                self.headView?.setState(RayHeadViewState.StateRefreshing);
        }*/
        
        if(self.footView != nil && self.footView!.state == RayFootViewState.StateLooseToMore){
            self.footView!.setState(RayFootViewState.StateRefreshing);
            self.footRefreshing = true;
        }
        
    }
    
    /** 添加下拉刷新功能，并传入下拉刷新时执行的方法*/
    func refresh(action :(() -> ())){
        self.addDragHeaderView();
        self.headView!.addAction(action);
    }
    
    /** 添加下拉刷新功能，并传入下拉刷新时执行的方法*/
    func refresh(animateType:RayTableViewAnimateType, action :(() -> ())){
        self.animateType = animateType;
        self.addDragHeaderView();
        self.headView!.addAction(action);
    }
    
    /** 添加上啦加载更多功能，并传入上啦加载更多时执行的方法*/
    func more(action :(() -> ())){
        self.addDragFootView();
        self.footView!.addAction(action);
    }
    
    /** 设置动画方式不设置为默认动画*/
    func setAnimateType(animateType:RayTableViewAnimateType!){
        if(self.headView != nil && animateType != nil){
       //     self.headView!.setAnimateType(animateType);
        }
    }
    
    /** 结束下拉刷新*/
    func completeDragRefresh(){
        self.headView!.completeDragRefresh();
    }
    
    /** 结束上啦加载多*/
    func completeDragMore(){ 
        self.footView?.completeDragMore();
    }

}
