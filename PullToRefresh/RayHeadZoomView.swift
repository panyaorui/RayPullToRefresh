//
//  RayHeadZoomView.swift
//  RayPullToRefresh
//
//  Created by ray on 15/11/18.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class RayHeadZoomView: RayBaseHeadView {
    
     /** 状态提示*/
    @IBOutlet weak var labelHint: UILabel!
     /** 缩放图片*/
    @IBOutlet weak var imageStaff: UIImageView!

    /** 根据xib文件获取RayHeadView视图*/
    class func viewFromNibNamed()->RayHeadZoomView
    {
        return NSBundle.mainBundle().loadNibNamed("RayHeadZoomView", owner: self, options: nil)[0] as! RayHeadZoomView;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.labelHint.frame = CGRectMake(0, 0,self.frame.size.width, self.labelHint.frame.size.height);
        self.zoomAnimate(0);
    }
    
    override func setState(newsState: RayHeadViewState) {
        self.state = newsState;
        switch(self.state){
        case RayHeadViewState.StateDragToRefresh: //下拉刷新
            self.labelHint.text = self.StateDragToRefreshHint;
            break;
        case RayHeadViewState.StateLooseToRefresh://松开刷新
            self.labelHint.text = self.StateLooseToRefreshHint;
            self.switchImageAnimate();
            break;
        case RayHeadViewState.StateRefreshing://刷新中
            self.labelHint.text = self.StateRefreshingHint;
            self.moveImageAnimate();
            if(self.action != nil){
                self.action!();
            }
            break;
        case RayHeadViewState.StateDraging: //滑动中
            let offsetY:CGFloat = self.scrollView!.contentOffset.y
            if(offsetY < 0){ //执行缩放动画
                self.zoomAnimate(-offsetY / self.frame.height);
            }
            break;
        }

    }
    
    override func completeDragRefresh() {
        super.completeDragRefresh();
        self.imageStaff.stopAnimating();
    }
    
    /** 缩放动画*/
    func zoomAnimate(progress:CGFloat)
    {
        self.imageStaff!.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(progress * 10, -20 * progress), CGAffineTransformMakeScale(progress, progress));
    }
    
    /** 图片切换动画*/
    func switchImageAnimate(){
        self.imageStaff!.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(10, -20), CGAffineTransformMakeScale(1, 1));
        self.imageStaff!.animationImages = [UIImage(named: "deliveryStaff0")!,UIImage(named: "deliveryStaff1")!,UIImage(named: "deliveryStaff2")!,UIImage(named: "deliveryStaff3")!]
        self.imageStaff?.startAnimating();
    }
    
    /** 移动动画*/
    func moveImageAnimate(){
        UIView.animateWithDuration(2.5, animations: { () -> Void in
            self.imageStaff.transform = CGAffineTransformConcat(
                CGAffineTransformMakeTranslation(200, -20), CGAffineTransformMakeScale(1, 1));
        })
        
    }

    

}
