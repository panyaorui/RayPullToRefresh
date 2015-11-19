# RayPullToRefresh
下拉刷新类库，支持自定义动画

###默认动画效果

![image](https://github.com/panyaorui/RayPullToRefresh/blob/master/效果图/02.gif)

###缩放动画效果

![image](https://github.com/panyaorui/RayPullToRefresh/blob/master/效果图/01.gif)

###使用说明
需要在ViewControll中设置self.automaticallyAdjustsScrollViewInsets = false;

###添加下拉刷新功能
```swift
self.tableView.refresh(RayTableViewAnimateType.Default) { () -> () in
            self.delay(2.0, closure: { () -> () in
                self.size = 1;
                self.tableView.reloadData();
                self.tableView.completeDragRefresh();
            })
        }
```
###添加上啦加载更多功能
```swift
 self.tableView.more { () -> () in
            self.delay(2.0, closure: { () -> () in
                print("上啦加载更多...");
                self.size = self.size + 1;
                self.tableView.reloadData();
                self.tableView.completeDragMore();
            })
        }
```
###实现自定义的下拉动画
###需要集成RayBaseHeadView基类实现
```swift
override func setState(newsState: RayHeadViewState) {
        self.state = newsState;
        switch(self.state){
        case RayHeadViewState.StateDragToRefresh: //下拉刷新
            break;
        case RayHeadViewState.StateLooseToRefresh://松开刷新
            break;
        case RayHeadViewState.StateRefreshing://刷新中
            break;
        case RayHeadViewState.StateDraging: //滑动中
            break;
        }

    }
```
