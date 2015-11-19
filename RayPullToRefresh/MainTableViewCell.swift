//
//  MainTableViewCell.swift
//  Neighbour
//
//  Created by ray on 15/10/27.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell{
    
    
    /** 滑动图片内容展示区*/
    @IBOutlet weak var scrollImageView: UIView!
    /** 产品介绍*/
    @IBOutlet weak var labelIntroduce: UILabel!
    /** 回复*/
    @IBOutlet weak var labelReply: UILabel!
    /** 评论*/
    @IBOutlet weak var labelComment: UILabel!
    
    /**是否展示出了留言和收藏视图*/
    var isRightToLeft = false;
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        

    }
   
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
