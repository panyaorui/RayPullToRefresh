//
//  ViewController.swift
//  RayPullToRefresh
//
//  Created by ray on 15/11/6.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var tableView: RayTableView!
    
    var size = 5;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.refresh(RayTableViewAnimateType.Zoom) { () -> () in
            self.delay(2.0, closure: { () -> () in
                self.size = 1;
                self.tableView.reloadData();
                self.tableView.completeDragRefresh();
            })

        }
        
        self.tableView.more { () -> () in
            self.delay(2.0, closure: { () -> () in
                print("上啦加载更多...");
                self.size = self.size + 1;
                self.tableView.reloadData();
                self.tableView.completeDragMore();
            })
        }
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    /********   UITableViewDataSource   ******/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return size;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        let nib:UINib = UINib(nibName: "MainTableViewCell", bundle: NSBundle.mainBundle());
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell");
        let cell:MainTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MainTableViewCell;
        
        //漂浮效果
        cell.layer.shadowColor = UIColor.grayColor().CGColor;
        cell.layer.shadowOffset = CGSizeMake(1, 1);//偏移距离
        cell.layer.shadowOpacity = 0.5;//不透明度
        cell.layer.shadowRadius = 3.0;//半径
        // cell.clipsToBounds = false;
        
        return cell;
    }




}

