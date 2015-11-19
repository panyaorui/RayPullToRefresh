//
//  RayFootView.swift
//  RayPullToRefresh
//
//  Created by ray on 15/11/10.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

enum RayFootViewState{
    case StateDragToMore;     //下拉可以刷新
    case StateLooseToMore;    //松开立即刷新
    case  StateRefreshing;         //加载中...
}


class RayFootView: RayBaseFootView {
    
    @IBOutlet weak var labelHint: UILabel!
    
    class func viewFromNibNamed()->RayFootView
    {
        return NSBundle.mainBundle().loadNibNamed("RayFootView", owner: self, options: nil)[0] as! RayFootView;
    }
    
    override func setState(newsState:RayFootViewState)
    {
        self.state = newsState;
        switch(self.state){
        case RayFootViewState.StateDragToMore:
            self.labelHint.text = StateDragToMoreHint;
            break;
        case RayFootViewState.StateLooseToMore:
            self.labelHint.text = StateLooseToMoreHint;
                       break;
        case RayFootViewState.StateRefreshing:
            self.labelHint.text = StateRefreshingHint;
            //执行回调函数
            if(self.action != nil){
                self.action!();
            }
                      break;
        }
    }
    
}
